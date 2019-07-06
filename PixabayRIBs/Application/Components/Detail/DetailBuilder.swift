//
//  DetailBuilder.swift
//  PixabayRIBs
//
//  Created by An Tran on 06.07.19.
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol DetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DetailComponent: Component<DetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
