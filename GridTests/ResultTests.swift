//
//  ResultTests.swift
//  GridTests
//
//  Created by Rodrigo Carvaho on 04/12/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import XCTest
@testable import Grid

class ResultTests: XCTestCase {
    func testSuccess() {
        let value = "String Value"
        let successResult = Result.success(value)

        XCTAssertEqual(value, successResult.value, "A success Result should return the correct value")
        XCTAssertNil(successResult.error, "A success Result should not return an error")
        XCTAssertTrue(successResult.isSuccess, "A success Result should return `isSuccess` true")
    }

    func testError() {
        let error = NetworkError.invalidParameters
        let successResult = Result<String>.failure(error)

        XCTAssertEqual(error, successResult.error as? NetworkError, "A failure Result should return the correct error")
        XCTAssertNil(successResult.value, "A failure Result should not return an value")
        XCTAssertFalse(successResult.isSuccess, "A failure Result should return `isSuccess` false")
    }
}
