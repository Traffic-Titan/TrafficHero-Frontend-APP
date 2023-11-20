import UIKit
import Flutter
import GoogleMaps
import AVFoundation
import flutter_config_plus

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      do {
                 // 设置AVAudioSession.Category.playback后，在静音模式下，或者APP进入后台，或者锁定屏幕后还可以继续播放。
                 try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.moviePlayback)
             } catch {
                 print(error)
             }
      
      GMSServices.provideAPIKey(flutter_config_plus.FlutterConfigPlusPlugin.env(for: "GOOGLE_MAPS_API_KEY"))
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
