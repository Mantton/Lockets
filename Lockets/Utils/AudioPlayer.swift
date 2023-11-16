//
//  AudioPlayer.swift
//  Lockets
//
//  Created by Mantton on 2023-11-11.
//

import AVFoundation
import SwiftUI

@Observable
class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    deinit {
        print("AudioPlayer Destroyed")
    }
    
    @ObservationIgnored
    private var player: AVAudioPlayer?
    
    var isPlaying: Bool = false

    func play(with url: URL) {
        do {

            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            player?.play()
            setIsPlaying(true)
        } catch {
            print("Error initializing AVAudioPlayer: \(error)")
        }
    }
    
    private func stop() {
        player?.stop()
        player = nil
    }
    
    func setIsPlaying(_ value: Bool) {
        withAnimation {
            isPlaying = value
        }
        if !value {
            stop()
        }
    }
    
    // Playback Did Finish
     func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
         setIsPlaying(false)
     }

    // Playback Interrupted
     func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
         setIsPlaying(false)
     }
}
