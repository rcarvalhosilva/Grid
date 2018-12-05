//
//  NetworkErrorTests.swift
//  GridTests
//
//  Created by Rodrigo Carvaho on 04/12/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import XCTest
@testable import Grid

class NetworkErrorTests: XCTestCase {

    func testLocalizedDescription() {
        let error = NetworkError.invalidParameters
        XCTAssertEqual(error.localizedDescription, error.rawValue, "The localized description of the error should be the raw value")
    }
}
