//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol NetworkInteractable: Interactable {
    var router: NetworkRouting? { get set }
    var listener: NetworkListener? { get set }
}

protocol NetworkViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class NetworkRouter: ViewableRouter<NetworkInteractable, NetworkViewControllable>, NetworkRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: NetworkInteractable, viewController: NetworkViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
