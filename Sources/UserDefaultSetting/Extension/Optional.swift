//
//  Optional.swift
//  
//  
//  Created by keiji0 on 2021/09/19
//  
//

import Foundation

extension Optional: UserValueble
where Wrapped: UserValueble {
    public typealias StoreValue = Wrapped.StoreValue
    
    public static var defaultValue: Optional<Wrapped> {
        .none
    }
    
    public static func encode(_ value: Self) -> StoreValue? {
        if let wapped = value {
            return Wrapped.encode(wapped)
        }
        return nil
    }
    
    public static func decode(_ value: StoreValue) -> Self? {
        Wrapped.decode(value)
    }
}
