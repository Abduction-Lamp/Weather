//
//  URLSessionProtocol.swift
//  Weather
//
//  Created by Владимир on 12.05.2022.
//

import Foundation

protocol URLSessionProtocol {
    func dataTaskEx(with url: URL,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    
    func dataTaskEx(with url: URL,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}
