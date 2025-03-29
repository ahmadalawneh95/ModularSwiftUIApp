//
//  URLSession+Swizzling.swift
//  ModularSwiftUIApp
//
//  Created by Ahmad Alawneh on 29/03/2025.
//

import Foundation

extension URLSession {
    private static var originalShared: URLSession?
    private static var swizzledConfiguration: URLSessionConfiguration?
    
    static func swizzleSharedSession(configuration: URLSessionConfiguration) {
        originalShared = URLSession.shared
        swizzledConfiguration = configuration
        
        let originalMethod = class_getClassMethod(URLSession.self, #selector(getter: URLSession.shared))!
        let swizzledMethod = class_getClassMethod(URLSession.self, #selector(URLSession.swizzledShared))!
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    static func restoreSharedSession() {
        guard originalShared != nil else { return }
        
        let originalMethod = class_getClassMethod(URLSession.self, #selector(URLSession.swizzledShared))!
        let swizzledMethod = class_getClassMethod(URLSession.self, #selector(getter: URLSession.shared))!
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
        swizzledConfiguration = nil
        originalShared = nil
    }
    
    @objc private class func swizzledShared() -> URLSession {
        if let config = swizzledConfiguration {
            return URLSession(configuration: config)
        }
        return swizzledShared() // This will actually call the original shared after swizzling
    }
}
