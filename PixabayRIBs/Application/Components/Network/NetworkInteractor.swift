//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift

protocol NetworkRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol NetworkPresentable: Presentable {
    var listener: NetworkPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol NetworkListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class NetworkInteractor: PresentableInteractor<NetworkPresentable>, NetworkInteractable {

    // MARK: Properties

    weak var router: NetworkRouting?
    weak var listener: NetworkListener?

    // MARK: Initialization

    override init(presenter: NetworkPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

// MARK: - NetworkPresentableListener

extension NetworkInteractor: NetworkPresentableListener {

    func search(with term: String) {
    }

}
