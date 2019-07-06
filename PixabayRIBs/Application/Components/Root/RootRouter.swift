//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, NetworkListener, MemoryListener, FilesystemListener {
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
    private var memoryBuilder: MemoryBuildable
    private var filesystemBuilder: FilesystemBuildable

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         networkBuilder: NetworkBuildable,
         memoryBuilder: MemoryBuildable,
         filesystemBuilder: FilesystemBuilder) {

        self.networkBuilder = networkBuilder
        self.memoryBuilder = memoryBuilder
        self.filesystemBuilder = filesystemBuilder

        super.init(interactor: interactor, viewController: viewController)

        interactor.router = self
    }

    // MARK: RootRouting

    func dismiss(_ router: ViewableRouting?) {
        guard let router = router else {
            return
        }

        router.viewControllable.uiviewController.dismiss(animated: true, completion: nil)
        detachChild(router)
    }

    func routeToNetwork() {
        let networkRouting = networkBuilder.build(withListener: interactor)
        attachChild(networkRouting)
        viewController.present(networkRouting.viewControllable)
    }

    func routeToMemory() {
        let memoryRouting = memoryBuilder.build(withListener: interactor)
        attachChild(memoryRouting)
        viewController.present(memoryRouting.viewControllable)
    }

    func routeToFilesytem() {
        let filesystemRouting = filesystemBuilder.build(withListener: interactor)
        attachChild(filesystemRouting)
        viewController.present(filesystemRouting.viewControllable)
    }
}
