//
//  ViewController.swift
//  movieStreamerPoc
//
//  Created by Thom Peele on 30/11/2017.
//  Copyright © 2017 Thom Peele. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController {

    @IBOutlet var videoPlayerView: YouTubePlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // init YouTubePlayerView w/ playerFrame rect (assume playerFrame declared)
        
//        videoPlayerView = YouTubePlayerView(frame: videoPlayerView.frame)
        // Load video from YouTube ID
//        videoPlayerView.loadVideoID("nfWlot6h_JM")
        
        // Load video from YouTube URL
        let myVideoURL = URL(string: "https://www.youtube.com/watch?v=DTBu4tigSDo")
//        videoPlayer.loadVideoURL(myVideoURL!)
        videoPlayerView.loadVideoURL(myVideoURL!)
        print(videoPlayerView.playerState)
        videoPlayerView.play()
        
//        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//        let player = AVPlayer(url: videoURL!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.bounds
//        self.view.layer.addSublayer(playerLayer)
//        player.play()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class CustomYoutubePlayerView: YouTubePlayerView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadVideoURL(_ videoURL: URL) {
        super.loadVideoURL(videoURL)
    }
    
//    override func loadVideoID(_ videoID: String) {
//        super.loadVideoID(videoID)
//    }
    
    override func play() {
        super.play()
    }
    
}

