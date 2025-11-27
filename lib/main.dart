import 'package:knighthorse/base/api/services/basic_services.dart';
import 'package:knighthorse/base/api/services/delivery_service.dart';
import 'package:knighthorse/base/api/services/shipment_service.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'base/api/endpoint/api_endpoint.dart';
import 'base/maintenance/maintenance_dialog.dart';
import 'base/utils/basic_import.dart';
import 'initializer.dart';
import 'routes/routes.dart';
import 'views/navigation/controller/navigation_controller.dart';

void main() async {
  AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      designSize: const Size(375, 812),
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        title: Strings.appName,
        theme: Themes.light,
        darkTheme: Themes.dark,
        getPages: Routes.list,
        themeMode: ThemeMode.light,
        initialBinding: BindingsBuilder(
          () async {
            Get.put(SystemMaintenanceController());
            BasicServices.getBasicSettingsInfo();
            DeliveryServices.getDeliverySettingsInfo();
            ShipmentServices.getShipmentSettingsInfo();
            await DynamicLanguage.init(url: ApiConfig.languageUrl);
            Get.lazyPut(() => NavigationController());
          },
        ),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return Obx(
            () => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.0)),
              child: Directionality(
                textDirection: DynamicLanguage.isLoading
                    ? TextDirection.ltr
                    : DynamicLanguage.languageDirection,
                child: widget!,
              ),
            ),
          );
        },
      ),
    );
  }
}
