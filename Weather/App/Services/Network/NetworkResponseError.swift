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
            return "⚠️ Network > Status [\(url)]\nStatus = \(code ?? 0)\n"
        case .error(let url, let message):
            return "⚠️ Network > Error [\(url)]\nmessage: \(message ?? "")\n"
        case .data(let url, let message):
            return "⚠️ Network > Data [\(url)]\nmessage: \(message ?? "")\n"
        case .decode(let url, let message):
            return "⚠️ Network > Decode [\(url)]\nmessage: \(message ?? "")\n"
        case .url(message: let message):
            return "⚠️ Network > URL []\nmessage: \(message ?? "")\n"
        }
    }
}
