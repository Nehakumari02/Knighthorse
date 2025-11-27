part of '../screen/search_field_screen.dart';

class SearchBar extends GetView<SearchFieldController> {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Dimensions.horizontalSize * .5,
      ),
      child: Row(
        mainAxisAlignment: mainStart,
        children: [
          BackButtonWidget(
            onTap: () {
              Get.close(1);
            },
          ),
          Sizes.width.v10,
          Expanded(
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: DynamicLanguage.key(Strings.searchForProduct),
                hintStyle: CustomStyle.labelLarge.copyWith(
                  color: Colors.grey.shade700,
                ),
                suffixIcon: _suffixIcon(),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.horizontalSize * 0.67,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.getProductResult(value);
                }
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.getProductResult(value);
                }
              },
              onTapOutside: (e) {},
            ),
          ),
        ],
      ),
    );
  }

  _suffixIcon() {
    return Row(
      mainAxisSize: mainMin,
      children: [
        Container(
          height: Dimensions.verticalSize,
          width: 2,
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * 0.35,
          ),
        ),
        Icon(
          Icons.search_outlined,
          color: Colors.grey.shade700,
        ),

        // VoiceToTextWidget(
        //   onVoiceSubmit: (String voice) {
        //     controller.searchController.text = voice;
        //   },
        // ),
        Sizes.width.v10,
      ],
    );
  }
}
