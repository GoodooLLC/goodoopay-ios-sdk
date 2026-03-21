import UIKit
import Flutter
import FlutterPluginRegistrant

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var flutterEngine = FlutterEngine(name: "goodoo_pay_engine")

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(engine: flutterEngine)
        window?.makeKeyAndVisible()
        return true
    }
}
