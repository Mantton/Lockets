//
//  CreateAudioLocketView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import SwiftUI

struct CreateAudioLocketView: View {
    @State private var record = false
    var body: some View {
        VStack {
            if record {
                AudioRecordingView(start: $record)
            } else {
                Button { record.toggle() } label: {
                    Label("Start Recording", systemImage: "mic")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
        .animation(.default, value: record)
    }
}


struct AudioRecordingView: View {
    @Binding var start: Bool
    @State private var recorder = AudioRecorder()
    @Environment(NewLocketModel.self) private var model
    var body: some View {
        ZStack {
            if recorder.isRecording {
                VStack {
                    Text(recorder.getFormattedDuration())
                        .font(.largeTitle)
                        .bold()
                    
                    Button { recorder.stop() } label: {
                        Label("Stop", systemImage: "stop")
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
            } else if recorder.storedRecording != nil {
                VStack(spacing: 15) {
                    Spacer()
                    if !recorder.isPlaying {
                        Button{ recorder.playAudio() } label: {
                            Label("Play", systemImage: "play")
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    } else {
                        Button{ recorder.stopPlayingAudio() } label: {
                            Label("Stop", systemImage: "stop")
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                    Button {
                        model.setAttachment(url: recorder.storedRecording!)
                        model.setState(.core)
                    } label: {
                        Label("Proceed", systemImage: "play")
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    Spacer()
                    Button("Record Another"){
                        start = false
                    }
                    .buttonStyle(.plain)
                    .font(.footnote)
                    .foregroundStyle(.primary.opacity(0.5))
                }
            } else {
                ProgressView()
                    .onAppear {
                        _ = recorder.record()
                    }
            }
        }
        .animation(.default, value: recorder.isPlaying)
        .animation(.default, value: recorder.isRecording)
        .animation(.default, value: recorder.currentRecordingDuration)
        
        
    }
}
