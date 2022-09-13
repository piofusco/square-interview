//
// Created by Michael Pace on 9/13/22.
//

import Foundation

protocol SquareURLSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SquareURLSessionDataTask
}

extension URLSession: SquareURLSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SquareURLSessionDataTask {
        dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

public protocol SquareURLSessionDataTask {
    func resume()
}

extension URLSessionDataTask: SquareURLSessionDataTask {}
