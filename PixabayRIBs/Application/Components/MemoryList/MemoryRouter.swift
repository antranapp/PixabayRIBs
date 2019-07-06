//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol MemoryInteractable: Interactable, DetailListener {
    var router: MemoryRouting? { get set }
    var listener: MemoryListener? { get set }
}

/// Declare methods the router invokes to manipulate the view hierarchy.
protocol MemoryViewControllable: ViewControllable {
    func present(view: ViewControllable)
}

final class MemoryRouter: ViewableRouter<MemoryInteractable, MemoryViewControllable>, MemoryRouting {

    // MARK: Properties

    private var detailBuilder: DetailBuildable

    // MARK: Intialization

    init(interactor: MemoryInteractable,
         viewController: MemoryViewControllable,
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
