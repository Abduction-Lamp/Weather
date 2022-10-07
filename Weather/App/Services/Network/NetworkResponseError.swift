//
//  NetworkResponseError.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

enum NetworkResponseError: Error {
    case status (url: String, code: Int?)
    case error  (url: String, message: String?)
    case data   (url: String, message: String?)
    case decode (url: String, message: String?)
    case url    (message: String?)
}

extension NetworkResponseError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .status(let url, let code):
            return "⚠️ Network > Status [\(url)] > status = \(code ?? 0)"
        case .error(let url, let message):
            return "⚠️ Network > Error [\(url)] > message: \(message ?? "")"
        case .data(let url, let message):
            return "⚠️ Network > Data [\(url)] > message: \(message ?? "")"
        case .decode(let url, let message):
            return "⚠️ Network > Decode [\(url)] > message: \(message ?? "")"
        case .url(message: let message):
            return "⚠️ Network > URL [] > message: \(message ?? "")"
        }
    }
}
