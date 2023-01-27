//
//  ViewController.swift
//  EggTimer
//
//  Created by Алексей on 27.01.2023.
//

import UIKit
import AVFoundation

enum AudioFormat: String {
    case wav
    case mp3
}

enum Sound: String {
    case alarm_sound
}

final class ViewController: UIViewController {

    //MARK: - let\var
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime: Float = 0
    var secondsPassed: Float = 0

    //MARK: - IBOutlet
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!

    //MARK: - IBAction
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        guard let hardness = sender.titleLabel?.text else {return}
        guard let totalTime = eggTimes[hardness] else {return}

        self.totalTime = Float(totalTime)

        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }

    //MARK: - flow funcs
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let result = secondsPassed / totalTime
            progressBar.progress = result
            print(result)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"

            let url = Bundle.main.url(forResource: Sound.alarm_sound.rawValue,
                                      withExtension: AudioFormat.mp3.rawValue)
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
