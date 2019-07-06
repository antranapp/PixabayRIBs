//
//  DetailRouter.swift
//  PixabayRIBs
//
//  Created by An Tran on 06.07.19.
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs

protocol DetailInteractable: Interactable {
    var router: DetailRouting? { get set }
    var listener: DetailListener? { get set }
}

protocol DetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DetailRouter: ViewableRouter<DetailInteractable, DetailViewControllable>, DetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DetailInteractable, viewController: DetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
