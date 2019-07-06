//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

/// Declare the set of dependencies required by this RIB, but cannot be
/// created by this RIB.
protocol DetailDependency: Dependency {
}

final class DetailComponent: Component<DetailDependency> {
}

// MARK: - Builder

protocol DetailBuildable: Buildable {
    func build(withListener listener: DetailListener, image: Image) -> DetailRouting
}

final class DetailBuilder: Builder<DetailDependency>, DetailBuildable {

    override init(dependency: DetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailListener, image: Image) -> DetailRouting {
        let _ = DetailComponent(dependency: dependency)
        let viewController = DetailViewController()
        let interactor = DetailInteractor(presenter: viewController, image: image)
        interactor.listener = listener
        return DetailRouter(interactor: interactor, viewController: viewController)
    }
}
