//
//  SettingService.swift
//  MyCekikapeye
//
//  Created by Toto on 29/10/2021.
//

import Foundation

class SettingsService {
    
    private struct Keys {
        static let currency = "currency"
    }
    
    static var currency: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currency) ?? "€"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currency)
        }
    }
}
