//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RIBs
import RxSwift

protocol DetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailPresentable: Presentable {
    var listener: DetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailInteractor: PresentableInteractor<DetailPresentable>, DetailInteractable, DetailPresentableListener {

    weak var router: DetailRouting?
    weak var listener: DetailListener?

    var image: Image

    init(presenter: DetailPresentable, image: Image) {
        self.image = image
        super.init(presenter: presenter)
        presenter.listener = self
    }
}
