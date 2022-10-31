//
//  BindableTests.swift
//  WeatherTests
//
//  Created by Владимир on 04.10.2022.
//

import XCTest
@testable import Weather

class BindableTests: XCTestCase {
    
    var expectation: XCTestExpectation!

    typealias BindType = [String]?
    var object: Bindable<BindType>!
    
    let initialObjectValue: BindType = nil
    let acquiredObjectValue: BindType = ["a", "b", "c"]

    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        expectation = XCTestExpectation(description: "[ Run Unit-Test > Bindable ]")
        object = Bindable<BindType>(initialObjectValue)
    }

    override func tearDownWithError() throws {
        expectation = nil
        object = nil
        
        try super.tearDownWithError()
    }
}


// MARK: - Functional test case
//
extension BindableTests {
    
    func testBindable() throws {
        XCTAssertNotNil(object)
    }
    
    func testStateBeforeBinding() throws {
        XCTAssertEqual(object.value, initialObjectValue)
    }
    
    func testStateAfterBinding() throws {
        var state = initialObjectValue
        object.bind { valueObject in
            XCTAssertEqual(valueObject, state)
        }
        state = acquiredObjectValue
        object.value = acquiredObjectValue
    }
}
