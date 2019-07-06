//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol NetworkDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class NetworkComponent: Component<NetworkDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol NetworkBuildable: Buildable {
    func build(withListener listener: NetworkListener) -> NetworkRouting
}

final class NetworkBuilder: Builder<NetworkDependency>, NetworkBuildable {

    override init(dependency: NetworkDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: NetworkListener) -> NetworkRouting {
        let _ = NetworkComponent(dependency: dependency)
        let viewController = NetworkViewController()
        let interactor = NetworkInteractor(presenter: viewController)
        interactor.listener = listener
        return NetworkRouter(interactor: interactor, viewController: viewController)
    }
}
