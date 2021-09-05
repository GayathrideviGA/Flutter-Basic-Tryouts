import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate 
{
  override func application(
    _ application: UIApplication,
    
    
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    [GMSServices.provideAPIKey : @"AIzaSyBfP4FRZT0FqX_JVxfkhsLeHdleUym2tgA"];
    [GMSPlacesClient.provideAPIKey : @"AIzaSyBfP4FRZT0FqX_JVxfkhsLeHdleUym2tgA"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
