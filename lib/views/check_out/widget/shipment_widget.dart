part of '../screen/check_out_screen.dart';

class ShipmentWidget extends GetView<CartController> {
  const ShipmentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _deliveryTypeOptions(),
      Sizes.height.v10,
      Obx(() {
        List<Shipment> filteredShipments;

        if (controller.cartItems.length == 1) {
          final shipmentId = controller.cartItems.first.shipmentType;
          if (shipmentId != null) {
            filteredShipments = controller.shipmentType
                .where((e) => e.id == int.parse(shipmentId))
                .toList();
          } else {
            filteredShipments = controller.shipmentType
                .where((e) => e.shipmentDefault == 1)
                .toList();
          }
        } else if (controller.selectedDelivaryType.value == 1) {
          final shipmentIdSet = controller.cartItems
              .map((e) => e.shipmentType)
              .where((id) => id != null)
              .toSet();

          if (shipmentIdSet.length == 1) {
            final onlyId = int.tryParse(shipmentIdSet.first!);
            filteredShipments =
                controller.shipmentType.where((e) => e.id == onlyId).toList();
          } else {
            filteredShipments = controller.shipmentType
                .where((e) => e.shipmentDefault == 1)
                .toList();
          }
        } else {
          final shipmentIdSet = controller.cartItems
              .map((e) => e.shipmentType)
              .where((id) => id != null)
              .toSet();

          if (shipmentIdSet.length == 1) {
            final onlyId = int.tryParse(shipmentIdSet.first!);
            filteredShipments =
                controller.shipmentType.where((e) => e.id == onlyId).toList();
          } else {
            final idInts = shipmentIdSet
                .map((id) => int.tryParse(id!))
                .whereType<int>()
                .toSet();

            filteredShipments = controller.shipmentType
                .where((e) => idInts.contains(e.id))
                .toList();
          }
        }

        controller.initializeSelectedTimes(filteredShipments.length);

        return Column(
          children: List.generate(filteredShipments.length, (index) {
            final data = filteredShipments[index];
            return _shipmentCardWidget(context, index, data);
          }),
        );
      }),
    ]);
  }

  _deliveryTypeOptions() {
    return controller.cartItems.length > 1
        ? Row(
            mainAxisAlignment: mainCenter,
            children:
                List.generate(controller.deliveryTypeOptions.length, (index) {
              return Obx(() {
                var isSelected = controller.selectedDelivaryType.value == index;
                return GestureDetector(
                  onTap: () {
                    controller.selectedDelivaryType.value = index;
                    controller.selectedDelivaryTypeName.value =
                        controller.selectedDelivaryType.value == 1
                            ? "together"
                            : "separate";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isSelected
                            ? CustomColor.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(Dimensions.radius)),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalSize * .5,
                      vertical: Dimensions.verticalSize * .3,
                    ),
                    child: TextWidget(
                      controller.deliveryTypeOptions[index],
                      color: isSelected
                          ? CustomColor.whiteColor
                          : CustomColor.blackColor,
                      typographyStyle: TypographyStyle.labelMedium,
                    ),
                  ),
                );
              });
            }))
        : SizedBox.shrink();
  }

  _shipmentCardWidget(BuildContext context, int index, Shipment shipment) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize * .5,
          vertical: Dimensions.verticalSize * .5,
        ),
        child: Column(
          children: [
            TextWidget(
              shipment.name,
              typographyStyle: TypographyStyle.titleMedium,
              fontWeight: FontWeight.w500,
            ),
            _delivaryDateAndTime(
                context,
                index,
                shipment.starTime,
                shipment.endTime,
                shipment.timeRange,
                shipment.deliveryDelayDays),
          ],
        ),
      ),
    );
  }

  _delivaryDateAndTime(BuildContext context, int index, String start, end, gap,
      String delayDays) {
    return Row(
      mainAxisAlignment: mainSpaceBet,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: DateSlotSelector(
            delayDays: int.parse(delayDays),
            onSlotTap: (date) {
              final formattedDate = DateFormat('yyyy-MM-dd').format(date);

              controller.selectedDates[index].value = formattedDate;
            },
            child: Column(
              crossAxisAlignment: crossStart,
              mainAxisSize: mainMin,
              children: [
                TextWidget(
                  Strings.selectDate,
                  typographyStyle: TypographyStyle.labelMedium,
                ),
                Sizes.height.v5,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalSize * .5,
                      vertical: Dimensions.verticalSize * .3),
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.disableColor),
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 1.2)),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      FittedBox(
                        child: Obx(
                          () => TextWidget(
                            controller.selectedDates.isEmpty
                                ? Strings.selectDate
                                : controller.selectedDates[index].value,
                            typographyStyle: TypographyStyle.labelMedium,
                          ),
                        ),
                      ),
                      FittedBox(child: Icon(Icons.date_range))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Sizes.width.v10,
        Flexible(
          fit: FlexFit.loose,
          child: TimeSlotSelector(
            startTime: start,
            endTime: end,
            gap: gap,
            onSlotTap: (start, end) {
              debugPrint("Selected: $start");
              debugPrint("Selected: $end");
              final slot = {"start": start, "end": end};
              debugPrint("Selected: $slot");
              controller.selectedTimes[index].value =
                  "${slot["start"]}-${slot["end"]}";

              debugPrint(controller.selectedTimes[index].value);
            },
            child: Column(
              crossAxisAlignment: crossStart,
              mainAxisSize: mainMin,
              children: [
                TextWidget(
                  Strings.selectTime,
                  typographyStyle: TypographyStyle.labelMedium,
                ),
                Sizes.height.v5,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalSize * .5,
                      vertical: Dimensions.verticalSize * .3),
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.disableColor),
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 1.2)),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      FittedBox(
                        child: Obx(
                          () => TextWidget(
                            controller.selectedTimes.isEmpty
                                ? Strings.selectTime
                                : controller.selectedTimes[index].value,
                            typographyStyle: TypographyStyle.labelMedium,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      FittedBox(child: Icon(Icons.watch_later_outlined))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
