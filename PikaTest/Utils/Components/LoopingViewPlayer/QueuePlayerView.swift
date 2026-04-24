import Foundation
import AVFoundation
import UIKit

final class QueuePlayerView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    private var queuePlayer: AVQueuePlayer
    
    public init?(
        videoName: String,
        videoType: String
    ) {
        
        guard let fileURL = Bundle.main.url(forResource: videoName, withExtension: videoType) else {
            print("Error: No se encontró el video \(videoName).\(videoType)")
            return nil
        }

        let asset = AVAsset(url: fileURL)
        let item = AVPlayerItem(asset: asset)
        
        queuePlayer = AVQueuePlayer(playerItem: item)
        
        super.init(frame: .zero)

        playerLayer.player = queuePlayer
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QueuePlayerView {
    
    public func playQueuePlayer() {
        queuePlayer.play()
        queuePlayer.isMuted = false
    }
    
    public func stopQueuePlayer() {
        queuePlayer.pause()
    }
}
