//
//  PostsFetcher.swift
//  Marsiple
//
//  Created by Matej Korman on 17/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum PostsFetcherError: LocalizedError {
    case urlCreationFailure
    case dataUnwrapingFailure
    case parsingDataFailure
    case generic(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlCreationFailure:
            return LocalizationKey.PostsFetcherError.urlCreationFailure.localized()
        case .dataUnwrapingFailure:
            return LocalizationKey.PostsFetcherError.dataUnwrapingFailure.localized()
        case .parsingDataFailure:
            return LocalizationKey.PostsFetcherError.parsingDataFailure.localized()
        case .generic(let error):
            return error.localizedDescription
        }
    }
}

struct PostsFetcher {
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?.appendingPathComponent("posts")
            else { return DispatchQueue.main.async { failure(PostsFetcherError.urlCreationFailure) } }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPRequestMethod.get
        request.addValue(MartianApi.Headers.contentTypeValue, forHTTPHeaderField: HTTPRequestHeader.contentType)
        request.addValue(MartianApi.Headers.xAuthValue, forHTTPHeaderField: HTTPRequestHeader.xAuth)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            do {
                guard let unwrappedData = data
                    else { return DispatchQueue.main.async { failure(PostsFetcherError.dataUnwrapingFailure) } }
                let posts = try JSONDecoder().decode([Post].self, from: unwrappedData)
                DispatchQueue.main.async { success(posts) }
            } catch {
                DispatchQueue.main.async { failure(PostsFetcherError.parsingDataFailure) }
            }
        }
        task.resume()
    }
}
