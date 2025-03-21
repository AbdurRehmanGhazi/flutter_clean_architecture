import Flutter
import UIKit

 @main
 @objc class AppDelegate: FlutterAppDelegate {
     
     override func application(
         _ application: UIApplication,
         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
     ) -> Bool {
         
         GeneratedPluginRegistrant.register(with: self)
         
         let controller = window?.rootViewController as! FlutterViewController

         // Setup channels
         setupLanguageChannel(controller: controller)

         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
     }
 }

 // MARK: - Language Handling
 extension AppDelegate {
     
     private func setupLanguageChannel(controller: FlutterViewController) {
         let channel = FlutterMethodChannel(name: "app.language/settings", binaryMessenger: controller.binaryMessenger)
         
         channel.setMethodCallHandler { (call, result) in
             switch call.method {
             case "getPreferredLanguage":
                 self.getPreferredLanguage(result: result)
                 
             case "setPreferredLanguage":
                 guard let arguments = call.arguments as? [String: String],
                       let languageCode = arguments["languageCode"] else {
                     result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing languageCode", details: nil))
                     return
                 }
                 self.setPreferredLanguage(languageCode: languageCode, result: result)
                 
             default:
                 result(FlutterMethodNotImplemented)
             }
         }
     }
     
     private func getPreferredLanguage(result: FlutterResult) {
         let preferredLanguage = UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? "en"
         result(preferredLanguage)
     }
     
     private func setPreferredLanguage(languageCode: String, result: FlutterResult) {
         UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
         UserDefaults.standard.synchronize()
         print("Preferred language set to: \(languageCode)")
         result(nil) // Acknowledge the change
     }
 }

/*
 // MARK: - Theme Handling
 
 setupThemeChannel(controller: controller)
// Apply theme on launch
applySavedTheme()


 extension AppDelegate {
     
     private func setupThemeChannel(controller: FlutterViewController) {
         let themeChannel = FlutterMethodChannel(name: "app.theme", binaryMessenger: controller.binaryMessenger)

         themeChannel.setMethodCallHandler { [weak self] (call, result) in
             guard call.method == "updateTheme",
                   let args = call.arguments as? [String: Any],
                   let theme = args["theme"] as? String else {
                 result(FlutterMethodNotImplemented)
                 return
             }

             let userDefaults = UserDefaults.standard
             userDefaults.set(theme, forKey: "theme_mode")
             userDefaults.synchronize()
             
             // Update splash screen background
             self?.updateSplashScreenColor(theme: theme)

             result(nil)
         }
     }

     /// Apply the saved theme on app launch
     private func applySavedTheme() {
         let theme = UserDefaults.standard.string(forKey: "theme_mode") ?? "system"
         updateSplashScreenColor(theme: theme)
     }
     
     /// Updates the launch screen background color dynamically based on theme selection
     private func updateSplashScreenColor(theme: String) {
         let backgroundColor: UIColor
         if theme == "light" {
             backgroundColor = .white
         } else if theme == "dark" {
             backgroundColor = .black
         } else {
             backgroundColor = UIColor { traitCollection in
                 return traitCollection.userInterfaceStyle == .dark ? .black : .white
             }
         }

         DispatchQueue.main.async {
             if let window = UIApplication.shared.windows.first {
                 window.backgroundColor = backgroundColor
             }
         }
     }
 }
 
*/
