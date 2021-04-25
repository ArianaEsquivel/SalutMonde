//
//  TransmisionViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 15/04/21.
//

import UIKit
import AVKit
import AVFoundation


class TransmisionViewController: UIViewController, AVPlayerViewControllerDelegate {
    var nameImage : String!
    var ipCam : String!
    var playerLayer = AVPlayerLayer()
    @IBOutlet weak var ivTransmision: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()
//        self.ivTransmision.load(url: URL(string: "http://b2cf3dd421e3.ngrok.io/video_feed")!)
//        self.ivTransmision.loadI(url:  URL(string: "https://www.snsmarketing.es/blog/wp-content/uploads/2016/02/gifanimado.gif")!)
    }
    
    func playVideo(){
        let videoURL = URL(string: "https://youtu.be/WjJBRhPiM_I")
        let player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(playerLayer)
        player.play()

    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        playerLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }


}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
