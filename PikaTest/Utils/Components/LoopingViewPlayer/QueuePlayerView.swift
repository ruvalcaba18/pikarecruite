import Foundation
import AVFoundation
import UIKit

final class QueuePlayerView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?

    public init(
        videoName: String,
        videoType: String
    ) {
        super.init(frame: .zero)

        guard let fileURL = Bundle.main.url(forResource: videoName, withExtension: videoType) else {
            print("Error: No se encontró el video \(videoName).\(videoType)")
            return
        }

        let asset = AVAsset(url: fileURL)
        let item = AVPlayerItem(asset: asset)
        
        let queuePlayer = AVQueuePlayer(playerItem: item)
        playerLayer.player = queuePlayer
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
        
        queuePlayer.play()
        queuePlayer.isMuted = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

