//
//  URLSessionCodableDispatcher.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 27/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Foundation

public class URLSessionCodableDispatcher: NetworkCodableDispatcher {
    private let dispatcher: URLSessionDispatcher

    public init(session: URLSession = .shared) {
        dispatcher = URLSessionDispatcher(session: session)
    }

    public func dispatch<Value>(request: Request, completion: @escaping (Result<Value>) -> Void) where Value : Decodable {
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

    public func cancel() {
        dispatcher.cancel()
    }
}
