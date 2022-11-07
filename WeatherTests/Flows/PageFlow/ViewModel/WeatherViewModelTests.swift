//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Владимир on 02.11.2022.
//

import XCTest
@testable import Weather


class WeatherViewModelTests: XCTestCase {

    let timeout = TimeInterval(0.5)
    var expectation: XCTestExpectation!
    
    
    var viewModel: WeatherViewModel!
    
    var city: CityData!
    var network: Network!
    var settings: Settings!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        expectation = XCTestExpectation(description: "[ WeatherViewModel ]")
        
        network = Network(session: MockURLSession_Network())
        city = MockCityData.init().cities.first
        settings = Settings()
        
        viewModel = WeatherViewModel(city: city, network: network, settings: settings)
    }

    override func tearDownWithError() throws {
        expectation = nil
        
        viewModel = nil
        city = nil
        network = nil
        settings = nil
        
        try super.tearDownWithError()
    }
}


extension WeatherViewModelTests {
    
    func testInitWeatherViewModel() throws {
        XCTAssertNotNil(network)
        XCTAssertNotNil(city)
        XCTAssertNotNil(settings)
        XCTAssertNotNil(viewModel)
    }
    
    
//    func testFetch() throws {
//        viewModel.fetch()
//        
//        XCTAssertEqual(viewModel.city, city)
//        XCTAssertEqual(viewModel.statusDay.value, TimeOfDay.morning)
//        XCTAssertEqual(viewModel.getNumberOfSections(), 5)
//        XCTAssertEqual(viewModel.getNumberOfAirComponents(), 8)
//        
//        
//        let model = MockWeatherModels.init()
//        
//        // makeWeatherCityHeaderModel()
//        let header = viewModel.makeWeatherCityHeaderModel()
//        XCTAssertEqual(header.city, model.header.city)
//        XCTAssertEqual(header.temperature, model.header.temperature)
//        XCTAssertEqual(header.description, model.header.description)
//        
//        
//        // makeWeatherHourlyModel()
//        let hourly = viewModel.makeWeatherHourlyModel()
//        XCTAssertEqual(hourly.count, model.hourly.count)
//        
//        for index in 0 ..< hourly.count {
//            XCTAssertEqual(hourly[index].time, model.hourly[index].time)
//            XCTAssertEqual(hourly[index].icon, model.hourly[index].icon)
//            XCTAssertEqual(hourly[index].temperature, model.hourly[index].temperature)
//        }
//        
//        
//        // makeWeatherDailyModel
//        let daily = viewModel.makeWeatherDailyModel()
//        XCTAssertEqual(daily.count, model.daily.count)
//        
//        for index in 0 ..< daily.count {
//            XCTAssertEqual(daily[index].day, model.daily[index].day)
//            XCTAssertEqual(daily[index].icon, model.daily[index].icon)
//            XCTAssertEqual(daily[index].temperature, model.daily[index].temperature)
//        }
//    }
}
