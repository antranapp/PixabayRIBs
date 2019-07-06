//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol MemoryDependency: MemoryDependencyDetail {
    var memoryPixabayService: MemoryPixabayService { get }
}

final class MemoryComponent: Component<MemoryDependency> {
    var pixabayService: PixaBayService {
        return dependency.memoryPixabayService
    }
}

// MARK: - Builder

protocol MemoryBuildable: Buildable {
    func build(withListener listener: MemoryListener) -> MemoryRouting
}

final class MemoryBuilder: Builder<MemoryDependency>, MemoryBuildable {

    override init(dependency: MemoryDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MemoryListener) -> MemoryRouting {
        let component = MemoryComponent(dependency: dependency)
        let viewController = MemoryViewController()
        let interactor = MemoryInteractor(presenter: viewController, pixaBayService: component.pixabayService)
        interactor.listener = listener

        // Children
        let detailBuilder = DetailBuilder(dependency: component)

        return MemoryRouter(interactor: interactor, viewController: viewController, detailBuilder: detailBuilder)
    }
}
