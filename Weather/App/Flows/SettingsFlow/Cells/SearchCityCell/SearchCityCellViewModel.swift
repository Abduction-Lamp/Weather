//
//  SearchCityCellViewModel.swift
//  Weather
//
//  Created by Владимир on 26.04.2022.
//

import Foundation

protocol SearchCityCellViewModelProtocol: AnyObject {
    var data: SearchCityCellModel { get }
}


final class SearchCityCellViewModel: SearchCityCellViewModelProtocol {

    var data: SearchCityCellModel
    
    init(city: SearchCityCellModel) {
        data = city
    }
    
    deinit {
        print("♻️\tDeinit CityCellViewModel")
    }
}
