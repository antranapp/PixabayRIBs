//
//  NetworkComponent+Detail.swift
//  PixabayRIBs
//
//  Created by An Tran on 06.07.19.
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Network to provide for the Detail scope.
protocol NetworkDependencyDetail: Dependency {
}

/// Implement properties to provide for Detail scope.
extension NetworkComponent: DetailDependency {

}
