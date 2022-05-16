//
//  URLSessionDataTaskProtocol.swift
//  Weather
//
//  Created by Владимир on 13.05.2022.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
