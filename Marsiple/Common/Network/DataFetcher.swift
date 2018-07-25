//
//  DataFetcher.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

class DataFetcher {
    static func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?.appendingPathComponent(MartianApi.URLs.posts)
            else { return DispatchQueue.main.async { failure(DataFetcherError.urlCreationFailure) } }
        
        getData(url: url, method: HTTPRequestMethod.get, success: success, failure: failure)
    }
    
    static func getComments(forPostId id: Int, success: @escaping ([Comment]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?
                            .appendingPathComponent(MartianApi.URLs.posts)
                            .appendingPathComponent("\(id)")
                            .appendingPathComponent(MartianApi.URLs.comments)
            else { return DispatchQueue.main.async { failure(DataFetcherError.urlCreationFailure) } }
        getData(url: url, method: HTTPRequestMethod.get, success: success, failure: failure)
    }
}

private extension DataFetcher {
    static func getData<DataType: Codable>(url: URL,
                                           method: String,
                                           success: @escaping ([DataType]) -> Void,
                                           failure: @escaping (LocalizedError) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(MartianApi.Headers.defaultContentType, forHTTPHeaderField: HTTPRequestHeader.contentType)
        request.addValue(MartianApi.Headers.xAuthValue, forHTTPHeaderField: HTTPRequestHeader.xAuth)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return DispatchQueue.main.async { failure(DataFetcherError.generic(error)) }
            }
            do {
                guard let unwrappedData = data
                    else { return DispatchQueue.main.async { failure(DataFetcherError.dataUnwrapingFailure) } }
                let posts = try JSONDecoder().decode([DataType].self, from: unwrappedData)
                DispatchQueue.main.async { success(posts) }
            } catch {
                DispatchQueue.main.async { failure(DataFetcherError.parsingDataFailure) }
            }
        }
        task.resume()
    }
}
