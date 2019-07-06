//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift
import UIKit

protocol FilesystemPresentableListener: class {
    var searchTerm: BehaviorRelay<String> { get }
    var imageList: BehaviorRelay<ImageList> { get }
    var activity: PublishRelay<Bool> { get }

    func fetchImage(with term: String)

    func didSelect(_ image: Image)

    func dismiss()
}

final class FilesystemViewController: UIViewController, FilesystemPresentable, FilesystemViewControllable {

    // MARK: Properties

    // Public

    weak var listener: FilesystemPresentableListener!

    // IBOutlets

    @IBOutlet weak var searchPickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!

    // Private

    let disposeBag = DisposeBag()

    // MARK: Lifecyles

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "ImageListTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageListTableViewCell")

        title = "Memory"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCurrentView))

        Observable.just(["car", "sky", "flower"])
            .bind(to: searchPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)

        // UI Binding
        searchPickerView.rx
            .modelSelected(String.self)
            .map { $0.first! }
            .bind(to: listener.searchTerm)
            .disposed(by: disposeBag)

        // Observe Property
        listener.imageList.subscribe(
            onNext: { imageList in
                self.tableView.reloadData()
        }
            ).disposed(by: disposeBag)
    }

    func present(view: ViewControllable) {
        navigationController?.pushViewController(view.uiviewController, animated: true)
    }

    @objc func dismissCurrentView() {
        listener?.dismiss()
    }
}

extension FilesystemViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listener.imageList.value.hits.count
    }
}

extension FilesystemViewController: UITableViewDelegate {

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
