//
//  StoreValue.swift
//  
//  
//  Created by keiji0 on 2021/09/19
//  
//

import Foundation

/// 保存できる値を定義
public protocol StoreValue { }
extension Int: StoreValue {}
extension String: StoreValue {}
extension Float: StoreValue {}
extension Double: StoreValue {}
extension Bool: StoreValue {}
extension Data: StoreValue {}
extension Array: StoreValue where Element: UserDefaultSetting.StoreValue { }
extension Dictionary: StoreValue where Key == String, Value: UserDefaultSetting.StoreValue {}
