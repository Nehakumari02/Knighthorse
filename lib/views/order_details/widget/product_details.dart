part of '../screen/order_details_screen.dart';

class ProductDetails extends GetView<OrderDetailsController> {
  const ProductDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainMin,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * .13),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.orderItemsList.length,
            itemBuilder: (context, index) {
              final item = controller.orderItemsList[index];
              return _productDetails(
                context,
                title: item.name,
                quantity: item.quantity,
                price: item.price,
                image: item.image,
              );
            },
          ),
        ),
      ],
    );
  }

  _productDetails(
    BuildContext context, {
    required String title,
    required String quantity,
    required String price,
    required String image,
  }) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .8,
      child: Card(
        margin: EdgeInsets.only(
          right: Dimensions.widthSize,
          bottom: Dimensions.verticalSize * .5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * 0.6,
            vertical: Dimensions.verticalSize * 0,
          ),
          child: Column(
            mainAxisAlignment: mainCenter,
            mainAxisSize: mainMin,
            children: [
              Row(
                crossAxisAlignment: crossCenter,
                mainAxisSize: mainMin,
                children: [
                  CircleAvatar(
                    radius: Dimensions.radius * 3,
                    backgroundColor: CustomColor.disableColor,
                    backgroundImage:
                        NetworkImage("${controller.imagePath}/${image}"),
                  ),
                  Sizes.width.v10,
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: mainMin,
                      children: [
                        Row(
                          mainAxisAlignment: mainSpaceBet,
                          children: [
                            FittedBox(
                              child: TextWidget(
                                title,
                                fontWeight: FontWeight.w500,
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        TextWidget(
                          "${Strings.quantity}: $quantity",
                          fontSize: Dimensions.bodySmall,
                        ),
                        Row(
                          mainAxisAlignment: mainSpaceBet,
                          children: [
                            TextWidget(
                              "\Rs$price",
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
