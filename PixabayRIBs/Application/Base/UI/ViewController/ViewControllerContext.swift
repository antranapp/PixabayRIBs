//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

protocol ViewControllerContextHolder: class {
    var context: ViewControllerContext! { get set }
}

class ViewControllerContext {

    public var networkPixaBayService: NetworkPixabayService
    public var memoryPixaBayService: MemoryPixabayService
    public var filesystemPixaBayService: FilesystemPixabayService

    init(networkPixaBayService: NetworkPixabayService, memoryPixaBayService: MemoryPixabayService, filesystemPixaBayService: FilesystemPixabayService) {
        self.networkPixaBayService = networkPixaBayService
        self.memoryPixaBayService = memoryPixaBayService
        self.filesystemPixaBayService = filesystemPixaBayService
    }
}

extension UIViewController {

    func setViewControllerContext(_ context: ViewControllerContext!) {
        if let contextHolder = self as? ViewControllerContextHolder {
            contextHolder.context = context
        }
    }

    static func instantiateController<T: UIViewController>(storyboard storyboardName: String, bundleClass bundle: AnyClass, context: ViewControllerContext, identifier: String? = nil) -> T {

        // Create ViewController from storyboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: bundle))

        let viewController: UIViewController?
        if let identifier = identifier {
            viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        } else {
            viewController = storyboard.instantiateInitialViewController()
        }

        // Set context
        viewController?.setViewControllerContext(context)

        // Return UIVieController type-casted
        guard let result = viewController as? T else {
            preconditionFailure("Wrong Type")
        }
        return result
    }

}
