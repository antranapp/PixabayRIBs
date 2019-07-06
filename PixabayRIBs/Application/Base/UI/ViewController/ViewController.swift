//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerProtocol {

    var context: ViewControllerContext!

    init(context: ViewControllerContext) {
        super.init(nibName: nil, bundle: nil)
        self.context = context
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
