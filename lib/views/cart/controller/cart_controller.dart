import 'dart:async';

import 'package:knighthorse/base/api/method/request_process.dart';
import 'package:knighthorse/base/api/model/common_success_model.dart';
import 'package:knighthorse/base/api/services/basic_services.dart';
import 'package:knighthorse/base/api/services/shipment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/assets.dart';
import '../../../base/api/endpoint/api_endpoint.dart';
import '../../../base/api/services/delivery_service.dart';
import '../../../base/utils/basic_import.dart';
import '../../../base/utils/cart_db_helper.dart';
import '../../../base/utils/local_storage.dart';
import '../../../routes/routes.dart';
import '../../auth section/auth_model/shipment_settings_model.dart';
import '../../congratulations/model/congratulations_model.dart';
import '../../congratulations/screen/congratulations_screen.dart';
import '../../payment/screen/payment_screen.dart';
import '../../profile/controller/profile_controller.dart';
import '../model/cart_model.dart';
import '../model/online_payment_model.dart';
import '../model/payment_gateway_model.dart';
import '../../update_profile/model/profile_info_model.dart';
import 'package:mailer/mailer.dart' as mail;
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  final CartDatabaseHelper _dbHelper = CartDatabaseHelper();
  var userType = "retailer".obs;
  var assignedSubAdmin = "".obs;
  var subAdminEmail = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (LocalStorage.isLoggedIn)
      _fetchUserType(); // 👈 2. FETCH TYPE ON LOAD
      getCartItems().then((_) {
        if (cartItems.isNotEmpty) updateCartProcess();
      });
    if (LocalStorage.isLoggedIn) getPaymentGatewaysProcess();
    loadCartFromDB();
    // _setCalculation();
    shipmentType = ShipmentServices.shipmentList;
    _checkDetailsValidity();
  }
  // 👇 3. LOGIC TO GET USER ROLE
  void _fetchUserType() async {
    await RequestProcess().request(
      apiEndpoint: ApiEndpoint.profileInfo,
      fromJson: ProfileInfoModel.fromJson,
      isLoading: false.obs,
      onSuccess: (response) {
        if (response != null) {
          userType.value = response.data.userInfo.user_type ?? "retailer";
          debugPrint("✅ Cart User Type: ${userType.value}");
          assignedSubAdmin.value = response.data.userInfo.assign_to ?? "";
          debugPrint("✅ Assigned Sub-Admin: ${assignedSubAdmin.value}");
          subAdminEmail.value = response.data.userInfo.assign_to_email ?? "";
          debugPrint("📧 Sub-Admin Email: ${subAdminEmail.value}"); // 👈 ADD THIS LINE
        }
      },
    );
  }

  RxList<CartDatum> cartItems = <CartDatum>[].obs;

  // Future<void> loadCartFromDB() async {
  //   cartItems.clear();
  //   final items = await _dbHelper.getAllCartItems();
  //   cartItems.assignAll(items);
  //   _setCalculation();
  // }

  Future<void> loadCartFromDB() async {
    cartItems.clear();

    final items = await _dbHelper.getAllCartItems();

    debugPrint("🟢 CART FROM DB → Total items: ${items.length}");

    for (int i = 0; i < items.length; i++) {
      debugPrint("🟢 DB ITEM [$i]: ${items[i]}");
    }

    cartItems.assignAll(items);
    _setCalculation();
  }




  Future<void> _sendOrderEmailToAdmin() async {
    // 1. Credentials
    String username = 'Application.knighthorse@gmail.com';
    String password = 'mjxp hzcp ivud rxsn';
    final smtpServer = gmail(username, password);

    // 2. RECIPIENT LOGIC
    String recipientEmail;
    if (assignedSubAdmin.value.trim().isEmpty ||
        assignedSubAdmin.value.toLowerCase() == "superadmin" ||
        subAdminEmail.value.trim().isEmpty) {
      recipientEmail = 'Application.knighthorse@gmail.com';
    } else {
      recipientEmail = subAdminEmail.value.trim();
    }

    // 3. FETCH CUSTOMER DETAILS (Using ProfileController)
    final profile = Get.find<ProfileController>();

    // 4. BUILD EMAIL BODY
    StringBuffer body = StringBuffer();
    body.writeln("          NEW ORDER RECEIVED            ");
    body.writeln("----------------------------------------");

    // Display Order ID from the checkout response message
    // Usually, the message contains "Order placed successfully. ID: #12345"
    body.writeln("Order Status: ${_checkOutModel.message.success.first}");
    body.writeln("----------------------------------------");
    body.writeln("CUSTOMER DETAILS:");
    body.writeln("Name     : ${profile.userName.value}");
    body.writeln("Email    : ${emailController.text}");
    body.writeln("Phone    : ${phoneController.text}");
    body.writeln("Address  : ${addressController.text}");
    body.writeln("----------------------------------------");
    body.writeln("ORDER ITEMS:");

    for (var item in cartItems) {
      body.writeln("- ${item.name} x ${item.quantity.value}");
    }

    body.writeln("----------------------------------------");
    body.writeln("Assigned To: ${assignedSubAdmin.value.isEmpty ? 'Superadmin' : assignedSubAdmin.value}");

    // 5. Create the Message
    final message = mail.Message()
      ..from = mail.Address(username, 'Knighthorse App')
      ..recipients.add(recipientEmail)
    // Subject line now uses Phone and Status instead of Grand Total
      ..subject = 'New Order - ${profile.userName.value}'
      ..text = body.toString();

    // 6. Send
    try {
      await mail.send(message, smtpServer);
      debugPrint('✅ Email Sent Successfully to: $recipientEmail');
    } catch (e) {
      debugPrint('🔴 Failed to send email: $e');
    }
  }

  Future<void> addToCart(CartDatum item) async {
    final index = cartItems.indexWhere((e) => e.id == item.id);
    // Check limit for existing item


    if (index != -1) {
      int pLimit = cartItems[index].purchaseLimit ?? 1000;
      debugPrint("🔍 CHECKING LIMIT: [${cartItems[index].name}] -> Limit: $pLimit | Current Qty: ${cartItems[index].quantity.value}");      if (pLimit == 0) pLimit = 1000;
      // 1. If item already exists, increase by 1 (10 -> 11 -> 12)
      if (cartItems[index].quantity.value < pLimit) {
        cartItems[index].quantity.value++;
        await _dbHelper.updateCartItem(cartItems[index]);
        _debounceUpdate(cartItems[index]);
      }
      else {
        // ADDED THIS LINE: Show error if they try to exceed 10
        CustomSnackBar.error("Maximum 1000 items allowed per product");
      }
    } else {
      // 2. If item is NEW, start directly at 10
      // item.quantity.value = 1;

      await _dbHelper.insertCartItem(item);
      cartItems.add(item);
      _listenToQuantity(item);
      if (LocalStorage.isLoggedIn) {
        updateCartProcess();
      }
    }
    _setCalculation();
  }

  Future<void> updateCart(CartDatum item) async {
    await _dbHelper.updateCartItem(item);
    int index = cartItems.indexWhere((e) => e.id == item.id);
    if (index != -1) cartItems[index] = item;
    _setCalculation();
  }

  Future<void> removeFromCart(String id) async {
    await _dbHelper.deleteCartItem(id);
    cartItems.removeWhere((e) => e.id == id);
    if (LocalStorage.isLoggedIn) deleteFromCart(id);
  }

  Future<void> clearCart() async {
    await _dbHelper.clearCart();
    cartItems.clear();
  }

  var selectedDates = <RxString>[].obs;
  final selectedTimes = <RxString>[].obs;

  void initializeSelectedTimes(int count) {
    if (selectedTimes.length != count) {
      selectedTimes.value = List.generate(count, (_) => ''.obs);
    }
    if (selectedDates.length != count) {
      selectedDates.value = List.generate(count, (_) => ''.obs);
    }
  }

  Timer? _updateTimer;

  late RxList<Shipment> shipmentType;
  var subtotal = 0.0.obs;
  var discount = 0.0.obs;
  var total = 0.0.obs;

  var totalCost = 0.0.obs;

  var productButonId = ''.obs;
  var itemQuantity = 1.obs;
  var cartId = 0.obs;

  var currencySymbol = BasicServices.baseCurrency.value?.symbol ?? "";
  var imagePath =
      "${BasicServices.basePath.value}/${BasicServices.productPathLocation.value}/";

  var _isDataLoading = false.obs;
  bool get isDataLoading => _isDataLoading.value;

  late CartModel _cartModel;
  CartModel get cartModel => _cartModel;
  Future<CartModel?> getCartItems() async {
    return RequestProcess().request(
        fromJson: CartModel.fromJson,
        apiEndpoint: ApiEndpoint.userCart,
        isLoading: _isDataLoading,
        onSuccess: (value) {
          _cartModel = value!;
          _setCartData();
        });
  }

  var cartLen = 0.obs;

  Future<void> _setCartData() async {
    cartId.value = _cartModel.data.userCart?.id ?? 0;
    final apiCart = _cartModel.data.cartData;
    final localCart = await _dbHelper.getAllCartItems();

    cartItems.clear();

    if (localCart.isEmpty) {
      // No need to merge, directly use apiCart
      for (var item in apiCart) {
        cartItems.add(item);
        _listenToQuantity(item);
      }
      // _setCalculation();
    } else {
      final mergedCart = <CartDatum>[];

      for (var apiItem in apiCart) {
        debugPrint(
            "🌐 API ITEM → ${apiItem.name} | purchaseLimit: ${apiItem.purchaseLimit}"
        );

        final match =
            localCart.firstWhereOrNull((local) => local.id == apiItem.id);

        if (match != null) {
          final combinedQuantity = match.quantity.value;
          mergedCart.add(
            CartDatum(
              id: apiItem.id,
              name: apiItem.name,
              price: apiItem.price,
              mainPrice: apiItem.mainPrice,
              shipmentType: apiItem.shipmentType,
              offerPrice: apiItem.offerPrice,
              image: apiItem.image,
              quantity: combinedQuantity,
              availableQuantity: apiItem.availableQuantity,
              purchaseLimit: apiItem.purchaseLimit, // 👈 ADD THIS LINE

            ),
          );
        } else {
          mergedCart.add(apiItem);
        }
      }

      for (var localItem in localCart) {
        final existsInApi = apiCart.any((api) => api.id == localItem.id);
        if (!existsInApi) mergedCart.add(localItem);
      }

      await _dbHelper.clearCart();
      // for (var item in mergedCart) {
      //   await _dbHelper.insertCartItem(item);
      // }

      for (var item in mergedCart) {

        cartItems.add(item);
        debugPrint("📦 Product: ${item.name} | Purchase Limit: ${item.purchaseLimit}");
        _listenToQuantity(item);
      }
    }
    _setCalculation();
    cartLen.value = cartItems.length;
  }

  void _listenToQuantity(CartDatum item) {
    ever(item.quantity, (_) {

      updateCart(item).then((_){
        _setCalculation();
      });
    });
  }

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

void _setCalculation() {
  debugPrint("+++++++++++++++ Calculation Start +++++++++++++++");

  subtotal.value = 0.0;
  discount.value = 0.0;
  total.value = 0.0;

    if (cartItems.isEmpty) {
    debugPrint("Cart is empty → nothing to calculate");
    return;
  }

  for (var item in cartItems) {
    final quantity = item.quantity.value;
    final mainPrice = _toDouble(item.mainPrice);
    final offerPrice = _toDouble(item.offerPrice);


    subtotal.value += mainPrice * quantity;

    if (offerPrice > 0 && offerPrice < mainPrice) {
      discount.value += (mainPrice - offerPrice) * quantity;
    }
  }

  total.value = subtotal.value - discount.value;

  debugPrint("Subtotal: ${subtotal.value}");
  debugPrint("Discount: ${discount.value}");
  debugPrint("Total: ${total.value}");
  debugPrint("+++++++++++++++ Calculation Done +++++++++++++++");
}


void deliverySet() {
  double calculatedDeliveryCharge = 0.0;

  if (selectedDelivaryType.value == 1) {
    calculatedDeliveryCharge = double.tryParse(shipmentType[selectedDelivaryType.value].deliveryCharge) ?? 0.0;
  } else {
    final Set<String> usedShipmentIds = cartItems
        .where((item) => item.shipmentType != null)
        .map((item) => item.shipmentType!)
        .toSet();

    for (var shipment in shipmentType) {
      if (usedShipmentIds.contains(shipment.id.toString())) {
        calculatedDeliveryCharge +=
            double.tryParse(shipment.deliveryCharge) ?? 0.0;
      }
    }
  }

  deliveryCharge.value = calculatedDeliveryCharge;
  totalCost.value = total.value + deliveryCharge.value;

  print('Calculated delivery charge: $calculatedDeliveryCharge');
  print('Total cost: ${totalCost.value}');
}

  var _isUpdating = false.obs;
  bool get isUpdating => _isUpdating.value;

  late CommonSuccessModel _cartUpdateModel;
  CommonSuccessModel get cartUpdateModel => _cartUpdateModel;

  Future<CommonSuccessModel?> updateCartProcess() async {
    Map<String, dynamic> inputBody = {};
    double itemSubTotal = 0;

    for (int i = 0; i < cartItems.length; i++) {
      final item = cartItems[i];
      // Inside the for loop in updateCartProcess
      debugPrint("📤 SENDING CART UPDATE BODY22: ${cartItems[i].purchaseLimit}");

      inputBody['cart[$i][id]'] = item.id;
      inputBody['cart[$i][name]'] = item.name;
      inputBody['cart[$i][price]'] = item.price;
      inputBody['cart[$i][main_price]'] = item.mainPrice;
      inputBody['cart[$i][offer_price]'] = item.offerPrice;
      inputBody['cart[$i][image]'] = item.image;
      inputBody['cart[$i][quantity]'] = item.quantity.toString();
      inputBody['cart[$i][purchase_limit]'] = item.purchaseLimit;
      inputBody['cart[$i][available_quantity]'] =
          item.availableQuantity.toString();
      inputBody['cart[$i][shipment_type]'] = item.shipmentType.toString();

      itemSubTotal += double.tryParse(item.price) != null
          ? double.parse(item.price) * item.quantity.value
          : 0;
    }
    inputBody['sub_total'] = itemSubTotal.toStringAsFixed(2);
    debugPrint("📤 SENDING CART UPDATE BODY: $inputBody");
    return RequestProcess().request(
        fromJson: CommonSuccessModel.fromJson,
        apiEndpoint: ApiEndpoint.cartUpdate,
        isLoading: _isUpdating,
        method: HttpMethod.POST,
        body: inputBody,
        fieldList: [],
        pathList: [],
        onSuccess: (value) {
          _cartUpdateModel = value!;
          getCartItems();
          debugPrint("<<<<<<<<<<<<<<< updating >>>>>>>>>>>>>>>>>>");
        });
  }

  Rxn<Currency> selectedGateway = Rxn();
  RxList<Currency> gateWayList = <Currency>[].obs;
  var gatewayImagePath = "".obs;

  var _isPaymentGateWayLoading = false.obs;
  bool get isPaymentgatewayLoading => _isPaymentGateWayLoading.value;
  late PaymentGatewaysModel _gatewayModel;
  PaymentGatewaysModel get gatewayModel => _gatewayModel;

  Future<PaymentGatewaysModel?> getPaymentGatewaysProcess() async {
    return RequestProcess().request(
        fromJson: PaymentGatewaysModel.fromJson,
        apiEndpoint: ApiEndpoint.paymentGateWays,
        isLoading: _isPaymentGateWayLoading,
        onSuccess: (value) {
          _gatewayModel = value!;
          _setGatewayData();
        });
  }

  _setGatewayData() {
    gateWayList.clear();
    _gatewayModel.data.paymentGateways.forEach((e) {
      gateWayList.addAll(e.currencies);
    });
    selectedGateway.value = gateWayList.first;
    gatewayImagePath.value =
        "${_gatewayModel.data.imagePath.baseUrl}/${_gatewayModel.data.imagePath.pathLocation}/";
  }

  void _debounceUpdate(CartDatum item) {
    _updateTimer?.cancel();
    _updateTimer = Timer(Duration(seconds: 1), () {
      updateCart(item).then((_) {
        if (LocalStorage.isLoggedIn) {
          updateCartProcess();
        }
      });
    });
  }

  void increaseQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = cartItems[index];
      final currentQty = item.quantity.value;
      final availableQty = int.parse(item.availableQuantity!);

      int pLimit = item.purchaseLimit ?? 1000;      if (pLimit == 0) pLimit = 1000;
      debugPrint("🔍 CHECKING LIMIT increase function: [${cartItems[index].name}] -> Limit: $pLimit | Current Qty: ${cartItems[index].quantity.value}");
      if (currentQty < pLimit) {
        if (currentQty < availableQty) {
          item.quantity.value++;
          _debounceUpdate(item);
        } else {
          CustomSnackBar.error(Strings.cannotAddMore);
        }
      }else{
        CustomSnackBar.error("You cannot add more than $pLimit units of this item");
      }
    }
  }

  void decreaseQuantity(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = cartItems[index];
      final currentQty = item.quantity.value;

      // Change logic here: If greater than 10, decrease.
      // If 10 (or less), remove the item.
      if (currentQty > 1) {
        item.quantity.value--;
        _debounceUpdate(item);
      } else {
        cartItems.removeAt(index);
        if (LocalStorage.isLoggedIn) deleteFromCart(item.id);
        removeFromCart(item.id);
        _setCalculation();
      }
    }
  }

  var selectedDelivaryType = 1.obs;
  var selectedDelivaryTypeName = "together".obs;
  List deliveryTypeOptions = [
    Strings.separateDelivery,
    Strings.togatherDelivery
  ];

  final phoneController = TextEditingController();
  late TextEditingController emailController = TextEditingController(text: Get.find<ProfileController>().userEmail.value);
  final addressController = TextEditingController();
  final orderNoteController = TextEditingController();

  var isDetailsValid = false.obs;
  _updateDetailsValidity(){
    isDetailsValid.value =  addressController.text.isNotEmpty;
  }

  _checkDetailsValidity(){
    phoneController.addListener(_updateDetailsValidity);
    addressController.addListener(_updateDetailsValidity);
  }


  var _isCheckingOut = false.obs;
  bool get isCheckingOut => _isCheckingOut.value;

  late CommonSuccessModel _checkOutModel;
  CommonSuccessModel get checkOutModel => _checkOutModel;

  late OnlinePaymentModel _onlinePaymentModel;
  OnlinePaymentModel get onlinePaymentModel => _onlinePaymentModel;
  Future<dynamic> checkoutProcess() async {

    // ======================================================
    // 1. CALCULATE DEFAULTS (The Fix)
    // ======================================================

    // A. Default Date (10 Days Later)
    String defaultDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: 10)));

    // B. Default Time (09:00 AM - 06:00 PM)
    String defaultStart = "09:00";
    String defaultEnd = "18:00";

    // Helper function to safe-guard empty values
    String safeDate(String? input) {
      return (input == null || input.isEmpty) ? defaultDate : input;
    }

    String safeStartTime(String? input) {
      return (input == null || input.isEmpty) ? defaultStart : input;
    }

    String safeEndTime(String? input) {
      return (input == null || input.isEmpty) ? defaultEnd : input;
    }

    Map<String, dynamic> inputBody = {
      "cart_id": cartId.value.toString(),
      "address": addressController.text,
      "phone": phoneController.text,
      "notes": orderNoteController.text,
      "email": emailController.text,
      if (paymentMethod.value == "online")
        "currency": selectedGateway.value!.alias,
      "payment_method": paymentMethod.value,
      "delivery_charge": deliveryCharge.value.toString(),
      "amount": total.value.toString(),
      "total_cost": totalCost.value.toString(),
      "reusable_bag": isChecked.value ? reusableBagPrice.value.toString() : "0",
      "delivery_type": selectedDelivaryTypeName.value,
    };

    // ======================================================
    // 2. APPLY DEFAULTS TO DELIVERY TYPE LOGIC
    // ======================================================

    if (selectedDelivaryType.value == 1) {
      // Logic for "Together" Delivery
      final date = selectedDates.isNotEmpty ? selectedDates[0].value : "";
      final time = selectedTimes.isNotEmpty ? selectedTimes[0].value : "";
      final parts = time.split("-");

      String rawStart = parts.isNotEmpty ? parts[0] : "";
      String rawEnd = parts.length > 1 ? parts[1] : "";

      // ✅ Apply Defaults
      inputBody["together_time_slot_start"] = safeStartTime(rawStart);
      inputBody["together_time_slot_end"] = safeEndTime(rawEnd);
      inputBody["together_delivery_date"] = safeDate(date);

    } else {
      // Logic for "Separate" Delivery
      for (int i = 0; i < shipmentType.length; i++) {
        final shipmentId = shipmentType[i].id;
        final date = selectedDates.length > i ? selectedDates[i].value : "";
        final time = selectedTimes.length > i ? selectedTimes[i].value : "";
        final parts = time.split("-");

        String rawStart = parts.isNotEmpty ? parts[0] : "";
        String rawEnd = parts.length > 1 ? parts[1] : "";

        // ✅ Apply Defaults per shipment
        inputBody["time_slots[$shipmentId][start]"] = safeStartTime(rawStart);
        inputBody["time_slots[$shipmentId][end]"] = safeEndTime(rawEnd);
        inputBody["delivery_date[$shipmentId]"] = safeDate(date);
      }
    }

    if (paymentMethod.value == "cash" || paymentMethod.value == "wallet") {
      debugPrint("🚀 Checkout Body: $inputBody"); // Print to verify
      return RequestProcess().request(
        fromJson: CommonSuccessModel.fromJson,
        apiEndpoint: ApiEndpoint.checkOutByCash,
        method: HttpMethod.POST,
        pathList: [],
        fieldList: [],
        body: inputBody,
        isLoading: _isCheckingOut,
        onSuccess: (value) {
          _checkOutModel = value!;
          _sendOrderEmailToAdmin();
          debugPrint("Complete cash${_checkOutModel}");
          _goToConfirmScreen();
        },
      );
    } else {
      debugPrint("🚀 Checkout Body: $inputBody");
      return RequestProcess().request(
        fromJson: OnlinePaymentModel.fromJson,
        apiEndpoint: ApiEndpoint.checkOutByOnline,
        method: HttpMethod.POST,
        body: inputBody,
        pathList: [],
        fieldList: [],
        isLoading: _isCheckingOut,
        onSuccess: (value) {
          debugPrint("Complete online");
          _onlinePaymentModel = value!;
          debugPrint("Complete ${_onlinePaymentModel}");
          Get.to(WebPaymentScreen());
        },
      );
    }
  }

  var _isDeleting = false.obs;
  bool get isDeleting => _isDeleting.value;
  late CommonSuccessModel _deleteModel;
  CommonSuccessModel get deleteModel => _deleteModel;

  Future<CommonSuccessModel?> deleteFromCart(String id) async {
    Map<String, dynamic> inputBody = {"product_id": id};
    return RequestProcess().request(
        fromJson: CommonSuccessModel.fromJson,
        apiEndpoint: ApiEndpoint.itemDelete,
        isLoading: _isDeleting,
        body: inputBody,
        method: HttpMethod.POST,
        onSuccess: (value) {
          _deleteModel = value!;
          getCartItems();
        });
  }

  _goToConfirmScreen() {
    Congratulation congratulation = Congratulation(
      details: _checkOutModel.message.success.first,
      route: Routes.navigation,
      buttonText: Strings.backToHome,
      type: Strings.cashOnDelivary,
    );
    Get.to(
      () => CongratulationsScreen(),
      arguments: congratulation,
    )?.then((_) {
      clearCart();
    });
  }

  //  payment

  var deliveryCharge = 0.0.obs;
  var walletBalance = LocalStorage.isLoggedIn
      ? Get.put(ProfileController()).walletBalance.obs
      : "0.0".obs;
  var reusableBagPrice = DeliveryServices.bagPrice.value.obs;

  var isChecked = false.obs;

  void toggle() {
    isChecked.value = !isChecked.value;
  }

  void toggleReusableBag(bool value) {
    isChecked.value = value;

    if (isChecked.value) {
      totalCost.value += reusableBagPrice.value;
    } else {
      totalCost.value -= reusableBagPrice.value;
    }
  }

  var selectedMethod = 0.obs;
  var paymentMethod = "cash".obs;

  List paymentMethodList = [
    {
      "image": Assets.icons.cashOnDelivary,
      "title": Strings.cashOnDelivary,
      "method": "cash"
    },
    {
      "image": Assets.icons.wallet,
      "title": Strings.walletPayment,
      "method": "wallet"
    },
    {
      "image": Assets.icons.onlinePayment,
      "title": Strings.onlinePayment,
      "method": "online"
    }
  ];
}
