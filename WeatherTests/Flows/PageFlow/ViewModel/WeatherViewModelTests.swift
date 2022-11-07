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
    
    
    func testFetchAndMakesModels() throws {
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.city, city)
        XCTAssertEqual(viewModel.statusDay.value, TimeOfDay.morning)
        XCTAssertEqual(viewModel.getNumberOfSections(), 5)
        XCTAssertEqual(viewModel.getNumberOfAirComponents(), 8)
        
        let model = MockWeatherModels.init()

        // MARK: makeWeatherCityHeaderModel()
        let cityHederModel = viewModel.makeWeatherCityHeaderModel()
        XCTAssertEqual(cityHederModel.city, model.header.city)
        XCTAssertEqual(cityHederModel.temperature, model.header.temperature)
        XCTAssertEqual(cityHederModel.description, model.header.description)
        
        // MARK: makeWeatherHourlyModel()
        let hourlyMode = viewModel.makeWeatherHourlyModel()
        XCTAssertEqual(hourlyMode.count, model.hourly.count)
        for index in 0 ..< hourlyMode.count {
            XCTAssertEqual(hourlyMode[index].time, model.hourly[index].time)
            XCTAssertEqual(hourlyMode[index].icon, model.hourly[index].icon)
            XCTAssertEqual(hourlyMode[index].temperature, model.hourly[index].temperature)
        }
        
        // MARK: makeWeatherDailyModel()
        let dailyModel = viewModel.makeWeatherDailyModel()
        XCTAssertEqual(dailyModel.count, model.daily.count)
        for index in 0 ..< dailyModel.count {
            if index == 0 {
                XCTAssertEqual(dailyModel[index].day, "Сегодня")
            } else {
                XCTAssertEqual(dailyModel[index].day, model.daily[index].day)
            }
            XCTAssertEqual(dailyModel[index].icon, model.daily[index].icon)
            XCTAssertEqual(dailyModel[index].temperature, model.daily[index].temperature)
        }
        
        // MARK: makeWeatherWindModel()
        let windModel = viewModel.makeWeatherWindModel()
        XCTAssertEqual(windModel.measurement, model.wind.measurement)
        XCTAssertEqual(windModel.units, model.wind.units)
        XCTAssertEqual(windModel.degrees, model.wind.degrees)
        XCTAssertEqual(windModel.info, model.wind.info)

        
        // MARK: makeWeatherPressureAndHumidityModel()
        let pressureAndHumidityModel = viewModel.makeWeatherPressureAndHumidityModel()
        XCTAssertEqual(pressureAndHumidityModel.measurement, model.pressure.measurement)
        XCTAssertEqual(pressureAndHumidityModel.units, model.pressure.units)
        XCTAssertEqual(pressureAndHumidityModel.pressure, model.pressure.pressure)
        XCTAssertEqual(pressureAndHumidityModel.humidity, model.pressure.humidity)
        XCTAssertEqual(pressureAndHumidityModel.dewPoint, model.pressure.dewPoint)
        
        
        // MARK: makeWeatherAirPollutionModel()
        let airPollutionModel = viewModel.makeWeatherAirPollutionModel()
        XCTAssertEqual(airPollutionModel?.aqi, model.air.aqi)
        XCTAssertEqual(airPollutionModel?.airComponents.count, model.air.airComponents.count)
        for index in 0 ..< model.air.airComponents.count {
            XCTAssertEqual(airPollutionModel?.airComponents[index].description, model.air.airComponents[index].description)
            XCTAssertEqual(airPollutionModel?.airComponents[index].value, model.air.airComponents[index].value)
            XCTAssertEqual(airPollutionModel?.airComponents[index].designation, model.air.airComponents[index].designation)
        }
    }
}
