//
//  CircularProgressView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

// Reference: https://sarunw.com/posts/swiftui-circular-progress-bar/
struct CircularProgressView: View {
    let color: Color = .accentColor
    let progress: Double
    let lineWidth: CGFloat = 3
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    progress > 1 ? .red : color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeOut, value: progress)

        }
    }
}

#Preview {
    CircularProgressView(progress: 0.3)
        .padding()
}

#Preview {
    CircularProgressView(progress: 1.3)
        .padding()
}
