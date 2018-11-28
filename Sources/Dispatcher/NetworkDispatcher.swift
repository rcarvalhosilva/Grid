//
//  NetworkDispatcher.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Foundation

public typealias NetworkDispatcherCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

public protocol NetworkDispatcher: class {
    func dispatch(request: Request, completion: @escaping NetworkDispatcherCompletion)
    func cancel()
}
