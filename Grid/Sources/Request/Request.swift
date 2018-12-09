//
//  RequestType.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

/// Defines what a Request needs to have
public protocol Request {
    /// The base URL of the request
    var baseURL: URL { get }

    /// The path to be apended to the base URL
    var path: String { get }

    /// The HTTP method to be used on the request. See `HTTPMethod` for more details
    var httpMethod: HTTPMethod { get }

    /// Defines the which HTTP task will be exequeted with the request. See `HTTPTask` for more details
    var task: HTTPTask { get }

    /// The headers to be sent in the request
    var headers: HTTPHeaders? { get }
}
