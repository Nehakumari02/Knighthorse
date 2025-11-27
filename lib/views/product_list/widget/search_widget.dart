part of '../screen/product_list_screen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    this.onChanged,
    required this.textController,
  }) : super(key: key);

  final Function(String)? onChanged;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * .3),
      child: PrimaryInputWidget(
        controller: textController,
        hintText: Strings.searchHere,
        onChanged: onChanged,
        suffixIcon: _suffixIcon(),
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

      
        Sizes.width.v10,
      ],
    );
  }
}


