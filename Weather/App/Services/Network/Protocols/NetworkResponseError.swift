//
//  NetworkResponseError.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

enum NetworkResponseError: Error {
    case status(code: Int)
    case data(message: String?)
    case error(message: String?)
    case url(message: String?)
}


extension NetworkResponseError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .status(code: let code):
            return "⚠️\tNetwork > Status Code = \(code)"
        case .data(message: let message):
            return "⚠️\tNetwork > \(message ?? "")"
        case .error(message: let message):
            return "⚠️\tNetwork > \(message ?? "")"
        case .url(message: let message):
            return "⚠️\tNetwork > \(message ?? "")"
        }
    }
}
