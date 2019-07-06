//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

/// Declare properties and methods that the view controller can invoke to perform
/// business logic, such as signIn(). This protocol is implemented by the corresponding
/// interactor class.
protocol DetailPresentableListener: class {
    var image: Image { get }
}

final class DetailViewController: UIViewController, DetailPresentable, DetailViewControllable {

    weak var listener: DetailPresentableListener?
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let image = listener?.image else { return }

        guard let url = URL(string: image.largeImageURL) else { return }

        imageView.kf.setImage(with: url)
    }
}
