//
//  URLParameterEncoderTests.swift
//  GridTests
//
//  Created by Rodrigo Carvaho on 01/12/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import XCTest
@testable import Grid

class URLParameterEncoderTests: XCTestCase {

    func testEncodeValidParameters() {
        guard let url = URL(string: "http://example.com") else {
            XCTFail("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        let params: Parameters = ["name": "Joao", "city": "campinas"]
        do {
            try URLParameterEncoder.encode(urlRequest: &request, with: params)
            guard let requestURL = request.url else { XCTFail("Request without url after encoding"); return }
            let components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
            let nameComponent = URLQueryItem(name: "name", value: "Joao")
            let cityComponent = URLQueryItem(name: "city", value: "campinas")
            XCTAssertTrue(components?.queryItems?.contains(nameComponent) ?? false, "ValidURL parameters incorreclty encoded")
            XCTAssertTrue(components?.queryItems?.contains(cityComponent) ?? false, "ValidURL parameters incorreclty encoded")
            let expectedContentType = "application/x-ww-form-urlencoded; charset=utf-8"
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), expectedContentType)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testEncodeEmptyParameters() {
        guard let url = URL(string: "http://example.com") else {
            XCTFail("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        let params: Parameters = [:]
        do {
            try URLParameterEncoder.encode(urlRequest: &request, with: params)
            XCTAssertEqual(request.url!.absoluteString, "http://example.com", "Empty parameters should not modify the URL")
            let expectedContentType = "application/x-ww-form-urlencoded; charset=utf-8"
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), expectedContentType, "Incorrect Content-Type header for URL parameters encoding")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testEncodeEmptyURLRequest() {
        guard let url = URL(string: "http://example.com") else {
            XCTFail("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.url = nil
        let params: Parameters = [:]
        do {
            try URLParameterEncoder.encode(urlRequest: &request, with: params)
            XCTFail("Request eith nil url should throw a missing url error")
        } catch {
            guard case NetworkError.missingURL = error else {
                XCTFail("Expected NetworkError.missingURL but got \(error)")
                return
            }
        }
    }

    func testEncodeMalformedURLWithParameters() {
        guard let url = URL(string: "http://example.com:-80") else {
            XCTFail("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        let params: Parameters = ["name": "Joao", "city": "campinas"]
        do {
            try URLParameterEncoder.encode(urlRequest: &request, with: params)
            XCTFail("Parameters encoded on malformed URL")
        } catch {
            guard case NetworkError.malformedURL = error else {
                XCTFail("Expected NetworkError.malformedURL but got \(error.localizedDescription)")
                return
            }
        }
    }
}
