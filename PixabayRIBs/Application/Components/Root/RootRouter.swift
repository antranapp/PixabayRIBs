//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, NetworkListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(_ viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // MARK: Properties

    // Paivate

    private var networkBuilder: NetworkBuildable

    private var currentChild: ViewableRouting?

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         networkBuilder: NetworkBuildable) {

        self.networkBuilder = networkBuilder

        super.init(interactor: interactor, viewController: viewController)

        interactor.router = self
    }

    func routeToNetwork() {
        if let currentChild = self.currentChild {
            detachChild(currentChild)
        }
        let networkRouting = networkBuilder.build(withListener: interactor)
        attachChild(networkRouting)
        viewController.present(networkRouting.viewControllable)
    }

    func routeToMemory() {
    }

    func routeToFilesytem() {
    }
}
