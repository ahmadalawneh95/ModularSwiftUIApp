//
//  LocalizedStrings.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Foundation

public class LocalizedStrings {
    public static let shared = LocalizedStrings()

    public func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
