//
//  UserDefaultValueble.swift
//  
//  
//  Created by keiji0 on 2021/09/19
//  
//

import Foundation

/// ユーザーの設定値
/// 実際の保存型に変換する機能を提供する
public protocol UserValueble {
    /// 保存形式の値
    associatedtype StoreValue: UserDefaultSetting.StoreValue
    /// 初期値を取得
    static var defaultValue: Self { get }
    /// 保存形式の方に変換
    static func encode(_ value: Self) -> StoreValue?
    /// 保存形式の型から自身の型へ変換
    static func decode(_ value: StoreValue) -> Self?
}
