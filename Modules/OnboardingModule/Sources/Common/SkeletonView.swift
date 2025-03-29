//
//  Stock.swift
//  Pods
//
//  Created by Ahmad Alawneh on 28/03/2025.
//

import SwiftUI

struct SkeletonView: View {
    var body: some View {
        VStack {
            ForEach(0..<5, id: \.self) { _ in
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)

                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 150, height: 15)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 15)
                    }

                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .redacted(reason: .placeholder) // Adds SwiftUI's default shimmer effect
    }
}
#Preview {
    SkeletonView()
}
