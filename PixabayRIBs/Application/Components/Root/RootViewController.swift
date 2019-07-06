//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

/// Declare properties and methods that the view controller can invoke to perform
/// business logic, such as signIn(). This protocol is implemented by the corresponding
/// interactor class
protocol RootPresentableListener: class {
    func presentNetworkViewController()
    func presentMemoryViewController()
    func presentFilesystemViewController()
}

final class RootViewController: UIViewController, RootPresentable {


    weak var listener: RootPresentableListener?


    @IBAction func didTapNetworkButton(_ sender: Any) {
        listener?.presentNetworkViewController()
    }


    @IBAction func didTapMemoryButton(_ sender: Any) {
        listener?.presentMemoryViewController()
    }

    @IBAction func didTapFilesystemButton(_ sender: Any) {
        listener?.presentFilesystemViewController()
    }
}

// MAKR: - RootViewControllable

extension RootViewController: RootViewControllable {

    func present(_ viewController: ViewControllable) {
        let navigationController = UINavigationController(rootViewController: viewController.uiviewController)
        present(navigationController, animated: true, completion: nil)
    }
}
