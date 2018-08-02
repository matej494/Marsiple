//
//  DataFetcher.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

class MartianApiManager {
    static func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?.appendingPathComponent(MartianApi.URLs.posts)
            else { return DispatchQueue.main.async { failure(DataManagerError.urlCreationFailure) } }
        getData(url: url, success: success, failure: failure)
    }
    
    static func getComments(forPostId id: Int, success: @escaping ([Comment]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?
                            .appendingPathComponent(MartianApi.URLs.posts)
                            .appendingPathComponent("\(id)")
                            .appendingPathComponent(MartianApi.URLs.comments)
            else { return DispatchQueue.main.async { failure(DataManagerError.urlCreationFailure) } }
        getData(url: url, success: success, failure: failure)
    }
    
    static func postComment(comment: Comment, success: @escaping (String) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?
                            .appendingPathComponent(MartianApi.URLs.posts)
                            .appendingPathComponent("\(comment.postId)")
                            .appendingPathComponent(MartianApi.URLs.comments)
            else { return }
        postData(data: comment, url: url, success: success, failure: failure)
    }
}

private extension MartianApiManager {
    static func getData<DataType: Codable>(url: URL, success: @escaping ([DataType]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        let request = setupRequest(url: url, method: HTTPRequestMethod.get)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return DispatchQueue.main.async { failure(DataManagerError.generic(error)) }
            }
            do {
                guard let unwrappedData = data
                    else { return DispatchQueue.main.async { failure(DataManagerError.dataUnwrapingFailure) } }
                let posts = try JSONDecoder().decode([DataType].self, from: unwrappedData)
                DispatchQueue.main.async { success(posts) }
            } catch {
                DispatchQueue.main.async { failure(DataManagerError.parsingDataFailure) }
            }
        }
        task.resume()
    }
    
    static func postData<DataType: Codable>(data: DataType, url: URL, success: @escaping (String) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let json = encodeData(data: data)
            else { return DispatchQueue.main.async { failure(DataManagerError.dataEncodingFailure) } }
        let request = setupRequest(url: url, method: HTTPRequestMethod.post, body: json)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return DispatchQueue.main.async { failure(DataManagerError.generic(error)) }
            }
            guard let httpResponse = response as? HTTPURLResponse
                else { return DispatchQueue.main.async { failure(DataManagerError.castingResponseFailure) } }
            if httpResponse.statusCode == HTTPResponseCode.created.rawValue {
                return DispatchQueue.main.async { success(HTTPResponseCode.created.message) }
            } else {
                return DispatchQueue.main.async { failure(DataManagerError.httpResponseCode(httpResponse.statusCode)) }
            }
        }
        task.resume()
    }

    static func setupRequest(url: URL, method: String, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(MartianApi.Headers.defaultContentType, forHTTPHeaderField: HTTPRequestHeader.contentType)
        request.addValue(MartianApi.Headers.xAuthValue, forHTTPHeaderField: HTTPRequestHeader.xAuth)
        request.httpBody = body
        return request
    }
    
    static func encodeData<DataType: Codable>(data: DataType) -> Data? {
        do {
            return try JSONEncoder().encode(data)
        } catch {
            print("Error encoding data.")
            return nil
        }
    }
}
