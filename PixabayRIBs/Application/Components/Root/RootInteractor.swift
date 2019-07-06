//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift

/// Declare methods the interactor can invoke to manage sub-tree via the router.
protocol RootRouting: ViewableRouting {
    func routeToNetwork()
}

/// Declare methods the interactor can invoke the presenter to present data.
protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

/// Declare methods the interactor can invoke to communicate with other RIBs.
protocol RootListener: class {
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable {

    // MARK: Properties

    weak var router: RootRouting?
    weak var listener: RootListener?

    // MARK: Initialization

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
}

extension RootInteractor: RootPresentableListener {

    func presentNetworkViewController() {
        router?.routeToNetwork()
    }

    func presentMemoryViewController() {

    }

    func presentFilesystemViewController() {

    }

}
