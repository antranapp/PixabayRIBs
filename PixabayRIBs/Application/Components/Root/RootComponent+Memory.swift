//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol RootDependencyMemory: Dependency {
}

extension RootComponent: MemoryDependency {

    var memoryPixabayService: MemoryPixabayService {
        return MemoryPixabayService()
    }
}
