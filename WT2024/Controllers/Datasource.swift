//
//  Datasource.swift
//  WT2024
//
//  Created by Jorge Silva on 12/03/2024.
//

import Foundation

class Datasource {
    
    static let shared = Datasource()
    
    // MARK: - Properties -
    
    var articles: [Article] = []
    var articlesError: Bool = false
    
    // MARK: - Methods -
    
    func getArticles1_1(completion: @escaping() -> Void) {
        
        let url = Constants.mobileArticle1_1
        
        NSLog("getArticles1_1 :: \(url)")
        
        DispatchQueue.global().async {
            self.getArticle(url: url) { (result) in
                
                switch result {
                case let .success(response):
                    
                    self.articles = response
                    
                    NSLog("Datasource :: getArticles1_1 :: \(response.count)")
                    
                    self.articlesError = false
                case let .error(error):
                    
                    NSLog("Datasource :: getArticles1_1 :: error = \(error)")
                    self.articles = []
                    self.articlesError = true
                }
                completion()
            }
        }
    }
    
    func getArticles1_0(completion: @escaping() -> Void) {
        
        let url = Constants.mobileArticle1_0
        
        NSLog("getArticles1_0 :: \(url)")
        
        DispatchQueue.global().async {
            self.getArticle(url: url) { (result) in
                
                switch result {
                case let .success(response):
                    
                    self.articles = response
                    
                    NSLog("Datasource :: getArticles1_0 :: \(response.count)")
                    
                    self.articlesError = false
                case let .error(error):
                    
                    NSLog("Datasource :: getArticles1_0 :: error = \(error)")
                    self.articles = []
                    self.articlesError = true
                }
                completion()
            }
        }
    }
    
    func getArticles2_0(completion: @escaping () -> Void) {
        
        let url = Constants.mobileArticle2_0
        
        NSLog("getArticles2_0 :: \(url)")
        
        DispatchQueue.global().async {
            self.getArticle2_0(url: url) { (result) in
                
                switch result {
                case let .success(response):
                    
                    self.articles = response
                    
                    NSLog("Datasource :: getArticles2_0 :: \(response)")
                    
                    self.articlesError = false
                case let .error(error):
                    
                    NSLog("Datasource :: getArticles2_0 :: error = \(error)")
                    self.articles = []
                    self.articlesError = true
                }
                completion()
            }
        }
    }
    
    private func getArticle(url: String, completionHandler: @escaping (Result<[Article]>) -> Void) {
        
        NetworkRequest.shared.get(url: url) { (result) in
            
            switch result {
            case let .success(data):
                
                do {
                    let dataSet = try JSONDecoder().decode(Articles.self, from: data)

                    if !dataSet.items.isEmpty {
                        NSLog("Datasource :: getArticles :: successful got articles")
                        completionHandler(.success(dataSet.items))
                    } else {
                        NSLog("Datasource :: getArticles :: Data set empty")
                        completionHandler(.error("Data set empty"))
                    }
                } catch let jsonErr {
                    completionHandler(.error(jsonErr.localizedDescription))
                }
                
            case let .error(error, _):
                completionHandler(.error(error))
            }
        }
        
    }
    
    private func getArticle2_0(url: String, completionHandler: @escaping (Result<[Article]>) -> Void) {
        
        DispatchQueue.global().async {
            
            NetworkRequest.shared.get(url: url) { (result) in
                
                switch result {
                case let .success(data):
                    
                    do {
                        let dataSet = try JSONDecoder().decode(ArticleElem.self, from: data)
                        
                        NSLog("Datasource :: getArticles 2.0 :: successful got articles")
                        completionHandler(.success(dataSet))
                        
                    } catch let jsonErr {
                        NSLog("Datasource :: getArticles 2.0 :: Data set empty")
                        completionHandler(.error(jsonErr.localizedDescription))
                    }
                    
                case let .error(error, _):
                    completionHandler(.error(error))
                }
            }
            
        }
        
    }
}
