//
//  NetworkError.swift
//  YourMeme

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case receivedError
    case noData
    case decodingError
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid url request"
        case .receivedError:
            return "An error was received during a network request"
        case .noData:
            return "Can't fetch data"
        case .decodingError:
            return "Can't decoding received data"
        }
    }
}
