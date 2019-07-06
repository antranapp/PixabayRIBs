//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import Kingfisher

/// Declare properties and methods that the view controller can invoke to perform
/// business logic, such as signIn(). This protocol is implemented by the corresponding
/// interactor class.
protocol NetworkPresentableListener: class {

    var searchTerm: BehaviorRelay<String> { get }
    var imageList: BehaviorRelay<ImageList> { get }
    var activity: PublishRelay<Bool> { get }

    func fetchImage(with term: String)

    func didSelect(_ image: Image)
}

final class NetworkViewController: UIViewController, NetworkPresentable, NetworkViewControllable {

    // MARK: Properties

    // Public

    var listener: NetworkPresentableListener!

    // IBOutlets

    @IBOutlet weak var searchTermTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // Private

    private var activityIndicator: UIActivityIndicatorView!

    let disposeBag = DisposeBag()

    // MARK: Setup ViewModel

    //lazy var viewModel = ImageListViewModel(service: context.pixelBayService)

    // MARK: Lifecyles

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        activityIndicator = UIActivityIndicatorView(style: .gray)
        let rightButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = rightButton

        // UI Binding
        searchTermTextField.rx.text
            .orEmpty
            .bind(to: listener.searchTerm)
            .disposed(by: disposeBag)

        // Observe Property
        listener.imageList.subscribe(
            onNext: { imageList in
                self.tableView.reloadData()
            }
        ).disposed(by: disposeBag)

        // Observe Signal
        listener.activity.subscribe(
            onNext: { value in
                DispatchQueue.main.async {
                    value ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
                }
            }
        ).disposed(by: disposeBag)

        tableView.register(UINib(nibName: "ImageListTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageListTableViewCell")

        title = "List"
    }

    func present(view: ViewControllable) {
        navigationController?.pushViewController(view.uiviewController, animated: true)
    }
}

extension NetworkViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listener?.imageList.value.hits.count ?? 0
    }
}

extension NetworkViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ImageListTableViewCell") as! ImageListTableViewCell

        let imageItem = listener.imageList.value.hits[indexPath.row]
        cell.titleLabel?.text = imageItem.previewURL
        guard let url = URL(string: imageItem.previewURL) else {
            return cell
        }

        cell.previewImageView.kf.setImage(with: url)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageItem = listener.imageList.value.hits[indexPath.row]
        listener.didSelect(imageItem)
    }
}
