//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol NetworkPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.

    func search(with term: String)
}

final class NetworkViewController: UIViewController, NetworkPresentable, NetworkViewControllable {

    weak var listener: NetworkPresentableListener?

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

}
