part of 'search_field_screen.dart';

class SearchFieldMobileScreen extends GetView<SearchFieldController> {
  const SearchFieldMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.verticalSize * .4,
        ),
        child: Column(
          children: [SearchBar(), Flexible(child: SearchOptions())],
        ),
      ),
    );
  }
}
