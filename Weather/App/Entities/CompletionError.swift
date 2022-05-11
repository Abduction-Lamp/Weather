//
//  CompletionError.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

enum CompletionError: Error {
    case decode(message: String)
    case empty(message: String)
}

extension CompletionError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decode(let message):
            return "⚠️\tCompletionError > \(message)"
        case .empty(let message):
            return "⚠️\tCompletionError > \(message)"
        }
    }
}
