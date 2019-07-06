//
//  MemoryComponent+Detail.swift
//  PixabayRIBs
//
//  Created by An Tran on 06.07.19.
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Memory to provide for the Detail scope.
// TODO: Update MemoryDependency protocol to inherit this protocol.
protocol MemoryDependencyDetail: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Memory to provide dependencies
    // for the Detail scope.
}

extension MemoryComponent: DetailDependency {

    // TODO: Implement properties to provide for Detail scope.
}
