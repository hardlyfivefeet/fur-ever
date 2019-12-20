import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
           MockApiService() : RealApiService()
    var failureCallback: ((Error) -> Void)?

    let requestParams = TokenRequestParams()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        api.api(host: "https://api.petfinder.com/v2/")
        api.getToken(with: requestParams, fail: failureCallback ?? report)
        return true
    }

    private func report(error: Error) {
        print("Unable to acquire access token: \(error.localizedDescription)")
    }
}
