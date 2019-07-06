//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Network scope.
protocol RootDependencyNetwork: Dependency {
}

/// Implement properties to provide for Network scope.
extension RootComponent: NetworkDependency {

    var parentViewController: RootViewControllable {
        return rootViewController
    }

    var pixabayService: NetworkPixabayService {
        return NetworkPixabayService()
    }
}
