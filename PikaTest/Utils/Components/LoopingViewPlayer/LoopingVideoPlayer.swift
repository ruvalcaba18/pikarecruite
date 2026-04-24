import SwiftUI

struct LoopingVideoPlayer: UIViewRepresentable {
    let videoName: String
    let videoType: String
    @Binding var isPlaying: Bool

    func makeUIView(context: Context) -> QueuePlayerView {
         QueuePlayerView(
            videoName: videoName,
            videoType: videoType
        ) ?? QueuePlayerView(videoName: "", videoType: "")!
    }

    func updateUIView(_ uiView: QueuePlayerView, context: Context) {
        if isPlaying {
            uiView.playQueuePlayer()
        } else {
            uiView.stopQueuePlayer()
        }
    }
}
