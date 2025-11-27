import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/dimensions.dart';

class CustomCachedImageWidget extends StatelessWidget {
  const CustomCachedImageWidget(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.radius,
      this.shape,
      this.filePath = "",
      this.errorImage = ""});

  final String image, filePath, errorImage;
  final double? height, width, radius;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return filePath.isNotEmpty && File(filePath).existsSync()
        ? Container(
            height: height ?? MediaQuery.sizeOf(context).height * .2,
            width: width ?? double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                shape: shape ?? BoxShape.rectangle,
                borderRadius: shape != null
                    ? null
                    : BorderRadius.circular(radius ?? Dimensions.radius),
                // color: Colors.amber,
                image: DecorationImage(
                   image: FileImage(File(filePath)), fit: BoxFit.cover)))
        : image.toString().contains("https") ||
                image.toString().contains("http")
            ? CachedNetworkImage(
                imageUrl: image,
                imageBuilder: (context, img) {
                  return Container(
                    height: height ?? MediaQuery.sizeOf(context).height * .2,
                    width: width ?? double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColor
                            .withValues(alpha: .2),
                        shape: shape ?? BoxShape.rectangle,
                        borderRadius: shape != null
                            ? null
                            : BorderRadius.circular(
                                radius ?? Dimensions.radius),
                        image: DecorationImage(image: img, fit: BoxFit.cover)),
                  );
                },
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                      height: height ?? MediaQuery.sizeOf(context).height * .2,
                      width: width ?? double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: shape ?? BoxShape.rectangle,
                        borderRadius: shape != null
                            ? null
                            : BorderRadius.circular(
                                radius ?? Dimensions.radius),
                      )),
                ),
                errorWidget: (context, url, error) => errorImage.isEmpty
                    ? Icon(Icons.error)
                    : Container(
                        height:
                            height ?? MediaQuery.sizeOf(context).height * .2,
                        width: width ?? double.infinity,
                        decoration: BoxDecoration(
                            shape: shape ?? BoxShape.rectangle,
                            borderRadius: shape != null
                                ? null
                                : BorderRadius.circular(
                                    radius ?? Dimensions.radius),
                            image: DecorationImage(
                                image: NetworkImage(errorImage),
                                fit: BoxFit.cover)),
                      ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )
            : Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                height: height,
                decoration: BoxDecoration(
                    shape: shape ?? BoxShape.rectangle,
                    borderRadius: shape != null
                        ? null
                        : BorderRadius.circular(radius ?? Dimensions.radius),
                    // color: Colors.amber,
                    image: image.isEmpty
                        ? null
                        : DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover)));
  }
}
