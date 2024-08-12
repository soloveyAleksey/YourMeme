//
//  NetworkService.swift
//  YourMeme

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func downloadList(from url: String, completion: @escaping (Result<ListModel, NetworkError>) -> ())
    func downloadImage(from url: String, completion: @escaping (Result<ImageModel, NetworkError>) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session = URLSession.shared
    private let headers = [
        "x-rapidapi-host": "ronreiter-meme-generator.p.rapidapi.com",
        "x-rapidapi-key": "593d858ec7msh44787ba9e3aa6aep106925jsne707a7a50200"
    ]
    
    func downloadList(from url: String, completion: @escaping (Result<ListModel, NetworkError>) -> ()) {
        guard let url = URL(string: url) else { return catchFailure(with: .invalidURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        session.dataTask(with: request) { data, _, error in
            if error != nil {
                catchFailure(with: .receivedError)
                return
            }
            
            guard let data = data else { return catchFailure(with: .noData) }
            
            do {
                let listData = try JSONSerialization.jsonObject(with: data, options: []) as? [String]
                DispatchQueue.main.async {
                    let list = ListModel(listData: listData ?? [])
                    completion(.success(list))
                }
            } catch {
                catchFailure(with: .decodingError)
            }
        }
        .resume()
        
        func catchFailure(with error: NetworkError) {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(from url: String, completion: @escaping (Result<ImageModel, NetworkError>) -> ()) {
        guard let url = URL(string: url) else { return catchFailure(with: .invalidURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        session.dataTask(with: request) { data, _, error in
            if error != nil {
                catchFailure(with: .receivedError)
                return
            }
            
            guard let data = data else { return  catchFailure(with: .noData) }
            
            DispatchQueue.main.async {
                let image = ImageModel(imageData: data)
                completion(.success(image))
            }
        }
        .resume()
        
        func catchFailure(with error: NetworkError) {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}
