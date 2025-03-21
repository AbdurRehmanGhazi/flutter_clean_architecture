// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "welcome": "Welcome!",
  "welcomeToSaveKaro": "Welcome to SaveKaro",
  "easySaveYourMoney": "Easy Save your money",
  "login": "Login",
  "signUp": "Sign Up",
  "microphonePermissionRequired": "Microphone Permission Required",
  "microphoneAccessIsRequiredToSecurelyRecordYourVoiceForVerificationDuringTheSignInAndSignUpProcess": "Microphone access is required to securely record your voice for verification during the sign-in and sign-up process",
  "cameraPermissionRequired": "Camera Permission Required",
  "cameraAccessIsRequiredToSecurelyCaptureYourPictureForVerificationDuringTheSignInAndSignUpProcess": "Camera access is required to securely capture your picture for verification during the sign-in and sign-up process",
  "settings": "Settings",
  "cancel": "Cancel"
};
static const Map<String,dynamic> _so = {
  "welcome": "Soo dhawow!",
  "welcomeToSaveKaro": "Ku soo dhowow keydkaro",
  "easySaveYourMoney": "Si fudud ayaa loo badbaadiyaa lacagtaada",
  "login": "Soo iibsasho",
  "signUp": "Is-qor",
  "microphonePermissionRequired": "Ogolaanshaha makarafoonka ayaa loo baahan yahay",
  "microphoneAccessIsRequiredToSecurelyRecordYourVoiceForVerificationDuringTheSignInAndSignUpProcess": "Helitaanka makarafoonka waxaa looga baahan yahay in si adag loogu diiwaan geliyo codkaaga si loo xaqiijiyo inta lagu gudajiro nidaamka gelitaanka iyo nidaamka is-qoritaanka",
  "cameraPermissionRequired": "Ogolaansho kaameeradu u baahan tahay",
  "cameraAccessIsRequiredToSecurelyCaptureYourPictureForVerificationDuringTheSignInAndSignUpProcess": "Marin u helka kamaradda ayaa loo baahan yahay si aad si buuxda ugu qabato sawirkaaga si aad u xaqiijiso inta lagu guda jiro gelitaanka iyo nidaamka is-qoritaanka",
  "settings": "Dejinta",
  "cancel": "Burin"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "so": _so};
}
