//
//  Dictionary.swift
//  
//  
//  Created by keiji0 on 2021/09/20
//  
//

import Foundation

extension Dictionary: UserValueble
where Key == String,
      Value: UserValueble
{
    public typealias StoreValue = [Key: Value.StoreValue]
    
    public static var defaultValue: Self {
        Self()
    }
    
    public static func encode(_ dictionary: Self) -> StoreValue? {
        var res = StoreValue()
        for (key, value) in dictionary {
            res[key] = Value.encode(value)
        }
        return res
    }

    public static func decode(_ storeValue: StoreValue) -> Self? {
        var res = Self()
        for (key, value) in storeValue {
            guard let v = Value.decode(value) else {
                return nil
            }
            res[key] = v
        }
        return res
    }
}
