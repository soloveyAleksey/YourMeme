//
//  NetworkService_2.swift
//  YourMeme

import Foundation

protocol NetworkServiceProtocol_2: AnyObject {
    func downloadList(from url: String) async throws -> ListModel
    func downloadImage(from url: String) async throws -> ImageModel
}

final class NetworkService_2: NetworkServiceProtocol_2 {
    
    private let session = URLSession.shared
    private let headers = [
        "x-rapidapi-host": "ronreiter-meme-generator.p.rapidapi.com",
        "x-rapidapi-key": "593d858ec7msh44787ba9e3aa6aep106925jsne707a7a50200"
    ]
    
    func downloadList(from url: String) async throws -> ListModel {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let result = try await session.data(for: request)
        
        guard let listData = try JSONSerialization.jsonObject(with: result.0, options: []) as? [String] else {
            throw NetworkError.receivedError
        }
        let list = ListModel(listData: listData)
        
        return list
    }
    
    func downloadImage(from url: String) async throws -> ImageModel {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let result = try await session.data(for: request)
        
        return ImageModel(imageData: result.0)
    }
}
