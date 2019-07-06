//
//  Copyright © 2019 An Tran. All rights reserved.
//

struct ImageList: Decodable {
    var total: Int
    var totalHits: Int
    var hits: [Image]
}
