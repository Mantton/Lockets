//
//  CreateNoteLocketView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

struct CreateNoteLocketView: View {
    @Environment(NewLocketModel.self) private var model
    @State private var text = ""
    var body: some View {
        VStack(alignment: .leading) {
            VStack (alignment: .leading){
                Text("Time to create an exciting new memory!")
                    .font(.headline)
                Text("Write your note below!")
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
                    Text("\(characterCount) of 240 Characters ")
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
        .onChange(of: model.state, initial: true, { oldValue, _ in
            if oldValue == .content {
                text.removeAll()
            }
        })
        LocketContentGatewayNavigationView(isNextDisabled: fill > 1 || characterCount <= 3, action: submit)
    }
    
    
    private var characterCount: Int {
        text.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    private var fill: Double {
        Double(text.count) / 240.0
    }
    
    private func submit() {
        model.addNoteContent(text)
        text.removeAll()
    }
}

#Preview {
    CreateNoteLocketView()
        .padding()
        .environment(NewLocketModel())
}
