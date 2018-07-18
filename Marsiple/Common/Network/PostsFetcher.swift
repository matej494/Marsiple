//
//  PostsFetcher.swift
//  Marsiple
//
//  Created by Matej Korman on 17/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct PostsFetcher {
    func get(succes: @escaping ([Post]) -> Void, faliure: @escaping (String) -> Void) {
        guard let url = URL(string: MartianApi.url + "/posts")
            else { return DispatchQueue.main.async { faliure("Error creating URL.") } }
        var request = URLRequest(url: url)
        request.httpMethod = MartianApi.Methods.get
        request.addValue(MartianApi.Headers.contentTypeValue, forHTTPHeaderField: MartianApi.Headers.contentType)
        request.addValue(MartianApi.Headers.xAuthValue, forHTTPHeaderField: MartianApi.Headers.xAuth)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            do {
                guard let unwrappedData = data
                    else { return DispatchQueue.main.async { faliure("Error unwrapping data.") } }
                let posts = try JSONDecoder().decode([Post].self, from: unwrappedData)
                DispatchQueue.main.async { succes(posts) }
            } catch {
                DispatchQueue.main.async { faliure("Error parsing data.") }
            }
        }
        task.resume()
    }
}
