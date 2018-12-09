//
//  URLParameterEncoder.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

/// A ParameterEncoder that encodes parameters as URL query items.
public struct URLParameterEncoder: ParameterEncoder {

    /// Encode the `URLRequest` with the given `Parameters` as URL query items.
    ///
    /// Note: Defines the requests **Content-Type** as *application/x-ww-form-urlencoded; charset=utf-8*
    ///
    /// - Parameters:
    ///   - urlRequest: A `URLRequest` to be encoded.
    ///   - parameters: The `Parameters` to encode on the request.
    /// - Throws: If the request passed in as argument does not have a URL or it has a malformed URL it **will** throw a `NetworkError`
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        let components = try createComponentsFrom(url, with: parameters)
        urlRequest.url = components.url
        insertContentTypeIfNeeded(&urlRequest)
    }

    private static func createComponentsFrom(_ url: URL, with parameters: Parameters) throws -> URLComponents {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw NetworkError.malformedURL }
        guard parameters.isEmpty == false else { return urlComponents }

        urlComponents.queryItems = []
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        return urlComponents
    }

    private static func insertContentTypeIfNeeded(_ urlRequest: inout URLRequest) {
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-ww-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
