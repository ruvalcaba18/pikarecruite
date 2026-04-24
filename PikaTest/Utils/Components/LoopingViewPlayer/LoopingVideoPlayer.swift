import SwiftUI

struct LoopingVideoPlayer: UIViewRepresentable {
    let videoName: String
    let videoType: String

    func makeUIView(context: Context) -> UIView {
        QueuePlayerView(
            videoName: videoName,
            videoType: videoType
        )
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
