//
//  ParameterEncoding.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum EncodingError: String, Error, Equatable {
    case parametersNil = "Parameters were nil."
    case invalidParameters = "Parameters don't specify a valid JSON."
    case encondingFailed = "Parameters enconding failed."
    case missingURL = "URL is nil."
    case malformedURL = "URL is malformed."

    public var localizedDescription: String {
        return rawValue
    }
}
