//
//  PostsFetcher.swift
//  Marsiple
//
//  Created by Matej Korman on 17/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

enum DataFetcherError: LocalizedError {
    case urlCreationFailure
    case dataUnwrapingFailure
    case parsingDataFailure
    case generic(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlCreationFailure:
            return LocalizationKey.DataFetcherError.urlCreationFailure.localized()
        case .dataUnwrapingFailure:
            return LocalizationKey.DataFetcherError.dataUnwrapingFailure.localized()
        case .parsingDataFailure:
            return LocalizationKey.DataFetcherError.parsingDataFailure.localized()
        case .generic(let error):
            return error.localizedDescription
        }
    }
}

struct DataFetcher {
    static func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?.appendingPathComponent("posts")
            else { return DispatchQueue.main.async { failure(DataFetcherError.urlCreationFailure) } }
        getData(url: url, success: success, failure: failure)
    }
    
    static func getAlbums(success: @escaping ([Album]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?.appendingPathComponent("albums")
            else { return DispatchQueue.main.async { failure(DataFetcherError.urlCreationFailure) } }
        getData(url: url, success: success, failure: failure)
    }
    
    static func getPhotos(albumId: Int, success: @escaping ([Photo]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?
                            .appendingPathComponent("albums")
                            .appendingPathComponent("\(albumId)")
                            .appendingPathComponent("photos")
            else { return DispatchQueue.main.async { failure(DataFetcherError.urlCreationFailure) } }
        getData(url: url, success: success, failure: failure)
    }
}

private extension DataFetcher {
    static func getData<DataType: Codable>(url: URL, success: @escaping ([DataType]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        let request = setupRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error { return DispatchQueue.main.async { failure(DataFetcherError.generic(error)) } }
            do {
                guard let unwrappedData = data
                    else { return DispatchQueue.main.async { failure(DataFetcherError.dataUnwrapingFailure) } }
                let data = try JSONDecoder().decode([DataType].self, from: unwrappedData)
                DispatchQueue.main.async { success(data) }
            } catch {
                DispatchQueue.main.async { failure(DataFetcherError.parsingDataFailure) }
            }
        }
        task.resume()
    }
    
    static func setupRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPRequestMethod.get
        request.addValue(MartianApi.Headers.contentTypeValue, forHTTPHeaderField: HTTPRequestHeader.contentType)
        request.addValue(MartianApi.Headers.xAuthValue, forHTTPHeaderField: HTTPRequestHeader.xAuth)
        return request
    }
}
