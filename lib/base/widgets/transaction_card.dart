// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../views/payment_history/controller/payment_history_controller.dart';
import '../../views/payment_history/model/payment_history_model.dart';
import '../utils/basic_import.dart';
import 'divider.dart';
import 'double_side_text_widget.dart';

class TransactionCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final int index;
  final bool showPreview;
  final PaymentHistory data;
  final PaymentHistoryController controller =
      Get.put(PaymentHistoryController());
  TransactionCard({
    super.key,
    this.onTap,
    this.color,
    this.showPreview = true,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isExpanded = controller.expandedIndex.value == index;
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.verticalSize * 0.42,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
              margin: EdgeInsets.zero,
              elevation: 0,
              child: ListTile(
                onTap: () {
                  controller.expandedIndex.value = isExpanded ? -1 : index;
                },
                tileColor: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
                // contentPadding: EdgeInsets.zero,
                minTileHeight: Dimensions.heightSize * 7,
                leading: Container(
                  decoration: BoxDecoration(
                      // borderRadius: (Dimensions.radius * 0.8).radiusEx,
                      color: const Color(0xffF5F5F5),
                      shape: BoxShape.circle),
                  // padding: Dimensions.verticalSize.edgeVertical * 0.15,
                  child: CircleAvatar(
                    radius: Dimensions.radius * 2.4,
                    backgroundColor: CustomColor.primary.withValues(alpha: 0.5),
                    child: Center(child: _setIcon("ADD-MONEY")),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: crossStart,
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    TextWidget(
                      data.orderNumber,
                      typographyStyle: TypographyStyle.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    // Sizes.height.v10,
                    TextWidget(
                      data.method,
                      typographyStyle: TypographyStyle.bodySmall,
                      color: CustomColor.primary,
                      maxLines: 1,
                    ),
                  ],
                ),
                trailing: TextWidget(
                  "${data.amount}${data.defaultCurrencyCode}",
                  typographyStyle: TypographyStyle.titleSmall,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (showPreview && isExpanded) _buildCard(context)
        ],
      );
    });
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.horizontalSize,
          vertical: Dimensions.verticalSize * 0.7,
        ),
        child: Column(
          children: [
            _buildInfoRow(Strings.totalAmount, data.amount),
            _buildDivider(),
            _buildInfoRow(Strings.paymentMethod, data.method),
            _buildDivider(),
            _buildInfoRow(Strings.date, _dateConverter(data.createdAt)),
            _buildDivider(),
            _buildInfoRow(Strings.transactionId, data.orderNumber),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String key, String value) {
    return DoubleSideTextWidget(
      keys: key,
      value: value,
    );
  }

  Widget _buildDivider() {
    return DividerWidget(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.verticalSize * 0.2,
      ),
    );
  }

  Widget _setIcon(String type) {
    return type == "ADD-MONEY"
        ? Icon(
            Icons.account_balance_wallet,
            size: Dimensions.iconSizeLarge,
          )
        : type == "MONEY-EXCHANGE"
            ? Icon(
                Icons.currency_exchange,
                size: Dimensions.iconSizeLarge,
              )
            : Icon(
                Icons.outbox,
                size: Dimensions.iconSizeLarge,
              );
  }

  _buildInfoRowStatus(String status) {
    return Row(
      children: [
        Expanded(
            child: TextWidget(
          Strings.orderStatus,
          typographyStyle: TypographyStyle.labelMedium,
        )),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.horizontalSize * 0.4,
            vertical: Dimensions.verticalSize * 0.15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.6),
            color: status.toLowerCase() == 'success'
                ? CustomColor.selected.withValues(alpha: 0.5)
                : status.toLowerCase() == 'pending'
                    ? CustomColor.pending.withValues(alpha: 0.5)
                    : CustomColor.rejected.withValues(alpha: 0.5),
          ),
          child: Row(
            children: [
              Icon(
                status.toLowerCase() == 'success'
                    ? Icons.check_circle
                    : status.toLowerCase() == 'pending'
                        ? Icons.check_circle
                        : Icons.block_outlined,
                color: status.toLowerCase() == 'success'
                    ? CustomColor.selected
                    : status.toLowerCase() == 'pending'
                        ? CustomColor.pending
                        : CustomColor.rejected,
                size: Dimensions.iconSizeDefault,
              ),
              Sizes.width.v5,
              TextWidget(
                status.toLowerCase() == 'success'
                    ? Strings.success
                    : status.toLowerCase() == 'pending'
                        ? Strings.pending
                        : Strings.rejected,
                typographyStyle: TypographyStyle.labelMedium,
                color: status.toLowerCase() == 'success'
                    ? CustomColor.selected
                    : status.toLowerCase() == 'pending'
                        ? CustomColor.pending
                        : CustomColor.rejected,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _dateConverter(DateTime createdAt) {
    return DateFormat("dd-MMM-yyyy").format(createdAt).toString();
  }
}
