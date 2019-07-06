//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift

protocol FilesystemRouting: ViewableRouting {
    func routeToDetail(for image: Image)
}

protocol FilesystemPresentable: Presentable {
    var listener: FilesystemPresentableListener! { get set }
}

protocol FilesystemListener: class {
    func dismiss(_ router: FilesystemRouting?)
}

final class FilesystemInteractor: PresentableInteractor<FilesystemPresentable>, FilesystemInteractable, FilesystemPresentableListener {

    weak var router: FilesystemRouting?
    weak var listener: FilesystemListener?

    // NetworkPresentableListener

    var searchTerm = BehaviorRelay<String>(value: "")
    var imageList = BehaviorRelay<ImageList>(value: ImageList(total: 0, totalHits: 0, hits: []))
    let activity = PublishRelay<Bool>()

    // Private

    private let disposeBag = DisposeBag()

    private let pixaBayService: PixaBayService

    // MARK: Initialization

    init(presenter: FilesystemPresentable, pixaBayService: PixaBayService) {

        self.pixaBayService = pixaBayService

        super.init(presenter: presenter)
        presenter.listener = self

        setupBindings()

    }

    // MARK: MemoryPresentableListener

    func fetchImage(with searchTerm: String) {
        pixaBayService.fetch(searchTerm: searchTerm)
            .done { [weak self] imageList in
                self?.imageList.accept(imageList)
            }
            .catch { error in
                print(error)
            }
            .finally {
                self.activity.accept(false)
        }
    }

    func didSelect(_ image: Image) {
        router?.routeToDetail(for: image)
    }

    func dismiss() {
        listener?.dismiss(router)
    }

    // MARK: Private helpers

    private func setupBindings() {
        searchTerm.subscribe(onNext: { value in
            if value.count > 2 {
                self.fetchImage(with: value)
            }
        }).disposed(by: disposeBag)

    }
}
