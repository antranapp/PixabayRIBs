//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol FilesystemInteractable: Interactable, DetailListener {
    var router: FilesystemRouting? { get set }
    var listener: FilesystemListener? { get set }
}

protocol FilesystemViewControllable: ViewControllable {
    func present(view: ViewControllable)
}

final class FilesystemRouter: ViewableRouter<FilesystemInteractable, FilesystemViewControllable>, FilesystemRouting {

    // MARK: Properties

    private var detailBuilder: DetailBuildable

    // MARK: Intialization

    init(interactor: FilesystemInteractable,
         viewController: FilesystemViewControllable,
         detailBuilder: DetailBuildable) {

        self.detailBuilder = detailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToDetail(for image: Image) {
        let detailRouting = detailBuilder.build(withListener: interactor, image: image)
        attachChild(detailRouting)
        viewController.present(view: detailRouting.viewControllable)
    }
}
