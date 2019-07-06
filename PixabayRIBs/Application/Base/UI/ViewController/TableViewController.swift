//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ViewControllerProtocol {

    var context: ViewControllerContext!

    init(context: ViewControllerContext) {
        super.init(nibName: nil, bundle: nil)
        self.context = context
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
