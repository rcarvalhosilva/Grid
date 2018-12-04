//
//  URLParameterEncoder.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw EncodingError.missingURL }
        let components = try createComponentsFrom(url, with: parameters)
        urlRequest.url = components.url
        insertContentTypeIfNeeded(&urlRequest)
    }

    private static func createComponentsFrom(_ url: URL, with parameters: Parameters) throws -> URLComponents {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw EncodingError.malformedURL }
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
