//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, ViewControllerContextHolder {

    var context: ViewControllerContext! {
        didSet {
            topViewController?.setViewControllerContext(context)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.setViewControllerContext(context)
    }
}
