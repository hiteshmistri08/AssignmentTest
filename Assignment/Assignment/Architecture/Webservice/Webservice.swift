//
//  Webservice.swift
//  Assignment
//
//  Created by Hitesh on 15/02/21.
//

import Foundation

let baseURL = "https://reqres.in/api/"

enum ServerEndPoint : String {
    case users = "users"
    
    func get() -> String {
        return baseURL + self.rawValue
    }
}

// MARK: - Helper functions for creating encoders and decoders
extension JSONDecoder {
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
}

extension JSONEncoder {
    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}

struct Webservice {
    private init() {}
    static func get(url:URL,completion:@escaping(Data?, URLResponse?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
        dataTask.resume()
    }
}
