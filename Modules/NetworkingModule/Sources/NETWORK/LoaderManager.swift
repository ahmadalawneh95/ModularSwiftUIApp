//
//  LoaderManager.swift
//  Pods
//
//  Created by Ahmad Alawneh on 29/03/2025.
//

import SwiftUI

public class LoaderManager: ObservableObject {
    @Published public var isLoading: Bool = false
    
    public init() {}

    public func startLoading() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
    }
    
    public func stopLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
