import 'package:knighthorse/base/utils/no_data_widget.dart';
import 'package:knighthorse/base/widgets/divider.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../controller/search_field_controller.dart';
part 'search_field_tablet_screen.dart';
part 'search_field_mobile_screen.dart';
part '../widget/search_bar.dart';
part '../widget/search_options.dart';

class SearchFieldScreen extends GetView<SearchFieldController> {
  const SearchFieldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: SearchFieldMobileScreen(),
      tablet: SearchFieldTabletScreen(),
    );
  }
}
