part of '../screen/payment_screen.dart';

class PaymentMethods extends GetView<CartController> {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalSize,
          vertical: Dimensions.verticalSize * .8,
        ),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            TextWidget(
              Strings.paymentMethods,
              fontSize: Dimensions.titleMedium * 1.25,
              fontWeight: FontWeight.w500,
            ),
            DividerWidget(),
            Sizes.height.v10,
            _methodList(context)
          ],
        ),
      ),
    );
  }

  _methodList(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Obx(
      () => Column(children: [
        ...List.generate(controller.paymentMethodList.length, (index) {
          var data = controller.paymentMethodList[index];
          if (data["method"] == "wallet") {
            final walletBalance = double.tryParse(
                    Get.find<ProfileController>().walletBalance.value) ??
                0;
            if (controller.total.value <= walletBalance) {
              return _methodCard(data['image'], data['title'], index);
            } else {
              return const SizedBox();
            }
          }
          return _methodCard(data['image'], data['title'], index);
        }),
        Visibility(
          visible: controller.paymentMethod.value == "online",
          child: Padding(
            padding: EdgeInsets.only(
              bottom: Dimensions.verticalSize * .7,
            ),
            child: CustomDropDown(
              itemsList: cartController.gateWayList,
              selectMethod: cartController.selectedGateway.value!.name.obs,
              enableLeading: true,
              leadingAsset: "".obs,
              leadingPath: cartController.gatewayImagePath.value,
              fieldPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.horizontalSize * .5,
              ),
              onChanged: (value) {
                cartController.selectedGateway.value = value;
              },
            ),
          ),
        ),
        PlaceOrderButton()
      ]),
    );
  }

  _methodCard(String image, String label, int index) {
    return Obx(() {
      var isSelected = controller.selectedMethod.value == index;
      return GestureDetector(
        onTap: () {
          controller.selectedMethod.value = index;
          controller.paymentMethod.value =
              controller.paymentMethodList[index]["method"];

          debugPrint(controller.paymentMethod.value);
        },
        child: Card(
          margin: EdgeInsets.only(
            bottom: Dimensions.verticalSize * .7,
          ),
          color: isSelected ? CustomColor.primary : CustomColor.whiteColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.horizontalSize,
              vertical: Dimensions.verticalSize * .5,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  image,
                  height: Dimensions.heightSize * 3,
                ),
                Sizes.width.v10,
                TextWidget(label)
              ],
            ),
          ),
        ),
      );
    });
  }
}
