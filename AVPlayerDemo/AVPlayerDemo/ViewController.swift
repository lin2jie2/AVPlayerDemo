//
//  ViewController.swift
//  AVPlayerDemo
//
//  Created by lin2jie2 on 2019/4/13.
//  Copyright © 2019 lin2jie2. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController, AVAudioPlayerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var audioPlayer: AVAudioPlayer? = nil

	@IBOutlet weak var btnSwitchRepeat: UISwitch!
	@IBOutlet weak var btnPlayAudio: UIButton!
	@IBOutlet weak var btnStopAudio: UIButton!
	@IBOutlet weak var btnPickVideo: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		btnStopAudio.isEnabled = false
	}

	func playAudio() {
		let audioURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "assets/pop_drip", ofType: "wav")!)
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: audioURL as URL)
			audioPlayer!.delegate = self
			if audioPlayer!.prepareToPlay() {
				audioPlayer!.play()
				self.btnStopAudio.isEnabled = true
				self.btnPlayAudio.isEnabled = false
			}
		}
		catch {
			print(error)
		}
	}

	func stopAudio() {
		audioPlayer!.stop()
		btnPlayAudio.isEnabled = true
		btnStopAudio.isEnabled = false
	}

	func selectVideo() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .savedPhotosAlbum
		imagePickerController.mediaTypes = [kUTTypeMovie as String]
		imagePickerController.delegate = self
		present(imagePickerController, animated: true)
	}

	@IBAction func buttonRepeatAudioTapped(_ sender: UISwitch) {
	}

	@IBAction func buttonPlayAudioTappend(_ sender: UIButton) {
		playAudio()
	}

	@IBAction func buttonStopAudioTappend(_ sender: UIButton) {
		stopAudio()
	}

	@IBAction func buttonPickVideoTappend(_ sender: UIButton) {
		selectVideo()
	}
}

extension ViewController {
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		if btnSwitchRepeat.isOn {
			audioPlayer!.play()
		}
		else {
			btnPlayAudio.isEnabled = true
			btnStopAudio.isEnabled = false
		}
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		dismiss(animated: true, completion: {
			let videoURL = info[UIImagePickerController.InfoKey.mediaURL]

			let videoPlayerViewController = self.storyboard!.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
			videoPlayerViewController.videoURL = videoURL as! NSURL?
			self.navigationController!.pushViewController(videoPlayerViewController, animated: true)
		})
	}

}
