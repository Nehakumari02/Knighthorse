part of '../screen/login_screen.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo(
      {super.key,
      this.isDarkLogo = false,
      this.scale,
      this.edgeInsets,
      this.height});
  final bool isDarkLogo;
  final EdgeInsets? edgeInsets;
  final double? scale;
  final double? height;
  @override
  Widget build(BuildContext context) {
    debugPrint("brand Logo URL: ${BasicServices.appLogoFavDark.value}");
    return Column(
      crossAxisAlignment: crossCenter,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Image.network(
            Get.isDarkMode
                ? BasicServices.appBasicLogoDark.value
                : BasicServices.appBasicLogoWhite.value,
            // height: MediaQuery.of(context).size.height * 0.2,
            scale: scale ?? 0.5,
            color: isDarkLogo ? Colors.white : null,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
