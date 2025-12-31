import 'package:knighthorse/base/api/endpoint/api_endpoint.dart';
import 'package:knighthorse/base/api/services/shipment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

import '../../../base/api/method/request_process.dart';
import '../../../base/api/services/basic_services.dart';
import '../../orders/controller/orders_controller.dart';
import '../model/order_details_model.dart';
import '../../update_profile/model/profile_info_model.dart';

class OrderDetailsController extends GetxController {
  @override
  void onInit() {
    fetchUserType();
    getOrderDetailsProcess();
    super.onInit();
  }

  // Observables
  var userType = "".obs;
  var username = "".obs; // 👈 1. ADDED USERNAME OBSERVABLE

  var trackingNumber = "".obs;
  var deliveryDate = "".obs;
  var deliveryTime = "".obs;
  var shippingMethod = "".obs;

  var deliveryCharge = "".obs;
  var reusableBag = "".obs;
  var currencySymbol = "".obs;
  var subTotal = "".obs;
  var totalAmount = "".obs;

  var paymentGatewayCharge = "".obs;
  var paymentMethod = "".obs;
  var transactionID = "".obs;
  var orderStatus = 0.obs;
  var orderDate = "".obs;
  var imagePath = "${BasicServices.basePath}/${BasicServices.productPathLocation}".obs;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final orderNoteController = TextEditingController();
  var fetchedUserType = "".obs;

  RxList<Product> orderItemsList = <Product>[].obs;

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  late OrderDetailsModel _orderDetailsModel;
  OrderDetailsModel get orderDetailsModel => _orderDetailsModel;

  // ==========================================
  // 1. FETCH USER TYPE & USERNAME
  // ==========================================
  void fetchUserType() async {
    await RequestProcess().request(
      apiEndpoint: ApiEndpoint.profileInfo,
      fromJson: ProfileInfoModel.fromJson,
      isLoading: false.obs,
      onSuccess: (response) {
        if (response != null) {
          userType.value = response.data.userInfo.user_type ?? "retailer";

          // 👈 2. FETCH USERNAME HERE
          // Adjust 'username' key based on your actual ProfileInfoModel
          username.value = response.data.userInfo.username ?? "Guest";

          debugPrint("✅ Order Details - User Type: ${userType.value}, Username: ${username.value}");
        }
      },
    );
  }

  // ==========================================
  // 2. FETCH ORDER DETAILS
  // ==========================================
  Future<OrderDetailsModel?> getOrderDetailsProcess() async {
    Map<String, dynamic> inputBody = {
      "uuid": Get.find<OrdersController>().orderId.value
    };
    return RequestProcess().request(
        fromJson: OrderDetailsModel.fromJson,
        apiEndpoint: ApiEndpoint.orderDetails,
        body: inputBody,
        method: HttpMethod.POST,
        isLoading: _isLoading,
        onSuccess: (value) {
          _orderDetailsModel = value!;
          _setOrderData();
          _setCartData();
          _setDeliveryData();
          _setShipmentData();
          _setPaymentData();
          currencySymbol.value = _orderDetailsModel.data.currencySymbol;
        });
  }

  _setOrderData() {
    orderItemsList.clear();
    orderItemsList.addAll(_orderDetailsModel.data.bookingData.products);
  }

  _setDeliveryData() {
    var data = _orderDetailsModel.data.bookingData.deliveryInfo;
    phoneController.text = data.phone;
    emailController.text = data.email;
    addressController.text = data.address;
    orderNoteController.text = data.notes;
    reusableBag.value = data.reusableBag;
  }

  _setCartData() {
    var data = _orderDetailsModel.data.bookingData.userCart;
    subTotal.value = data.subTotal;
    totalAmount.value = data.total;
    deliveryCharge.value = data.deliveryCharge;
  }

  _setShipmentData() {
    if (_orderDetailsModel.data.transaction.orderShipment.isEmpty) {
      trackingNumber.value = "N/A";
      shippingMethod.value = "N/A";
      return;
    }

    var data = _orderDetailsModel.data.transaction.orderShipment.first;
    trackingNumber.value = data.trackingNumber;
    deliveryDate.value = DateFormat("yyyy-MM-dd").format(data.deliveryDate);
    deliveryTime.value = "${data.startTime}-${data.endTime}";

    var method = ShipmentServices.shipmentList
        .firstWhere((e) => e.id == data.shipmentId.toInt(),
        orElse: () => ShipmentServices.shipmentList.first);

    shippingMethod.value = method.name;
  }

  _setPaymentData() {
    var data = _orderDetailsModel.data.transaction;
    transactionID.value = data.trxId;
    orderDate.value = data.createdAt;
    orderStatus.value = data.status;
    paymentMethod.value = data.paymentMethod;
    paymentGatewayCharge.value =
        double.parse(data.paymentGatewayCharge).toStringAsFixed(2);
  }

  // ==========================================
  // 3. PDF GENERATION LOGIC
  // ==========================================
  Future<void> generateInvoice() async {
    final doc = pw.Document();

    final font = await PdfGoogleFonts.nunitoRegular();
    final fontBold = await PdfGoogleFonts.nunitoBold();

    bool isWholesaler = userType.value.toLowerCase().contains("wholesaler");
    String unitLabel = isWholesaler ? "Box" : "Piece";
    String docTitle = isWholesaler ? "Order" : "Estimate";

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: pw.ThemeData.withFont(base: font, bold: fontBold),
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
        ),
        build: (pw.Context context) {
          return [
            // HEADER
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(docTitle,
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Knight Horse",
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Order #${transactionID.value}"),
                    pw.Text(orderDate.value),
                  ],
                )
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.SizedBox(height: 10),

            // BILLING & STATUS INFO
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Bill To:",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),

                    // 👈 3. REPLACED EMAIL WITH USERNAME
                    pw.Text("Name: ${username.value}"),

                    pw.Text(phoneController.text),
                    pw.SizedBox(
                        width: 200, child: pw.Text(addressController.text)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Status: ${_getStatusString(orderStatus.value)}"),
                  ],
                )
              ],
            ),
            pw.SizedBox(height: 30),

            // PRODUCT TABLE
            pw.Table.fromTextArray(
              headers: isWholesaler
                  ? ['Product', 'Sub Category', 'Qty', 'Price/ piece']
                  : ['Product', 'Sub Category', 'Qty', 'Price/ piece', 'Total'],

              headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.black),

              data: orderItemsList.map((item) {
                double price = double.tryParse(item.price) ?? 0;
                double qty = double.tryParse(item.quantity) ?? 0;

                String subCat = (item.subCategory == null || item.subCategory == "")
                    ? "-"
                    : item.subCategory!;

                String qtyString = "${item.quantity} $unitLabel";

                if (isWholesaler) {
                  return [
                    item.name,
                    subCat,
                    qtyString,
                    "${currencySymbol.value} ${item.price}",
                  ];
                } else {
                  return [
                    item.name,
                    subCat,
                    qtyString,
                    "${currencySymbol.value} ${item.price}",
                    "${currencySymbol.value} ${(price * qty).toStringAsFixed(2)}",
                  ];
                }
              }).toList(),

              cellAlignments: isWholesaler
                  ? {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.center,
                3: pw.Alignment.centerRight,
              }
                  : {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.center,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
              },
            ),
            pw.SizedBox(height: 20),

            // TOTALS SECTION (Retailer Only)
            if (!isWholesaler) ...[
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                        "Subtotal: ${currencySymbol.value} ${subTotal.value}"),
                    pw.Text(
                        "Delivery: ${currencySymbol.value} ${deliveryCharge.value}"),
                    if (double.tryParse(paymentGatewayCharge.value) != null &&
                        double.parse(paymentGatewayCharge.value) > 0)
                      pw.Text(
                          "Gateway Charge: ${currencySymbol.value} ${paymentGatewayCharge.value}"),
                    pw.Divider(),
                    pw.Text(
                        "Grand Total: ${currencySymbol.value} ${totalAmount.value}",
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
            ],

            // FOOTER
            pw.SizedBox(height: 50),
            pw.Center(
              child: pw.Text("This is an estimated value, not an actual invoice.",
                  style: const pw.TextStyle(color: PdfColors.grey)),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
      name: '${docTitle}_${transactionID.value}.pdf',
    );
  }

  String _getStatusString(int status) {
    switch (status) {
      case 1: return "Completed";
      case 2: return "Progress";
      case 3: return "Hold";
      case 4: return "Cancelled";
      default: return "Unknown";
    }
  }
}