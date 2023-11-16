//
//  AudioRecorder.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import Foundation
import AVFoundation
import SwiftUI


@Observable
final class AudioRecorder {
    
    deinit {
        try? FileManager.default.removeItem(at: getURL())
        currentPlayer = nil
        print("AudioRecorder Destroyed")
    }
    @ObservationIgnored
    private let session = AVAudioSession.sharedInstance()
    @ObservationIgnored
    private let RECORDER_SETTINGS : [String: Any] = [ AVFormatIDKey:kAudioFormatLinearPCM,
                                          AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue,
                                               AVEncoderBitRateKey:320000,
                                             AVNumberOfChannelsKey:2,
                                                   AVSampleRateKey:44100.0]
    @ObservationIgnored
    private let MAX_RECORDING_TIME: TimeInterval = 5 * 60 // 5 minutes
    
    @ObservationIgnored
    private var currentRecorder: AVAudioRecorder?
    @ObservationIgnored
    private var currentRecordingID = UUID().uuidString
    
    @ObservationIgnored
    private var levelTimer: Timer?
    @ObservationIgnored
    private var currentTimer: Timer?
    
    @ObservationIgnored
    private var currentPlayingTimer: Timer?
    
    var currentRecordingDuration: TimeInterval = 0
    var currentRecoringPower: Float = 0
    var isRecording = false
    var isPlaying = false
    var storedRecording: URL?
    
    @ObservationIgnored
    private var currentPlayer: AVAudioPlayer?
    
    
    func setup() throws  {
        stop()
        try session.setCategory(.playAndRecord, mode: .default)
        
        try session.setActive(true)
        let url = getURL()
        print(url)
        let recorder = try AVAudioRecorder(url: url, settings: RECORDER_SETTINGS)
        self.currentRecorder = recorder
    }
    
    private func getURL() -> URL {
        let directory = FileManager
            .default
            .temporaryDirectory
            .appending(path: "recordings", directoryHint: .isDirectory)
        directory.createDirectory()
        return directory.appending(path: "\(currentRecordingID).wav")
    }
    
    func record() -> Bool {
        do {
            try setup()
            guard let currentRecorder else { return false }
            let isReady = currentRecorder.prepareToRecord()
            guard isReady else { return false }
            currentRecorder.isMeteringEnabled = true
            currentRecorder.record(forDuration: MAX_RECORDING_TIME)
            startPreliminaryTimers()
            isRecording = true
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    func stop() {
        currentRecorder?.stop()
        stopPreliminaryTimers()
    }
    
    private func startPreliminaryTimers() {
        levelTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                          target: self,
                                          selector: #selector(updateAudioMeter(timer:)),
                                          userInfo: nil,
                                          repeats: true)
        
        
        currentTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                            target: self,
                                            selector: #selector(updateCurrentTimer(timer:)),
                                            userInfo: nil,
                                            repeats: true)
    }
    
    @objc private func updateAudioMeter(timer: Timer) {
        guard let currentRecorder else { return }
        currentRecorder.updateMeters()
        
        let power = currentRecorder.averagePower(forChannel: 0)
        let powerPercentage = pow(10, (0.05 * power))
        
        updateUI(with: powerPercentage)
    }
    
    @objc private func updateCurrentTimer(timer: Timer) {
        guard let currentRecorder else { return }
        currentRecordingDuration = currentRecorder.currentTime
        
        if currentRecordingDuration == MAX_RECORDING_TIME {
            stopPreliminaryTimers()
        }
    }
    
    private func updateUI(with power: Float) {
        currentRecoringPower = power
    }
    
    
    private func stopPreliminaryTimers() {
        levelTimer?.invalidate()
        levelTimer = nil
        
        currentTimer?.invalidate()
        currentTimer = nil
        
        isRecording = false
        
        let url = getURL()
        if url.exists {
            storedRecording = url
        }
    }
    
    func getFormattedDuration() -> String {
        let hours = Int(currentRecordingDuration) / 3600
        let minutes = Int(currentRecordingDuration) / 60 % 60
        let seconds = Int(currentRecordingDuration) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}


extension AudioRecorder {
    func playAudio() {
        do {
            let player = try AVAudioPlayer(contentsOf: getURL())
            player.prepareToPlay()
            player.play()
            currentPlayer = player
            currentPlayingTimer = Timer.scheduledTimer(timeInterval: 0.33,
                                              target: self,
                                              selector: #selector(updatePlayingTimer(timer:)),
                                              userInfo: nil,
                                              repeats: true)
            isPlaying = true
        } catch {
            print(error)
        }
    }
    
    func stopPlayingAudio() {
        currentPlayer?.stop()
        isPlaying = false
    }
    
    @objc private func updatePlayingTimer(timer: Timer) {
        guard let currentPlayer else { return }
        self.isPlaying = currentPlayer.isPlaying
        if !isPlaying {
            currentPlayingTimer?.invalidate()
            currentPlayingTimer = nil
        }
    }

}
