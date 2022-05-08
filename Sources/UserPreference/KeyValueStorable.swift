//
//  KeyValueStorable.swift
//  
//  
//  Created by keiji0 on 2022/05/08
//  
//

import Foundation

/// KeyValueストアプロトコル
/// UserDefaultsとNSUbiquitousKeyValueStoreを差異なく扱えるようにするためでもある
public protocol KeyValueStorable {
    func get(forKey: String) -> Any?
    func set(_ value: Any?, forKey: String)
    func remove(forKey: String)
    var keys: [String] { get }
}

extension UserDefaults : KeyValueStorable {
    public func get(forKey key: String) -> Any? {
        object(forKey: key)
    }
    
    public func remove(forKey key: String) {
        removeObject(forKey: key)
    }
    
    public var keys: [String] {
        .init(dictionaryRepresentation().keys)
    }
}

extension NSUbiquitousKeyValueStore : KeyValueStorable {
    public func get(forKey key: String) -> Any? {
        object(forKey: key)
    }
    
    public func remove(forKey key: String) {
        removeObject(forKey: key)
    }
    
    public var keys: [String] {
        .init(dictionaryRepresentation.keys)
    }
}
