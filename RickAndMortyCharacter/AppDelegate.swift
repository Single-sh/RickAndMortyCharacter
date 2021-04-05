import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow()
    let controller = CharactersViewController(model: CharactersModel())
    window?.rootViewController = UINavigationController(rootViewController: controller)
    window?.makeKeyAndVisible()
    return true
  }

}

