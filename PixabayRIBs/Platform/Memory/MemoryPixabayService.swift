//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation
import PromiseKit

class MemoryPixabayService: PixaBayService {

    // MARK: APIs

    func fetch(searchTerm: String) -> Promise<ImageList> {
        var result = ImageList(total: 0, totalHits: 0, hits: [])
        switch searchTerm {
        case "car":
            result.hits = makeCarImages()
        case "flower":
            result.hits = makeFlowerImages()
        case "sky":
            result.hits = makeSkyImages()
        default:
            break
        }

        return Promise.value(result)
    }

    // MARK: Private helpers

    private func makeCarImages() -> [Image] {
        return [
            Image (
                id: 1,
                largeImageURL: "https://cdn.pixabay.com/user/2014/11/14/05-39-07-629_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2014/09/03/20/15/legs-434918_150.jpg"
            ),
            Image (
                id: 2,
                largeImageURL: "https://cdn.pixabay.com/user/2018/06/27/01-23-02-27_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2015/08/13/17/24/vintage-1950s-887272_150.jpg"
            ),
            Image (
                id: 3,
                largeImageURL: "https://cdn.pixabay.com/user/2014/06/04/17-13-09-273_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2014/06/04/16/36/car-repair-362150_150.jpg"
            )
        ]
    }

    private func makeSkyImages() -> [Image] {
        return [
            Image (
                id: 1,
                largeImageURL: "https://cdn.pixabay.com/user/2014/05/07/00-10-34-2_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2015/03/26/09/47/sky-690293_150.jpg"
            ),
            Image (
                id: 2,
                largeImageURL: "https://cdn.pixabay.com/user/2018/01/12/08-06-25-409_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2018/01/12/10/19/fantasy-3077928_150.jpg"
            ),
            Image (
                id: 3,
                largeImageURL: "https://cdn.pixabay.com/user/2015/06/13/06-38-56-116_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2013/11/28/10/36/road-220058_150.jpg"
            )
        ]
    }

    private func makeFlowerImages() -> [Image] {
        return [
            Image (
                id: 1,
                largeImageURL: "https://cdn.pixabay.com/user/2014/12/05/19-40-25-41_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2014/12/17/21/30/wild-flowers-571940_150.jpg"
            ),
            Image (
                id: 2,
                largeImageURL: "https://cdn.pixabay.com/user/2018/06/27/01-23-02-27_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2018/02/08/22/27/flower-3140492_150.jpg"
            ),
            Image (
                id: 3,
                largeImageURL: "https://cdn.pixabay.com/user/2016/01/10/09-32-50-295_250x250.jpg",
                previewURL: "https://cdn.pixabay.com/photo/2016/01/08/11/57/butterfly-1127666_150.jpg"
            )
        ]
    }
}
