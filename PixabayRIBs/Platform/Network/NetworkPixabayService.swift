//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class NetworkPixabayService: PixaBayService {

    func fetch(searchTerm: String) -> Promise<ImageList> {
        let urlString = "https://pixabay.com/api/?key=107764-f19c20d5ca4d545d9b0a09de3&q=\(searchTerm)&image_type=photo&pretty=true"
        let url = URL(string: urlString)!

        return Promise { resolver in
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil else {
                    resolver.reject(ServiceNetworkError.httpError(error!))
                    return
                }

                guard let data = data else {
                    resolver.reject(ServiceNetworkError.noData)
                    return
                }


                do {
                    let decoder = JSONDecoder()
                    let imageData = try decoder.decode(ImageList.self, from: data)
                    resolver.resolve(.fulfilled(imageData))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context.debugDescription)
                    resolver.reject(ServiceParsingError.dataCorrupted)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found: \(context.debugDescription)")
                    print("codingPath: \(context.codingPath)")
                    resolver.reject(ServiceParsingError.keyNotFound)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found: \(context.debugDescription)")
                    print("codingPath: \(context.codingPath)")
                    resolver.reject(ServiceParsingError.valueNotFound)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch: \(context.debugDescription)")
                    print("codingPath: \(context.codingPath)")
                    resolver.reject(ServiceParsingError.typeMismatch)
                } catch {
                    print("error: \(error)")
                    resolver.reject(ServiceParsingError.generalError(error))
                }
                }.resume()
        }
    }
}

enum ServiceNetworkError: Error {
    case noData
    case httpError(_ error: Error)
}

enum ServiceParsingError: Error {
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case typeMismatch
    case generalError(_ error: Error)
}
