//
//  NetworkCodableDispatcher.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 27/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Foundation

public typealias NetworkDispatcherResult<Value> = (Result<Value>) -> Void

/// A NetworkCodableDispatcher is an object responsable for making a resquest be executed.
/// Made to be used with requests that expect a codable value as the response.
public protocol NetworkCodableDispatcher: class {
    func dispatch<Value>(request: Request, completion: @escaping NetworkDispatcherResult<Value>) where Value: Decodable
    func cancel()
}
