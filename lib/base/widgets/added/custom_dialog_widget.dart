import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../languages/strings.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';
import '../primary_button.dart';
import '../text_widget.dart';

class CustomDialog{

  static open({
    required BuildContext context,
    required VoidCallback onConfirm,
    required String title,
    String okayText = "",
    bool loading = false,
    required String subTitle,
  }){
    showModalBottomSheet(
        context: context,
        elevation: 5,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSize * .6,
                vertical: Dimensions.paddingSize * 0.4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radius * .6)
              )
            ),
            child: Column(
              mainAxisSize: mainMin,
              crossAxisAlignment: crossStart,
              children: [
                Sizes.height.v10,
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    SizedBox(),
                  Container(
                    height: 4,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      color: Colors.grey.withValues(alpha: .5)
                    ),
                  ),
                    SizedBox(),

                    // IconButton(
                    //   onPressed: (){
                    //     Get.close(1);
                    //   },
                    //   icon: Icon(Icons.cancel_outlined, color: CustomColor.rejected),
                    // )
                  ],
                ),
                Sizes.height.v10,

                TextWidget(
                  title,
                  typographyStyle: TypographyStyle.titleSmall,
                  fontWeight: FontWeight.bold,
                  padding: EdgeInsets.only(
                    bottom: Dimensions.verticalSize * 0.15,
                  ),
                ),
                TextWidget(
                  subTitle,
                  typographyStyle: TypographyStyle.bodyMedium,
                ),
                Sizes.height.betweenInputBox,

                Row(
                  children: [
                    Expanded(
                      flex: 5,
                        child: PrimaryButton(
                          isLoading: loading,
                            height: Dimensions.buttonHeight * .75,
                            fontSize: Dimensions.titleSmall,
                            fontWeight: FontWeight.bold,
                            buttonColor: Theme.of(context).primaryColor,
                            title: okayText.isEmpty ? Strings.okay : okayText,
                            onPressed: onConfirm
                        )
                    ),
                    Sizes.width.v10,
                    Expanded(
                      flex: 4,
                        child: PrimaryButton(
                            height: Dimensions.buttonHeight * .75,
                            fontSize: Dimensions.titleSmall,
                            buttonTextColor: Get.isDarkMode ? Colors.white: Colors.black,
                            fontWeight: FontWeight.bold,
                            buttonColor: Colors.transparent,
                            title: Strings.cancel,
                            onPressed: () {
                              Get.close(1);
                            }
                        )
                    ),
                  ],
                ),
                Sizes.height.v20,
              ],
            ),
          );
        }
    );
  }


  static openCustom({
    required BuildContext context,
    required String title,
    required String subTitle,
    required Widget widget
  }){
    showModalBottomSheet(
        context: context,
        elevation: 5,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSize * .6,
                vertical: Dimensions.paddingSize * 0.4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radius * .6)
              )
            ),
            
            child: Column(
              mainAxisSize: mainMin,
              crossAxisAlignment: crossStart,
              children: [
                Sizes.height.v10,
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    SizedBox(),
                    Container(
                      height: 4,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius),
                          color: Colors.grey.withValues(alpha: .5)
                      ),
                    ),
                    SizedBox(),

                    // IconButton(
                    //   onPressed: (){
                    //     Get.close(1);
                    //   },
                    //   icon: Icon(Icons.cancel_outlined, color: CustomColor.rejected),
                    // )
                  ],
                ),
                Sizes.height.v10,

                TextWidget(
                  title,
                  typographyStyle: TypographyStyle.titleSmall,
                  fontWeight: FontWeight.bold,
                  padding: EdgeInsets.only(
                    bottom: Dimensions.verticalSize * 0.15,
                  ),
                ),
                TextWidget(
                  subTitle,
                  typographyStyle: TypographyStyle.bodyMedium,
                ),
                Sizes.height.betweenInputBox,

                // Sizes.height.v10,
                widget,
                Sizes.height.v20,
              ],
            ),
          );
        }
    );
  }

}