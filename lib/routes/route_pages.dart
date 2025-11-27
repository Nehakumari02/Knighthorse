part of '../routes/routes.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.specialProductListScreen,
      page: () => const SpecialProductListScreen(),
      binding: SpecialProductListBinding(),
    ),
    
    GetPage(
      name: Routes.popularProductListScreen,
      page: () => const PopularProductListScreen(),
      binding: PopularProductListBinding(),
    ),
    
    GetPage(
      name: Routes.productListScreen,
      page: () => const ProductListScreen(),
      binding: ProductListBinding(),
    ),
    
    GetPage(
      name: Routes.categoryScreen,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
    ),
    
    GetPage(
      name: Routes.phoneLoginOtpScreen,
      page: () => const PhoneLoginOtpScreen(),
      binding: PhoneLoginOtpBinding(),
    ),
    
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    
    GetPage(
      name: Routes.settingsScreen,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    
    GetPage(
      name: Routes.orderDetailsScreen,
      page: () => const OrderDetailsScreen(),
      binding: OrderDetailsBinding(),
    ),
    
    GetPage(
      name: Routes.ordersScreen,
      page: () => const OrdersScreen(),
      binding: OrdersBinding(),
    ),
    
    GetPage(
      name: Routes.paymentHistoryScreen,
      page: () => const PaymentHistoryScreen(),
      binding: PaymentHistoryBinding(),
    ),
    
    GetPage(
      name: Routes.paymentScreen,
      page: () => const PaymentScreen(),
      binding: PaymentBinding(),
    ),
    
    GetPage(
      name: Routes.searchFieldScreen,
      page: () => const SearchFieldScreen(),
      binding: SearchFieldBinding(),
    ),
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
      binding: SearchFieldBinding(),
    ),
    
    GetPage(
      name: Routes.registrationEmailVerificationScreen,
      page: () => const RegEmailVerificationScreen(),
      binding: RegEmailVerificationBinding(),
    ),
    
    GetPage(
      name: Routes.registrationScreen,
      page: () => const RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    
    GetPage(
      name: Routes.forgotPasswordOtpVerificationScreen,
      page: () => const ForgotPasswordOtpVerificationScreen(),
      binding: ForgotPasswordOtpVerificationBinding(),
    ),
    
    GetPage(
      name: Routes.forgotPinScreen,
      page: () => const ForgotPinScreen(),
      binding: ForgotPinBinding(),
    ),
    
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    
    GetPage(
      name: Routes.update_profileScreen,
      page: () => const UpdateProfileScreen(),
      binding: UpdateProfileBinding(),
    ),

    GetPage(
      name: Routes.profileScreen,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: Routes.detailsScreen,
      page: () => const DetailsScreen(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: Routes.cartScreen,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.checkOutScreen,
      page: () => const CheckOutScreen(),
      binding: CheckOutBinding(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboardScreen,
      page: () => const OnboardScreen(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: Routes.navigation,
      page: () => const NavigationScreen(),
      binding: NavigationBinding(),
    ),
  ];
}
