//
//  NewLocketCoreInfoView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

struct NewLocketCoreInfoView: View {
    @Environment(NewLocketModel.self) private var model
    @State private var date: Date = .now.advanced(by: 2000)
    @FocusState private var isTitleFocused
    @FocusState private var isPassphraseFocused

    var body: some View {
        @Bindable var model = model

        VStack(alignment: .leading, spacing: 20) {
            Text("Locket Info")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Name")
                    .font(.callout)
                TextField(text: $model.locket.title) {
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
            
            DatePicker(selection: $date, in: Date.now.advanced(by: 1800)...) {
                Text("Available On")
            }
            
            Toggle(isOn: $model.locket.onlyShowWhenUnlockable) {
                Text("Show Only When Unlockable")
            }
            
            
            Spacer()
            HStack {
                Button("Back") {
                    model.setState(.content)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                Spacer()
                Button("Preview") {
                    model.setState(.preview)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .disabled(model.locket.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || date < .now)
            }
        }
        .padding()
    }
    
    private func getColor(_ state: FocusState<Bool>) -> Color {
        state.wrappedValue == true ? .accentColor : .gray
    }
}

#Preview {
    NavigationStack {
        NewLocketCoreInfoView()
            .environment(NewLocketModel())
            .navigationTitle("New Locket")
    }

}
