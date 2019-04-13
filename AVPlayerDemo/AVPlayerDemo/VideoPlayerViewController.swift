//
//  AVPlayerViewController.swift
//  AVPlayerDemo
//
//  Created by lin2jie2 on 2019/4/13.
//  Copyright © 2019 lin2jie2. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

@objc
@objcMembers
class VideoPlayerViewController: AVPlayerViewController {
	var videoURL: NSURL? = nil
	var videoPlayer: AVPlayer? = AVPlayer()

	override func viewDidLoad() {
		super.viewDidLoad()

		loadVideo()
	}

	func loadVideo() {
		videoPlayer = AVPlayer(url: videoURL! as URL)
		let videoPlayerViewController = AVPlayerViewController()
		// videoPlayerViewController.showsPlaybackControls = false
		videoPlayerViewController.player = videoPlayer

		let callback = #selector(VideoPlayerViewController.playerDidReachEndNotificationHandler(notification:))
		NotificationCenter.default.addObserver(
			self,
			selector: callback,
			name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
			object: videoPlayer!.currentItem
		)

		present(videoPlayerViewController, animated: true)
		videoPlayerViewController.player!.play()
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		// videoPlayerViewController.showsPlaybackControls = true
		super.touchesBegan(touches, with: event)
	}

	func playerDidReachEndNotificationHandler(notification: NSNotification) {
		print("播放完毕")
	}

	func playerDidFinishNotificationHandler(notification: NSNotification) {
		print("关闭播放")
	}
}
