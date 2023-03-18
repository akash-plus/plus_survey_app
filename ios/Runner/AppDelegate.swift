import UIKit
// import CleverTapSDK
// import clevertap_plugin
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var navigationController = UINavigationController()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // CleverTap.autoIntegrate() // integrate CleverTap SDK using the autoIntegrate option
    // CleverTapPlugin.registerForPush();
    // CleverTapPlugin.sharedInstance()?.applicationDidLaunch(options: launchOptions)
      //2. Place the following 6 lines of code.
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        self.navigationController = UINavigationController(rootViewController: flutterViewController);
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    
        if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
