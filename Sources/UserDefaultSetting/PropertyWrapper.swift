//
//  PropertyWrapper.swift
//
//  Created by keiji0 on 2021/02/19.
//

import Foundation
import Combine

/// UserDefaultsを使いやすくするためのプロパティラッパー
///
/// CodableをDataに変換する方式だとplistファイルビューワーから編集することが困難になる
/// Codableを使うタイプから型ごとにProtocolを指定する方式に変更
@propertyWrapper
public struct UserDefaultValue<Value: UserValueble> {
    private let key: String
    private let subject = PassthroughSubject<Value, Never>()
    private let defaultValue: Value
    private var store: UserDefaults { UserDefaults.standard }
    
    public init(key: String, defaultValue: Value = Value.defaultValue) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: Value {
        get {
            guard let value = store.value(forKey: key) as? Value.StoreValue else {
                return defaultValue
            }
            return Value.decode(value) ?? defaultValue
        }
        set {
            if let storeValue = Value.encode(newValue) {
                store.set(storeValue, forKey: key)
            } else {
                store.set(nil, forKey: key)
            }
            subject.send(newValue)
        }
    }
    
    public var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
}
