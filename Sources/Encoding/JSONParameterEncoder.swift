//
//  JSONParameterEncoder.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard JSONSerialization.isValidJSONObject(parameters) else {
            throw NetworkError.invalidParameters
        }
        do {
            try addJsonData(from: parameters, to: &urlRequest)
            insertContentTypeIfNeeded(&urlRequest)
        } catch {
            throw NetworkError.encondingFailed
        }
    }

    private static func addJsonData(from parameters: Parameters, to urlRequest: inout URLRequest) throws {
        let jsonAsData = try JSONSerialization.data(withJSONObject: parameters)
        urlRequest.httpBody = jsonAsData
    }

    private static func insertContentTypeIfNeeded(_ urlRequest: inout URLRequest) {
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
