//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    // Public

    var window: UIWindow?

    // Private

    private var launchRouter: LaunchRouting?

    // MARK: APIs

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        launchRouter = RootBuilder(dependency: AppComponent()).build()
        launchRouter?.launch(from: window)

        return true
    }
}

