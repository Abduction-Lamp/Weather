//
//  NetworkResponseError.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

enum NetworkResponseError: Error {
    case error(url: String, message: String?)
    case status(url: String, code: Int?)
    case data(url: String, message: String?)
    case decode(url: String, message: String?)
    case url(message: String?)
}

extension NetworkResponseError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .error(url: let url, message: let message):
            return "⚠️\tNetwork > Error [\(url)]\n\tmessage: \(message ?? "")"
        case .status(url: let url, code: let code):
            return "⚠️\tNetwork > Status Code [\(url)]\n\tcode: \(code ?? 0)"
        case .data(url: let url, message: let message):
            return "⚠️\tNetwork > Data [\(url)]\n\tmessage: \(message ?? "")"
        case .decode(url: let url, message: let message):
            return "⚠️\tNetwork > Decode [\(url)]\n\tmessage: \(message ?? "")"
        case .url(message: let message):
            return "⚠️\tNetwork : \(message ?? "")"
        }
    }
}
