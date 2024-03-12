//
//  NetworkRequest.swift
//  WT2024
//
//  Created by Jorge Silva on 12/03/2024.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {
        
    }
    
    func get(url: String, encodeUrl: Bool = true, completion: @escaping (NetworkResult<Data>) -> Void) {
        makeRequest(url: url, httpMethod: .GET, body: nil, encodeUrl: encodeUrl) { result in
            switch result {
            case let .success(data):
                
                // it's safe to force unwrapping
                // in makeRequest method, if GET requests return nil data, an error is returned
                completion(.success(data!))
                
            case let .error(error, response):
                completion(.error(error, response))
            }
        }
    }
    
    func post(url: String, headers: [String: String] = [:], body: Data, encodeUrl: Bool = true, completion: @escaping (NetworkResult<Data?>) -> Void) {
        makeRequest(url: url, httpMethod: .POST, body: body, encodeUrl: encodeUrl, completion: completion)
    }
    
    private func makeRequest(url: String, httpMethod: HTTPMethod, body: Data?, encodeUrl: Bool, completion: @escaping (NetworkResult<Data?>) -> Void) {
        let finalUrl: URL?
        
        if encodeUrl {
            guard let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                completion(.error("Error encoding URL", (nil, nil)))
                return
            }
            finalUrl = URL(string: urlEncoded)
            
        } else {
            finalUrl = URL(string: url)
        }
        
        guard let url = finalUrl else {
            completion(.error("Cannot create url", (nil, nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        if let body = body {
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            
            // If there's an error
            if let error = error {
                NSLog("NETWORK <-- [\(httpMethod.rawValue)] \(url)\n<-- ERROR: \(error.localizedDescription)")
                
                completion(.error(error.localizedDescription, (data, response)))
                return
            }
            
            if response == nil {
                let message = "Response nil"
                NSLog("NETWORK <-- [\(httpMethod.rawValue)] \(url)\n<-- ERROR: \(message)")
                
                completion(.error(message, (data, response)))
                return
            }
            
            // Check response status is 200 OK
            if let res = response as? HTTPURLResponse {
                if res.statusCode < 200 || res.statusCode > 299 {
                    completion(.error(String(res.statusCode), (data, response)))
                    return
                }
            }
            
            if httpMethod == .GET && data == nil {
                completion(.error("Data nil", (nil, response)))
                return
            }
            
            completion(.success((data)))
            
        }
        
        task.resume()
    }
}
