//
//  Array.swift
//  
//  
//  Created by keiji0 on 2021/09/19
//  
//

import Foundation

extension Array: UserValueble
where Element: UserValueble
{
    public typealias StoreValue = [Element.StoreValue]
    
    public static var defaultValue: Array<Element> {
        Self()
    }
    
    public static func encode(_ values: Array<Element>) -> StoreValue? {
        var res = StoreValue()
        for value in values {
            guard let v = Element.encode(value) else {
                return nil
            }
            res.append(v)
        }
        return res
    }

    public static func decode(_ value: StoreValue) -> Array<Element>? {
        var res = Self()
        for elem in value {
            guard let v = Element.decode(elem) else {
                return nil
            }
            res.append(v)
        }
        return res
    }
}
