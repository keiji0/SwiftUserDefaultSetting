//
//  Primitive.swift
//  
//  
//  Created by keiji0 on 2021/09/19
//  
//

import Foundation

public protocol UserPrimitiveValueble: UserValueble {
    init()
}

extension UserPrimitiveValueble {
    public static var defaultValue: Self {
        Self()
    }
    
    public static func encode(_ value: Self) -> Self? {
        value
    }
    
    public static func decode(_ value: Self) -> Self? {
        value
    }
}

extension Int: UserPrimitiveValueble {}
extension String: UserPrimitiveValueble {}
extension Float: UserPrimitiveValueble {}
extension Double: UserPrimitiveValueble {}
extension Bool: UserPrimitiveValueble {}
extension Data: UserPrimitiveValueble {}
