//
//  URLSessionExtension.swift
//  
//
//  Created by Yurii Samoienko on 05.05.2022.
//

import Foundation

public extension URLSession {
    
    // MARK: Public Functions
    
    @discardableResult
    func runDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: request, completionHandler: completionHandler)
        task.resume()
        return task
    }

    @discardableResult
    func runDataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
        return task
    }
    
}
