//
//  WeatherListViewModeltest.swift
//  WeatherForecastUITests
//
//  Created by Ferrakkem Bhuiyan on 2021-03-05.
//

import XCTest


class WeatherListViewModeltest: XCTestCase {

    var mockOuput: MockDetailsWeatherDelegate?
    var expectedOutput: Bool = false
    override func setUp() {
        mockOuput = MockDetailsWeatherDelegate()
    }
    
    func test_setupIcon(){
        let  output = mockOuput?.isSetupCityName
        expectedOutput = true
        XCTAssertEqual(expectedOutput, output, "The isPasswordValid() should have returned true for a password matched but it has returned FALSE")
    }

}
