//
//  PrimaryButton.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import SwiftUI

public struct PrimaryButton: View {
    public var title: String
    public var action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
