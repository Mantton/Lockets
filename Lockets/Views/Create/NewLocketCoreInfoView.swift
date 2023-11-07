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
                .disabled(date < .now)
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
