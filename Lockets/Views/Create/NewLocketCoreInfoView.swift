//
//  NewLocketCoreInfoView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

struct NewLocketCoreInfoView: View {
    @Environment(NewLocketModel.self) private var model
    @State private var title: String = ""
    @State private var date: Date = .now
    @State private var showBeforeAvailable = false
    @FocusState private var isTitleFocused
    @FocusState private var isPassphraseFocused

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Locket Info")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Name")
                    .font(.callout)
                TextField(text: $title) {
                    Text("Locket Name")
                }
                .focused($isTitleFocused)
                .padding()
                .overlay {
                    if isTitleFocused {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.accentColor.opacity(0.8), lineWidth: 2)
                    } else {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.primary.opacity(0.8), lineWidth: 1.5)
                    }
                }
            }
            
            DatePicker(selection: $date, in: Date.now...) {
                Text("Available On")
            }
            
            Toggle(isOn: $showBeforeAvailable) {
                Text("Show Only When Unlockable")
            }
            
            
            Spacer()
            HStack {
                Spacer()
                Button("Preview  🏹") {
                    model.setState(.preview)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || date < .now)
                Spacer()
            }
        }
        .padding()
    }
    
    private func getColor(_ state: FocusState<Bool>) -> Color {
        state.wrappedValue == true ? .accentColor : .gray
    }
}

#Preview {
    NewLocketCoreInfoView()
        .environment(NewLocketModel())
}
