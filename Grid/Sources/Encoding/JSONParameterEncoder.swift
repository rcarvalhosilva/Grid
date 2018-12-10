//
//  JSONParameterEncoder.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

/// A ParameterEncoder that encodes parameters as a JSON and add them to the HTTP body of the request.
public struct JSONParameterEncoder: ParameterEncoder {
    /// Encode the `URLRequest` with the given `Parameters` as HTTP body.
    ///
    /// Note: Defines the requests **Content-Type** as *application/json*
    ///
    /// - Parameters:
    ///   - urlRequest: A `URLRequest` to be encoded.
    ///   - parameters: The `Parameters` to encode on the request.
    /// - Throws: If the parameters passed in as arguments does not have form a valid JSON object it **will** throw a `NetworkError`
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard JSONSerialization.isValidJSONObject(parameters) else {
            throw NetworkError.invalidParameters
        }
        addJsonData(from: parameters, to: &urlRequest)
        insertContentTypeIfNeeded(&urlRequest)
    }

    private static func addJsonData(from parameters: Parameters, to urlRequest: inout URLRequest) {
        let jsonAsData = try? JSONSerialization.data(withJSONObject: parameters)
        urlRequest.httpBody = jsonAsData
    }

    private static func insertContentTypeIfNeeded(_ urlRequest: inout URLRequest) {
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
