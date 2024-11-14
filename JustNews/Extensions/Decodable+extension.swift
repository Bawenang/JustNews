//
//  Decodable+extension.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

import Foundation

extension Decodable {
    static func decode(
        from data: Data,
        keyDecodeStrategy: JSONDecoder.KeyDecodingStrategy
    ) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodeStrategy
        return try decoder.decode(Self.self, from: data)
    }
    
    static func decode(
        from jsonObject: [AnyHashable: Any],
        keyDecodeStrategy: JSONDecoder.KeyDecodingStrategy
    ) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        let responseModel = try Self.decode(from: data, keyDecodeStrategy: keyDecodeStrategy)
        return responseModel
    }
    
    static func decode(
        from jsonString: String,
        keyDecodeStrategy: JSONDecoder.KeyDecodingStrategy
    ) throws -> Self {
        guard let data = jsonString.data(using: .utf8) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Cannot convert to Data"))
        }
        let responseModel = try Self.decode(from: data, keyDecodeStrategy: keyDecodeStrategy)
        return responseModel
    }
}

extension DecodingError {
    var detailedDescription: String {
        switch self {
        case let .keyNotFound(key, context):
            return "Could not find key \(key) in JSON: \(context.debugDescription)"
        case let .valueNotFound(type, context):
            return "Could not find type \(type) in JSON: \(context.debugDescription)"
        case let .typeMismatch(type, context):
            return "Type mismatch for type \(type) in JSON: \(context.debugDescription)"
        case let .dataCorrupted(context):
            return "Data found to be corrupted in JSON: \(context.debugDescription)"
        default:
            let nsError = self as NSError
            return "Error domain= \(nsError.domain), description= \(nsError.localizedDescription)"
        }
    }
}
