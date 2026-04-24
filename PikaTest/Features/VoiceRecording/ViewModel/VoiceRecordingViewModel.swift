import Foundation
import Combine
import SwiftUI
import Speech

enum RecordingState {
    case idle
    case recording
    case finished
}

@MainActor
final class VoiceRecordingViewModel: ObservableObject {
    @Published var state: RecordingState = .idle
    @Published var currentWordIndex = -1
    
    let baseText = "My best self is just ahead. The life I've always wanted is here. My goals are in reach. I love affirmations."
    
    lazy var targetWords: [String] = {
        baseText.components(separatedBy: .whitespacesAndNewlines)
            .map { $0.replacingOccurrences(of: "[^a-zA-Z]", with: "", options: .regularExpression).lowercased() }
            .filter { !$0.isEmpty }
    }()

    lazy var displayWords: [String] = {
        baseText.components(separatedBy: .whitespacesAndNewlines)
    }()
    
    private let speechService = SpeechService()
    private let recordingService = VoiceRecordingService()
    private var audioPlayer: AVAudioPlayer?
    
    func startRecording() async {
        let status = await withCheckedContinuation { (continuation: CheckedContinuation<SFSpeechRecognizerAuthorizationStatus, Never>) in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
        
        guard status == .authorized else { return }
        
        state = .recording
        currentWordIndex = -1
        recordingService.startRecording()
        
        speechService.startSpeechRecognition { [weak self] transcript in
            guard let self = self else { return }
            Task {
                await self.processTranscript(transcript)
            }
        }
    }
    
    func stopRecording() {
        state = .finished
        speechService.stopSpeechRecognition()
        recordingService.stopRecording()
    }
    
    func resetRecording() {
        state = .idle
        currentWordIndex = -1
        speechService.stopSpeechRecognition()
        recordingService.stopRecording()
        audioPlayer?.stop()
    }
    
    func playRecording() {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("recording.m4a")
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Playback failed: \(error)")
        }
    }
    
    private func processTranscript(_ transcript: String) async {
        let recognizedWords = transcript.lowercased()
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
        
        var matchIndex = currentWordIndex
        
        for word in recognizedWords {
            let nextTarget = matchIndex + 1
            if nextTarget < targetWords.count {
                if recognize(word, matches: targetWords[nextTarget]) {
                    matchIndex = nextTarget
                }
            }
        }
        
        if matchIndex > self.currentWordIndex {
            self.currentWordIndex = matchIndex
            
            if matchIndex == targetWords.count - 1 {
                stopRecording()
            }
        }
    }
    
    var attributedKaraokeText: AttributedString {
        var attributedString = AttributedString(baseText)
        let words = displayWords
        var searchRange = attributedString.startIndex..<attributedString.endIndex
        
        let spokenLila = Color(red: 0.38, green: 0.4, blue: 0.95)
        let pendingLavender = Color(red: 0.7, green: 0.75, blue: 1.0).opacity(0.5)
        
        for (index, word) in words.enumerated() {
            if let range = attributedString[searchRange].range(of: word) {
                if index <= currentWordIndex {
                    attributedString[range].foregroundColor = spokenLila
                    attributedString[range].font = .telkaMedium(size: 26)
                } else {
                    attributedString[range].foregroundColor = pendingLavender
                    attributedString[range].font = .telkaMedium(size: 26)
                }
                searchRange = range.upperBound..<attributedString.endIndex
            }
        }
        return attributedString
    }
    
    private func recognize(_ word: String, matches target: String) -> Bool {
        if word == target { return true }
        if word.contains(target) || target.contains(word) { return true }
        return false
    }
}
