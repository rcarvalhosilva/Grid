//
//  URLSessionCodableDispatcher.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 27/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Foundation

/// A URLSessionCodableDispatcher is a `NetworkDispatcher` that uses URLSession to dispatch a request.
/// Made to be used with requests that expect a codable value as response
public class URLSessionCodableDispatcher: NetworkCodableDispatcher {
    private let dispatcher: URLSessionDispatcher

    /// See `URLSessionDispatcher.init(session:)`
    public init(session: URLSession = .shared) {
        dispatcher = URLSessionDispatcher(session: session)
    }

    /// Dispatches the given `Request` and calls the completion when the request is finished.
    ///
    /// If the request is canceled the completion **is not** called.
    ///
    /// - Parameters:
    ///   - request: A `Request`.
    ///   - completion: A `NetworkDispatcherResult<Value>` block. When called it will recieve as argument a `Result` object
    public func dispatch<Value>(request: Request, completion: @escaping NetworkDispatcherResult<Value>) where Value : Decodable {
        dispatcher.dispatch(request: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let value = try JSONDecoder().decode(Value.self, from: data)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }

    /// See `URLSessionDispatcher.cancel()`
    public func cancel() {
        dispatcher.cancel()
    }
}
