//
//  SettingsCityCellViewModel.swift
//  Weather
//
//  Created by Владимир on 15.04.2022.
//

import Foundation

protocol SettingsCityCellViewModelProtocol: AnyObject {
    var data: SettingsCityCellData { get }
}


final class SettingsCityCellViewModel: SettingsCityCellViewModelProtocol {

    var data: SettingsCityCellData
    
    init(city: SettingsCityCellData) {
        data = city
    }
    
    deinit {
        print("♻️\tDeinit SettingsCityCellViewModel")
    }
}
