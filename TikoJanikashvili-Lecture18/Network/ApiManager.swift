//
//  ApiManager.swift
//  TikoJanikashvili-Lecture18
//
//  Created by Tiko Janikashvili on 07.12.22.
//

import Foundation

enum EndPoint: String {
    case postUrl = "https://jsonplaceholder.typicode.com/posts"
}

class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
    
    func fetchPost(completion: @escaping([Post]) -> Void) {
        
        guard let url = URL(string: EndPoint.postUrl.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let decoder = try JSONDecoder().decode([Post].self, from: data)
                completion(decoder)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchComment(with postId: Int, completion: @escaping([Comment]) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoder = try JSONDecoder().decode([Comment].self, from: data)
                completion(decoder)
            } catch {
                print(error)
            }
        }.resume()
    }
}

