//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

/// Declare the set of dependencies required by this RIB, but cannot be
/// created by this RIB.
protocol NetworkDependency: NetworkDependencyDetail {
    var pixabayService: NetworkPixabayService { get }
    var parentViewController: RootViewControllable { get }
}

/// Declare 'fileprivate' dependencies that are only used by this RIB.
final class NetworkComponent: Component<NetworkDependency> {
    var pixabayService: PixaBayService {
        return dependency.pixabayService
    }
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
        let component = NetworkComponent(dependency: dependency)
        let viewController = NetworkViewController()
        let interactor = NetworkInteractor(presenter: viewController, pixaBayService: dependency.pixabayService)
        interactor.listener = listener

        // Children
        let detailBuilder = DetailBuilder(dependency: component)

        return NetworkRouter(interactor: interactor, viewController: viewController, detailBuilder: detailBuilder)
    }
}
