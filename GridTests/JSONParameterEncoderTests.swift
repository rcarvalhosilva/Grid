//
//  URLParameterEncoderTests.swift
//  GridTests
//
//  Created by Rodrigo Carvaho on 01/12/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import XCTest
@testable import Grid

class JSONParameterEncoderTests: XCTestCase {

    func testEncodeValidParameters() {
        guard let url = URL(string: "http://example.com") else {
            XCTFail("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        let params: Parameters = ["name": "Joao", "city": "campinas"]
        do {
            try JSONParameterEncoder.encode(urlRequest: &request, with: params)
            guard let requestBodyData = request.httpBody else {
                XCTFail("Request has no body data after encoding")
                return
            }
            let bodyJSON = try JSONSerialization.jsonObject(with: requestBodyData, options: JSONSerialization.ReadingOptions.mutableContainers)
            guard let bodyAsParameters = bodyJSON as? Parameters else {
                XCTFail("Body paramateres could not be parsed back to `Parameters`")
                return
            }

            XCTAssertTrue((bodyAsParameters["name"] as? String) == "Joao")
            XCTAssertTrue((bodyAsParameters["city"] as? String) == "campinas")
            XCTAssertTrue(bodyAsParameters.count == 2)
            let expectedContentType = "application/json"
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), expectedContentType)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testEncodeInvalidParameters() {
        struct AnyStruct {
            let variableOne: Int
            let variableTwo: String
        }
        guard let url = URL(string: "http://example.com") else {
            XCTFail("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        let anyStruct = AnyStruct(variableOne: 12345, variableTwo: "Test invalid")
        let params: Parameters = ["struct": anyStruct]
        do {
            try JSONParameterEncoder.encode(urlRequest: &request, with: params)
            XCTFail("Invalid JSON encoded as body")
        } catch {
            guard case NetworkError.invalidParameters = error else {
                XCTFail("Expected NetworkError.invalidParameters but got \(error.localizedDescription)")
                return
            }
        }
    }
}
