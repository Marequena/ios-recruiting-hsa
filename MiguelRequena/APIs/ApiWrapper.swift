//
//  ApiWrapper.swift
//  scan and go
//
//  Created by Samuel on 04-05-18.
//  Copyright © 2018 Samuel Garcia. All rights reserved.
//

import Foundation

public struct ApiWrapper<T: Codable>: Codable {
    let internalCode: String?
    let message: String?
    let result: T?
}

extension ApiWrapper {
    static func decode(_ data: Data) throws -> ApiWrapper {
        let decoder = JSONDecoder()
        let responseData = String(data: data, encoding: String.Encoding.utf8)
        return try decoder.decode(self, from: data)
    }
}
