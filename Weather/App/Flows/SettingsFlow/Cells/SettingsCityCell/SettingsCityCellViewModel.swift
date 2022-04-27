//
//  SettingsCityCellViewModel.swift
//  Weather
//
//  Created by Владимир on 15.04.2022.
//

import Foundation

protocol SettingsCityCellViewModelProtocol: AnyObject {
    var data: SettingsCityCellModel { get }
}


final class SettingsCityCellViewModel: SettingsCityCellViewModelProtocol {

    var data: SettingsCityCellModel
    
    init(city: SettingsCityCellModel) {
        data = city
    }
    
    deinit {
        print("♻️\tDeinit SettingsCityCellViewModel")
    }
}
