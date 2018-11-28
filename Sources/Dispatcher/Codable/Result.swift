//
//  Result.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 27/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Swift.Error)

    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }

    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}
