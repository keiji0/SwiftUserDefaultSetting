//
//  UserDefaultValue.swift
//
//  Created by keiji0 on 2021/02/19.
//

import Foundation
import Combine

/// UserDefaultsを使いやすくするためのプロパティラッパー
/// 以下を参考にしている
/// https://swiftsenpai.com/swift/create-the-perfect-userdefaults-wrapper-using-property-wrapper/#disqus_thread
@propertyWrapper
public struct UserDefaultValue<T: Codable> {
    
    private let key: String
    private let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    private var subject = PassthroughSubject<T, Never>()
    
    public var projectedValue: AnyPublisher<T, Never> {
        subject.eraseToAnyPublisher()
    }

    public var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
            
            // 値の送信
            subject.send(newValue)
        }
    }
}
