//
//  CompletionError.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

enum CompletionError: Error, Equatable {
    case decode    (source: String, message: String)
    case encode    (source: String, message: String)
    case empty     (source: String, message: String)
    case undefined (source: String, message: String)
}

extension CompletionError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .decode    (let source, let message),
             .encode    (let source, let message),
             .empty     (let source, let message),
             .undefined (let source, let message):
            return "⚠️ Completion Error > (\(source)): \(message)"
        }
    }
}
