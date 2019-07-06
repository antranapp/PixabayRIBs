//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemPixabayService: PixaBayService {

    private var emptyImageList: ImageList {
        return ImageList(total: 0, totalHits: 0, hits: [])
    }

    func fetch(searchTerm: String) -> Promise<ImageList> {

        switch searchTerm {
        case "car", "flower", "sky":
            return Promise.value(decode(searchTerm))
        default:
            return Promise.value(emptyImageList)
        }
    }

    func decode(_ file: String) -> ImageList {
        do {
            let url = Bundle.main.url(forResource: file, withExtension: ".json")!
            let jsonDecoder = JSONDecoder()
            let fileData = try Data(contentsOf: url)
            let imageList = try jsonDecoder.decode(ImageList.self, from: fileData)

            return imageList
        } catch {
            return emptyImageList
        }
    }
}
