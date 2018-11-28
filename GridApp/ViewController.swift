//
//  ViewController.swift
//  GridApp
//
//  Created by Rodrigo Carvaho on 26/11/18.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import UIKit
import Grid

protocol GitHubRequest: Request {}
extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var headers: HTTPHeaders? {
        return ["Accept": "application/vnd.github.v3+json"]
    }
}


struct GithubSearchRequest: GitHubRequest {
    let query: String

    var urlParameters: Parameters {
        return ["q": query]
    }

    var path: String {
        return "/search/repositories"
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        return.requestParametersAndHeaders(bodyParameters: nil, urlParameters: urlParameters, additionalHeaders: headers)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let request = GithubSearchRequest(query: "bahia")
        URLSessionDispatcher().dispatch(request: request) { (data, response, error) in
            print("ERRO \(error)")
            print("JSON \(try? JSONSerialization.jsonObject(with: data!))")
        }
    }

}

