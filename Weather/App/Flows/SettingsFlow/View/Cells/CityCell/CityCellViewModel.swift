//
//  CityCellViewModel.swift
//  Weather
//
//  Created by Владимир on 15.04.2022.
//

import Foundation

protocol CityCellViewModelProtocol: AnyObject {
    var data: CityCellModel { get }
}


final class CityCellViewModel: CityCellViewModelProtocol {
    var data: CityCellModel
    
    init(city: CityCellModel) {
        data = city
    }
}
