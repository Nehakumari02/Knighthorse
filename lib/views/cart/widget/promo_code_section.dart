part of '../screen/cart_screen.dart';

class PromoCodeSection extends GetView<CartController> {
  const PromoCodeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSize),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: CustomColor.primary),
                ),
                hintText: Strings.promoCode,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
              ),
            ),
          ),
          Sizes.width.v10,
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
            ),
            child: TextWidget(Strings.apply, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
