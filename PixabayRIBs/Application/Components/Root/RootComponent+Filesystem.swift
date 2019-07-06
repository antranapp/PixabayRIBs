//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol RootDependencyFilesystem: Dependency {
}

extension RootComponent: FilesystemDependency {

    var filesystemPixabayService: FilesystemPixabayService {
        return FilesystemPixabayService()
    }
}
