//
//  UUID.swift
//  
//  
//  Created by keiji0 on 2021/09/19
//  
//

import Foundation

/// UUIDはStringとして保存するのが保守しやすい
extension UUID: UserValueble {

    public typealias StoreValue = String

    public static let defaultValue = UUID(
        uuidString: "00000000-0000-0000-0000-000000000000"
    )!

    public static func encode(_ value: UUID) -> String? {
        value.uuidString
    }
    
    public static func decode(_ value: String) -> UUID? {
        Self(uuidString: value)
    }
}
