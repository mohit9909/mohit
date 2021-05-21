//
//  NetworkManager.swift
//  SWorks
//
//  Created by Mohit Raina  on 20/05/21.
//

import Foundation


class NetworkManager {
    
    var urlSession = URLSession.shared
    
    static let shared = NetworkManager()
    private init() {}
    
    func getdata<T : Codable>(url : UrlTypes , completion : @escaping (Result<T,NetworkErrors>)->()) {
        
        guard let  url = URL(string : url.rawValue) else {
            completion(.failure(NetworkErrors.urlError))
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                
                completion(.failure(NetworkErrors.urlError))
                return
            }
            
            guard let data = data , let _ = response else {
                completion(.failure(NetworkErrors.serverError))

                return
            }
            
            do {
                let serialisedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(serialisedData))
                
            } catch {
                completion(.failure(NetworkErrors.serializeError))
                return
            }
            
      
        }.resume()
        
    }
    
}




