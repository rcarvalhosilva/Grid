//
//  HTTP.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

public typealias HTTPHeaders = [String:String]


/// The possible HTTP methods do be used on a request
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

/// The poossible HTTP tasksthat can be carried on a request
///
/// - request: A simple request with no parameters
/// - requestParameters: A request with parameters
/// - requestParametersAndHeaders: A request with paramaeters and additional headers to be added
public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
