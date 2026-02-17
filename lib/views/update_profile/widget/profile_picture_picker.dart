import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../base/utils/basic_import.dart';
import '../../profile/controller/profile_controller.dart';

class ProfilePicturePicker extends StatelessWidget {
  ProfilePicturePicker({super.key});
  final controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.verticalSize * .5,
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 10,
                color: CustomColor.background,
              ),
            ),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: CustomColor.primary,
                  ),
                ),
                child: controller.imagePath.value != ''
                    ? CircleAvatar(
                        backgroundColor: CustomColor.background,
                        backgroundImage:
                            FileImage(File(controller.imagePath.value)),
                        radius: Dimensions.radius * 5,
                      )
                    : CircleAvatar(
                        backgroundColor: CustomColor.background,
                        backgroundImage: NetworkImage(
                          controller.userImage.value,
                        ),
                        radius: Dimensions.radius * 5,
                      ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 17,
          //   right: 8,
          //   child: InkWell(
          //     onTap: () {
          //       showModalBottomSheet(
          //         context: context,
          //         builder: (context) => _imagePickerBottomSheetWidget(context),
          //       );
          //     },
          //     child: CircleAvatar(
          //       backgroundColor: CustomColor.whiteColor,
          //       radius: Dimensions.radius * 1.3,
          //       child: Icon(
          //         Icons.photo_camera,
          //         color: CustomColor.disableColor,
          //         size: Dimensions.iconSizeDefault * 0.8,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  _imagePickerBottomSheetWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.all(Dimensions.verticalSize * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize),
            child: IconButton(
                onPressed: () {
                  Get.back();
                  controller.pickImage(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  color: CustomColor.primary,
                  size: Dimensions.iconSizeLarge * 2,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingSize),
            child: IconButton(
              onPressed: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
              icon: Icon(
                Icons.camera,
                color: CustomColor.primary,
                size: Dimensions.iconSizeLarge * 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
