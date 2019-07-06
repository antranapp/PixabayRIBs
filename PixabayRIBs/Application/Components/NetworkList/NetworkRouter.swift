//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol NetworkInteractable: Interactable, DetailListener {
    var router: NetworkRouting? { get set }
    var listener: NetworkListener? { get set }
}

/// Declare methods the router invokes to manipulate the view hierarchy.
protocol NetworkViewControllable: ViewControllable {
    func present(view: ViewControllable)
}

final class NetworkRouter: ViewableRouter<NetworkInteractable, NetworkViewControllable>, NetworkRouting {

    private var detailBuilder: DetailBuildable

    init(interactor: NetworkInteractable,
          viewController: NetworkViewControllable,
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
