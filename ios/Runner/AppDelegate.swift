import UIKit
import Flutter
import GoogleMaps
import flutter_config
import flutter_config_plus

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    FlutterConfigPlugin.env(for: "GOOGLE_MAPS_API_KEY")
      GMSServices.provideAPIKey(flutter_config_plus.FlutterConfigPlusPlugin.env(for: "GOOGLE_MAPS_API_KEY"))
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
