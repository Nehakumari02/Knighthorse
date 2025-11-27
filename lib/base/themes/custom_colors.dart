part of 'token.dart';

class CustomColor {
  //Light Color
  static Color primary = HexColor('#FF485E');
  static Color secondary = HexColor('#ff686e');
  static Color tertiary = HexColor('#F5F5F5');
  static Color background = HexColor('#F5F5F5');
  static Color typography = HexColor('#1D1D1D');
  static Color disableColor = HexColor('#BCBCBC');

  //Dark Color
  static Color primaryDark = HexColor('#007bff');
  static Color secondaryDark = HexColor('#FC5B3F');
  static Color tertiaryDark = HexColor('#1D1D1D');
  static Color backgroundDark = HexColor('#171717');
  static Color typographyDark = HexColor('#FFFFFF');

  // Status Color
  static Color ongoing = HexColor('#FFFFFF');
  static Color pending = HexColor('#FF9E45');
  static Color delivered = HexColor('#FFFFFF');
  static Color canceled = HexColor('#FFFFFF');
  static Color selected = HexColor('#27B059');
  static Color rejected = HexColor('#DC3A3A');

  // Others
  static const Color whiteColor = Color(0xFFffffff);
  static const Color blackColor = Color(0xFF000000);
  static const MaterialColor greyColor = Colors.grey;
  static const MaterialColor redColor = Colors.red;
  static const MaterialColor blueColor = Colors.blue;
  static const MaterialColor yelowColor = Colors.yellow;
  static const Color primaryColorShadeZero = Color(0xFFFFF2F0);

  // Shade Color
  static CSM typographyShade = CSM(typography.value, typographyShadeToken);
  static CSM typographyDarkShade = CSM(typography.value, typoDarkShadeToken);
  static CSM primaryShade = CSM(primary.value, primaryShadeToken);

  /// SHADE TOKENS (Done)
  static Map<int, Color> typographyShadeToken = {
    100: HexColor('#000000'),
    90: HexColor('#1A1A1A'),
    80: HexColor('#333333'),
    70: HexColor('#4D4D4D'),
    60: HexColor('#666666'),
    55: HexColor('#6C6E7C'), // custom inserted shade
    50: HexColor('#808080'),
    40: HexColor('#999999'),
    30: HexColor('#B3B3B3'),
    20: HexColor('#CCCCCC'),
    10: HexColor('#E6E6E6'),
    0: HexColor('#FFFFFF'),
  };

  //( Not Done)
  static Map<int, Color> typoDarkShadeToken = {
    100: HexColor('#0D0D0D'), // darkest
    90: HexColor('#111111'),
    80: HexColor('#161616'),
    70: HexColor('#171717'),
    60: HexColor('#1A1A1A'),
    50: HexColor('#2A2A2A'),
    40: HexColor('#3A3A3A'),
    30: HexColor('#6A6A6A'),
    20: HexColor('#B9B9B9'),
    10: HexColor('#DDDDDD'),
    5: HexColor('#E8E8E8'),
    0: HexColor('#FFFFFF'), // lightest
  };

  static Map<int, Color> primaryShadeToken = {
    100: HexColor('#007BFF'),
    80: HexColor('#1A88FF'),
    70: HexColor('#3395FF'),
    60: HexColor('#4DA3FF'),
    50: HexColor('#66B0FF'),
    40: HexColor('#80BDFF'),
    30: HexColor('#99CAFF'),
    20: HexColor('#B3D7FF'),
    10: HexColor('#CCE5FF'),
    0: HexColor('#E6F2FF'),
  };
}
