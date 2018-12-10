//
//  Result.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 27/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Foundation

/// Represents the results of a request.
///
/// - success: When a success it carries a associated value that represents the response.
/// - failure: When a failure it carries a associated Swift.Error.
public enum Result<Value> {
    case success(Value)
    case failure(Swift.Error)

    /// The value corresponding to the result if success or nil if failure.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    /// The error corresponding to the failure or nil if success.
    public var error: Swift.Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }

    /// A Boolean indicating if self is a success.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
