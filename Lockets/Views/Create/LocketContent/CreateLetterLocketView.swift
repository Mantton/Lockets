//
//  CreateLetterLocketView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import SwiftUI

struct CreateLetterLocketView: View {
    @Environment(NewLocketModel.self) private var model
    @State private var text = ""
    var body: some View {
        VStack(alignment: .leading) {
            VStack (alignment: .leading){
                Text("Time to create an exciting new memory!")
                    .font(.headline)
                Text("Write your letter below!")
                    .font(.subheadline)
                    .italic()
                    .foregroundStyle(.gray)
            }
            TextEditor(text: $text)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.primary.opacity(0.75))
                .padding(.all, 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.accentColor.opacity(0.5), lineWidth: 2)
                )
            HStack (spacing: 3) {
                Spacer()
                if characterCount != 0 {
                    Text("\(characterCount) of \(LETTER_CHARACTER_LIMIT) Characters ")
                        .font(.footnote)
                        .fontWeight(.light)
                        .opacity(0.7)
                        .italic()
                        .transition(.opacity)
                    CircularProgressView(progress: fill)
                        .transition(.opacity)
                }
            }
            .frame(height: 12)
            .animation(.default, value: text)
        }
        LocketContentGatewayNavigationView(isNextDisabled: fill > 1 || characterCount <= 3, action: submit)
    }
    
    
    private var characterCount: Int {
        text.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    private var fill: Double {
        Double(text.count) / Double(LETTER_CHARACTER_LIMIT)
    }
    
    private func submit() {
        model.addTextContent(text)
    }
}

#Preview {
    CreateLetterLocketView()
}
