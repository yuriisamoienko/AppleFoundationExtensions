//
//  StringLocalization.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 30.04.2022.
//

import Foundation

public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    
    public var localized: String {
        let bundle = Bundle.main
        let localeIdentifier = Localize.localeCode()
        let result = NSLocalizedString(self, tableName: "Localization_\(localeIdentifier)", bundle: bundle, comment: "")
        if result == "" {
            return self
        }
        return result
    }
}

public class Localize {
    
    static var currentLocale: Locale {
        Locale(identifier: localeCode())
    }
    
    public static func localeCode() -> String {
        var localeIdentifier = UserDefaults.standard.value(forKey: "AppLanguageUI") as? String ?? "" // "en_US"
        if localeIdentifier == "auto" {
            localeIdentifier = ""
        }
        if localeIdentifier == "" {
            let supportedLangs = ["ru", "en"]
            if let obj = UserDefaults.standard.value(forKey: "AppleLanguages") {
                if let appleLanguages = obj as? [String] {
                    for lang in appleLanguages {
                        let langCode = String(lang.prefix(2))
                        if supportedLangs.contains(langCode) {
                            localeIdentifier = langCode
                            break
                        }
                    }
                }
            }
        }
        if localeIdentifier == "" {
            localeIdentifier = "en"
        }
        return localeIdentifier
    }
}

