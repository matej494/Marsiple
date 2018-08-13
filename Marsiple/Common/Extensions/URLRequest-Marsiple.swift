//
//  URLRequest-Marsiple.swift
//  Marsiple
//
//  Created by Matej Korman on 13/08/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

extension URLRequest {
    static func martianApiURLRequest(url: URL, method: HTTPRequestMethod, body: Data? = nil) -> URLRequest {
        var URLRequest = self.init(url: url)
        URLRequest.httpMethod = method.rawValue
        URLRequest.addValue(MartianApi.Headers.defaultContentType, forHTTPHeaderField: HTTPRequestHeader.contentType)
        URLRequest.addValue(MartianApi.Headers.xAuthValue, forHTTPHeaderField: HTTPRequestHeader.xAuth)
        URLRequest.httpBody = body
        return URLRequest
    }
}
