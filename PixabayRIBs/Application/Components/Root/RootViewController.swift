//
//  RootViewController.swift
//  PixabayRIBs
//
//  Created by An Tran on 05.07.19.
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?


    @IBAction func didTapNetworkButton(_ sender: Any) {
        print("network")
    }


    @IBAction func didTapMemoryButton(_ sender: Any) {
        print("memory")
    }

    @IBAction func didTapFilesystemButton(_ sender: Any) {
        print("filesystem")
    }

}
