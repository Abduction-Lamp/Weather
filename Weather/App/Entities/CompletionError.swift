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
