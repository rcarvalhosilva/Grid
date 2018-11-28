//
//  URLSessionDispatcher.swift
//  Grid
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import Swift

public class URLSessionDispatcher: NetworkDispatcher {
    private var task: URLSessionTask?
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func dispatch(request: Request, completion: @escaping NetworkDispatcherCompletion) {
        do {
            let request = try buildURLRequest(from: request)
            task = session.dataTask(with: request, completionHandler: completion)
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }

    public func cancel() {
        task?.cancel()
    }

    private func buildURLRequest(from request: Request) throws -> URLRequest {
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 10.0)
        urlRequest.httpMethod = request.httpMethod.rawValue
        try configureRequest(&urlRequest, acordingTo: request.task)
        return urlRequest
    }

    private func configureRequest(_ request: inout URLRequest, acordingTo task: HTTPTask) throws {
        switch task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case let .requestParameters(bodyParameters: bodyParameters, urlParameters: urlParameters):
            try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
        case let .requestParametersAndHeaders(bodyParameters: bodyParameters, urlParameters: urlParameters, additionalHeaders: additionHeaders):
            add(additionHeaders, to: &request)
            try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
        }
    }

    private func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        if let bodyParameters = bodyParameters {
            try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
        }
        if let urlParameters = urlParameters {
            try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
        }
    }

    private func add(_ additionalHeaders: HTTPHeaders?, to request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
