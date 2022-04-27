//
//  SearchCityCellViewModel.swift
//  Weather
//
//  Created by Владимир on 26.04.2022.
//

import Foundation

protocol SearchCityCellViewModelProtocol: AnyObject {
    var data: SearchCityCellData { get }
}


final class SearchCityCellViewModel: SearchCityCellViewModelProtocol {

    var data: SearchCityCellData
    
    init(city: SearchCityCellData) {
        data = city
    }
    
    deinit {
        print("♻️\tDeinit SettingsCityCellViewModel")
    }
}
