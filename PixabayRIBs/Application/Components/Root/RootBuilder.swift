//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol RootDependency: RootDependencyNetwork {
}

final class RootComponent: Component<RootDependency> {

    let rootViewController: RootViewController

    init(dependency: RootDependency, rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)

        // Children
        let networkBuilder = NetworkBuilder(dependency: component)

        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          networkBuilder: networkBuilder)
    }
}
