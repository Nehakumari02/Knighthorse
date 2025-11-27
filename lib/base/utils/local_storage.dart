import 'package:get_storage/get_storage.dart';

import 'local_storage_model.dart';

// import '../api/model/local_storage_model.dart';

class LocalStorage {
  // Create a single instance of GetStorage
  static final GetStorage _storage = GetStorage();

  // Keys for storage
  static const String tokenKey = 'token';
  static const String temporaryTokenKey = 'temporaryToken';
  static const String onboardSaveKey = 'onboardSave';
  static const String waitTimeKey = 'waitTime';
  static const String isLoggedInKey = 'isLoggedIn';
  static const String isEmailVerifiedKey = 'isEmailVerified';
  static const String isKycVerifiedKey = 'isKycVerified';
  static const String kycStatusKey = 'isKycStatus';
  static const String isSmsVerifiedKey = 'isSmsVerified';
  static const String emailKey = 'email';
  static const String userStatusKey = 'userStatus';
  static const String dialCodeKey = 'dialCode';
  static const String selectedAreaNameKey = 'selectedAreaName';
  static const String selectedAreaIdKey = 'selectedAreaId';

  // Save data to local storage (supports individual properties)
  static Future<void> save({
    String? token,
    String? temporaryToken,
    String? waitTime,
    bool? onboardSave,
    bool? isLoggedIn,
    bool? isEmailVerified,
    bool? isKycVerified,
    bool? isSmsVerified,
    String? email,
    String? userStatus,
    String? dialCode,
    int? kycStatus,
  }) async {
    if (token != null) await _storage.write(tokenKey, token);
    if (temporaryToken != null)
      await _storage.write(temporaryTokenKey, temporaryToken);
    if (onboardSave != null) await _storage.write(onboardSaveKey, onboardSave);
    if (isLoggedIn != null) await _storage.write(isLoggedInKey, isLoggedIn);
    if (isEmailVerified != null)
      await _storage.write(isEmailVerifiedKey, isEmailVerified);
    if (isKycVerified != null)
      await _storage.write(isKycVerifiedKey, isKycVerified);
    if (isSmsVerified != null)
      await _storage.write(isSmsVerifiedKey, isSmsVerified);
    if (waitTime != null) await _storage.write(waitTimeKey, waitTime);
    if (email != null) await _storage.write(emailKey, email);
    if (userStatus != null) await _storage.write(userStatusKey, userStatus);
    if (kycStatus != null) await _storage.write(kycStatusKey, kycStatus);
  }

  static Future<void> setSelectedArea({
    required String name,
    required int id,
  }) async {
    await _storage.write(selectedAreaNameKey, name);
    await _storage.write(selectedAreaIdKey, id);
  }

  // Read entire model
  static LocalStorageModel get model {
    return LocalStorageModel(
      _storage.read(tokenKey) ?? '',
      _storage.read(onboardSaveKey) ?? false,
      _storage.read(waitTimeKey) ?? '01:00',
      _storage.read(isLoggedInKey) ?? false,
      _storage.read(isEmailVerifiedKey) ?? false,
      _storage.read(isKycVerifiedKey) ?? false,
      _storage.read(isSmsVerifiedKey) ?? false,
      _storage.read(userStatusKey) ?? "",
      _storage.read(dialCodeKey) ?? "",
      _storage.read(kycStatusKey) ?? 0,
      temporaryToken: _storage.read(temporaryTokenKey) ?? '',
    );
  }

  // Read individual properties
  static String get token => _storage.read(tokenKey) ?? '';
  static String get temporaryToken => _storage.read(temporaryTokenKey) ?? '';
  static String get waitTime => _storage.read(waitTimeKey) ?? '01:00';
  static bool get onboardSave => _storage.read(onboardSaveKey) ?? false;
  static bool get isLoggedIn => _storage.read(isLoggedInKey) ?? false;
  static bool get isEmailVerified => _storage.read(isEmailVerifiedKey) ?? false;
  static bool get isKycVerified => _storage.read(isKycVerifiedKey) ?? false;
  static bool get isSmsVerified => _storage.read(isSmsVerifiedKey) ?? false;
  static String get email => _storage.read(emailKey) ?? '';
  static String get userStatus => _storage.read(userStatusKey) ?? '0';
  static String get dialCode => _storage.read(dialCodeKey) ?? '';
  static int get kycStatus => _storage.read(kycStatusKey) ?? 0;

  static String get selectedAreaName =>
      _storage.read(selectedAreaNameKey) ?? 'All Areas';
  static int get selectedAreaId => _storage.read(selectedAreaIdKey) ?? 0;

  // Clear all stored data
  static Future<void> clear() async {
    await _storage.erase();
  }
}
