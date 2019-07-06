//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol FilesystemDependency: Dependency {
    var filesystemPixabayService: FilesystemPixabayService { get }
}

final class FilesystemComponent: Component<FilesystemDependency> {
    var pixabayService: PixaBayService {
        return dependency.filesystemPixabayService
    }
}

// MARK: - Builder

protocol FilesystemBuildable: Buildable {
    func build(withListener listener: FilesystemListener) -> FilesystemRouting
}

final class FilesystemBuilder: Builder<FilesystemDependency>, FilesystemBuildable {

    override init(dependency: FilesystemDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FilesystemListener) -> FilesystemRouting {
        let component = FilesystemComponent(dependency: dependency)
        let viewController = FilesystemViewController()
        let interactor = FilesystemInteractor(presenter: viewController, pixaBayService: component.pixabayService)
        interactor.listener = listener

        // Children
        let detailBuilder = DetailBuilder(dependency: component)

        return FilesystemRouter(interactor: interactor, viewController: viewController, detailBuilder: detailBuilder)
    }
}
