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
            else { return DispatchQueue.main.async { failure(DataFetcherError.urlCreationFailure) } }
        getData(url: url, success: success, failure: failure)
    }
    
    static func getComments(forPostId id: Int, success: @escaping ([Comment]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = MartianApi.url?
                            .appendingPathComponent(MartianApi.URLs.posts)
                            .appendingPathComponent("\(id)")
                            .appendingPathComponent(MartianApi.URLs.comments)
            else { return DispatchQueue.main.async { failure(DataFetcherError.urlCreationFailure) } }
        getData(url: url, success: success, failure: failure)
    }
    
    static func postComment(comment: Comment) {
        guard let url = MartianApi.url?
                            .appendingPathComponent(MartianApi.URLs.posts)
                            .appendingPathComponent("\(comment.postId)")
                            .appendingPathComponent(MartianApi.URLs.comments)
            else { return }
        let json: [String: String] = ["name": comment.name, "email": comment.email, "body": comment.body]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            postData(data: jsonData, url: url)
        } catch {
            print("Error serializing Json")
        }
    }
}

private extension MartianApiManager {
    static func getData<DataType: Codable>(url: URL, success: @escaping ([DataType]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        let request = setupRequest(url: url, method: HTTPRequestMethod.get)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
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
    
    static func postData(data: Data, url: URL) {
        let request = setupRequest(url: url, method: HTTPRequestMethod.post, body: data)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let response = response {
                print(response)
            }
        }
        task.resume()
    }

    static func setupRequest(url: URL, method: String, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(MartianApi.Headers.contentTypeValue, forHTTPHeaderField: HTTPRequestHeader.contentType)
        request.addValue(MartianApi.Headers.xAuthValue, forHTTPHeaderField: HTTPRequestHeader.xAuth)
        request.httpBody = body
        return request
    }
}
