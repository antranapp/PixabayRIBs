//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

protocol PixaBayService: ServiceProtocol {
    func fetch(searchTerm: String) -> Promise<ImageList>
}
