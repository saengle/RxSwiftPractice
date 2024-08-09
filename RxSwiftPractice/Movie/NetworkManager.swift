//
//  NetworkManager.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/9/24.
//

import Foundation

import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusCodeError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func callBoxOffice(query: String) -> Observable<Movie> {
        
        let url = APISecure.url + APISecure.apiKey + "&targetDt=" + query
        
        let result = Observable<Movie>.create { observer in
            
            guard let url = URL(string: url) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                    
                if let error = error {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusCodeError)
                    return
                }
                
                if let data = data,
                   let appData = try? JSONDecoder().decode(Movie.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted()
                } else {
                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            return Disposables.create()
     }
            
        return result
    }
}
