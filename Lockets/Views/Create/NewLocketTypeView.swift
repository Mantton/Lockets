//
//  NewLocketTypeView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

struct NewLocketTypeView: View {
    @Environment(NewLocketModel.self) private var model
    var body: some View {
        VStack(alignment: .leading) {
            Text("Choose A Locket")
                .font(.headline)
            Grid(alignment: .center, horizontalSpacing: 14, verticalSpacing: 14) {
                GridRow {
                    LocketTypeCell(type: .note)
                    LocketTypeCell(type: .letter)
                }
                
                GridRow {
                    LocketTypeCell(type: .link)
                    LocketTypeCell(type: .image)
                }
                
                GridRow {
                    LocketTypeCell(type:  .audio)
                    LocketTypeCell(type: .video)
                }
            }
            HStack {
                Spacer()
                Button("Continue") {
                    model.setState(.content)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                
            }
        }
        .padding()
    }
}

struct LocketTypeCell: View {
    let type: LocketType
    
    private let shape = RoundedRectangle(cornerRadius: 10)
    @Environment(NewLocketModel.self) private var model
    
    private var color: Color {
        type.color
    }
    
    private var name: String {
        type.name
    }
    
    private var image: String {
        type.image
    }
    
    var body: some View {
        ZStack {
            color.opacity(0.25)
            VStack {
                Text("")
                Spacer()
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .foregroundStyle(color.opacity(0.40))
                Spacer()
                Text(name)
                    .font(.headline)
                    .foregroundStyle(color.opacity(0.75))
            }
            .padding()
            
        }
        .clipShape(shape)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(color, lineWidth: 3)
                .opacity(model.locket.type == type ? 1 : 0)
        )
        .onTapGesture {
            model.setLocketType(type)
        }
    }
}

#Preview {
    NewLocketTypeView()
        .environment(NewLocketModel())
}
