//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import PromiseKit

/// Declare methods the interactor can invoke to manage sub-tree via the router.
protocol NetworkRouting: ViewableRouting {
    func routeToDetail(for image: Image)
}

/// Declare methods the interactor can invoke the presenter to present data.
protocol NetworkPresentable: Presentable {
    var listener: NetworkPresentableListener! { get set }
}

/// Declare methods the interactor can invoke to communicate with other RIBs.
protocol NetworkListener: class {
    func dismiss(_ router: NetworkRouting?)
}

final class NetworkInteractor: PresentableInteractor<NetworkPresentable>, NetworkInteractable, NetworkPresentableListener {

    // MARK: Properties

    // Public
    weak var router: NetworkRouting?
    weak var listener: NetworkListener?

    // NetworkPresentableListener
    var searchTerm: BehaviorRelay<String>
    var imageList: BehaviorRelay<ImageList>
    let activity = PublishRelay<Bool>()

    // Private

    private let disposeBag = DisposeBag()

    private let pixaBayService: PixaBayService

    // MARK: Initialization

    init(presenter: NetworkPresentable, pixaBayService: PixaBayService) {
        self.pixaBayService = pixaBayService

        searchTerm = BehaviorRelay<String>(value: "")
        imageList = BehaviorRelay<ImageList>(value: ImageList(total: 0, totalHits: 0, hits: []))

        super.init(presenter: presenter)
        presenter.listener = self

        setupBindings()
    }

    // MARK: NetworkPresentableListener

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
