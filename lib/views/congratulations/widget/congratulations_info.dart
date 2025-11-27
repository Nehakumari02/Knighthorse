import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knighthorse/base/utils/basic_import.dart';
import 'package:knighthorse/base/widgets/title_sub_title_widget.dart';
import 'package:knighthorse/views/congratulations/controller/congratulations_controller.dart';

class CongratulationsInfo extends StatelessWidget {
  const CongratulationsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimensions.horizontalSize.edgeHorizontal,
      child: TitleSubTitleWidget(
        title: Get.find<CongratulationsController>()
            .congratulationDetails
            .value
            .type,
        subTitle:
            '${Get.find<CongratulationsController>().congratulationDetails.value.details}',
        isCenterText: true,
      ),
    );
  }
}
