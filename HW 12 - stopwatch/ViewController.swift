//
//  ViewController.swift
//  HW 12 - stopwatch
//
//  Created by Артем Лазуткин on 09.06.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        button.setTitleColor(UIColor.black, for: .normal)
     }

    //MARK: - Variable || Outlets
    var timer = Timer()
    var workTime = 7
    var restingTime = 300
    var isWorkTime = false
    var isStarted = false

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBAction func startPauseButton(_ sender: Any) {
        if (isStarted) {
            isStarted = false
            timer.invalidate()
        } else {
            isStarted = true
            button.setTitleColor(.blue, for: .normal)
            createWorkTimer()
        }

    }

    //MARK: - Timer
    func createWorkTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(fireTimerWork),
                                     userInfo: nil,
                                     repeats: true
        )
    }

    func createRestingTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(fireRestingTimer),
                                     userInfo: nil,
                                     repeats: true
        )
    }


    //MARK: - Selector
    @objc func fireTimerWork() {
        workTime -= 1
        let time = secondsToMinutesSeconds(seconds: workTime)
        let timeString = timerStrigLabel(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
        timerLabel.textColor = .red

        if (workTime == 0) {
            timer.invalidate()
        }
    }

    @objc func fireRestingTimer() {
        workTime -= 1
        let time = secondsToMinutesSeconds(seconds: restingTime)
        let timeString = timerStrigLabel(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
        timerLabel.textColor = .green

        if (workTime == 0) {
            timer.invalidate()
            isWorkTime = false
        }
    }
    //MARK: - UI
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func timerStrigLabel(minutes: Int, seconds: Int) -> String {
        var timerStrigLabel = ""
        timerStrigLabel += String(format: "%02d", minutes)
        timerStrigLabel += " : "
        timerStrigLabel += String(format: "%02d", seconds)
        return timerStrigLabel
    }
}

