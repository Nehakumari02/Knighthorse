// details_screen.dart

part of '../screen/details_screen.dart';

class ProductDetails extends GetView<DetailsController> {
  ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Logic for Offer calculation
    final bool hasOffer = double.parse(
        controller.selectedProduct.value!.offerPrice ?? "0.0") <
        double.parse(controller.selectedProduct.value!.price) &&
        double.parse(controller.selectedProduct.value!.offerPrice ?? "0.0") !=
            0.0;

    return Column(
      crossAxisAlignment: crossStart,
      children: [
        // ---------------------------------------------
        // 1. MAIN DISPLAY IMAGE (Dynamic)
        // ---------------------------------------------
        Obx(() {
          // If currentImage is empty (loading), use default product image
          String imgToDisplay = controller.currentImage.value.isEmpty
              ? controller.selectedProduct.value!.image
              : controller.currentImage.value;

          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(Dimensions.verticalSize * 0.5),
            child: Image.network(
              "${controller.imagePath}$imgToDisplay",
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported, size: 50),
            ),
          );
        }),

        Sizes.height.v10,

        // ---------------------------------------------
        // 2. THUMBNAIL LIST (Variants)
        // ---------------------------------------------
        _buildImageGallery(),

        Sizes.height.v15,

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * 0.75,
          ),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              TextWidget(
                controller.selectedProduct.value!.data.name,
                typographyStyle: TypographyStyle.titleLarge,
                fontWeight: FontWeight.w600,
              ),
              // ... existing Price and Quantity Row ...
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  hasOffer
                      ? Row(
                    children: [
                      TextWidget(
                        "${controller.selectedProduct.value!.orderQuantity} ${controller.selectedProduct.value!.unit}",
                        typographyStyle: TypographyStyle.titleMedium,
                        fontWeight: FontWeight.w500,
                      ),
                      Sizes.width.v10,
                      FittedBox(
                          child: TextWidget(
                            "${BasicServices.baseCurrency.value!.symbol}${controller.selectedProduct.value!.offerPrice!}",
                            color: CustomColor.primary,
                            fontWeight: FontWeight.w700,
                          )),
                      Sizes.width.v5,
                      FittedBox(
                          child: TextWidget(
                            "${BasicServices.baseCurrency.value!.symbol}${controller.selectedProduct.value!.price}",
                            style: CustomStyle.labelSmall.copyWith(
                              fontWeight: FontWeight.w400,
                              color: CustomColor.disableColor,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2.0,
                            ),
                          )),
                    ],
                  )
                      : FittedBox(
                      child: TextWidget(
                        "${BasicServices.baseCurrency.value!.symbol}${controller.selectedProduct.value!.price}",
                        color: CustomColor.primary,
                        fontWeight: FontWeight.w700,
                      )),
                  Obx(() => controller.hasAdded
                      ? QuantityWidget(
                    productId:
                    controller.selectedProduct.value!.id.toString(),
                  )
                      : Quantity())
                ],
              ),
              _productDetails()
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget to render the horizontal list
  Widget _buildImageGallery() {
    // 1. Create a consolidated list of all images
    List<String> allImages = [];

    // Add main image
    if(controller.selectedProduct.value!.image.isNotEmpty) {
      allImages.add(controller.selectedProduct.value!.image);
    }

    // Add extra images from your model (assuming 'images' is a List<String>)
    // If your model uses a different name (e.g. gallery), change it here.
    if (controller.selectedProduct.value!.images != null) {
      allImages.addAll(controller.selectedProduct.value!.images!);
    }

    // Limit to 10 images if needed, or show all
    if (allImages.isEmpty) return const SizedBox();

    return Container(
      height: 60.h,
      width: double.infinity,
      // Add padding to align with the rest of the body
      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalSize * 0.75),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allImages.length > 10 ? 10 : allImages.length, // Limit to 10
        separatorBuilder: (context, index) => Sizes.width.v10,
        itemBuilder: (context, index) {
          String img = allImages[index];

          return Obx(() {
            // Check if this image is the one currently selected
            bool isSelected = controller.currentImage.value == img;

            return GestureDetector(
              onTap: () {
                controller.changeImage(img);
              },
              child: Container(
                width: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    // Highlight color logic
                    color: isSelected ? CustomColor.primary : Colors.grey.withOpacity(0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    "${controller.imagePath}$img",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 15),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  _productDetails() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.verticalSize * .5,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Sizes.height.v10,
          TextWidget(
            controller.selectedProduct.value!.data.description,
            typographyStyle: TypographyStyle.titleSmall,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}