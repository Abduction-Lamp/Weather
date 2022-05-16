//
//  FakeURL.swift
//  WeatherTests
//
//  Created by Владимир on 13.05.2022.
//

import Foundation
@testable import Weather

protocol FakeURLProtocol {
    var absoluteString: [String] { get }
}

struct FakeURL {

    static func makeUrl(request: BaseRequest) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path  = request.path
        urlComponents.queryItems = request.params
        return urlComponents.url
    }
    
    var excitesData = URLsExcitesData()
    var excitesResponseError = URLsExcitesResponseError()
    var excitesError = URLsExcitesError()
    var excitesDataDecoderError = URLsExcitesDataDecoderError()
    var excitesNilData = URLsExcitesNilData()
}
