//
//  SearchCityCellViewModel.swift
//  Weather
//
//  Created by Владимир on 26.04.2022.
//

import Foundation

protocol SearchCityCellViewModelProtocol: AnyObject {
    var data: SearchCityCellModel { get }
    var isSaved: Bool { get set }
}


final class SearchCityCellViewModel: SearchCityCellViewModelProtocol {

    var data: SearchCityCellModel
    var isSaved = false
    
    init(city: SearchCityCellModel) {
        data = city
    }
}
