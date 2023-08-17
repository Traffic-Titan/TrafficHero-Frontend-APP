import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupGoogleMapsAPIKeyFromEnv() // 呼叫方法設置 Google Maps API 金鑰
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func setupGoogleMapsAPIKeyFromEnv() {
        if let envFilePath = Bundle.main.path(forResource: "Runner", ofType: ".env") {
            if let envFileContents = try? String(contentsOfFile: envFilePath) {
                let lines = envFileContents.components(separatedBy: "\n")
                for line in lines {
                    let components = line.components(separatedBy: "=")
                    if components.count == 2 {
                        let key = components[0]
                        let value = components[1]
                        if key == "GOOGLE_MAPS_API_KEY" {
                            GMSServices.provideAPIKey(value)
                        }
                    }
                }
            }
        }
    }
}
