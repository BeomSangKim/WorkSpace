//
//  ViewController.swift
//  MyConcentraitTimer
//
//  Created by Bumsang Kim on 2022/01/25.
//

import UIKit
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var duration = 60
    var timerStatus:TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    var rotateCount = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }

    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause:
            self.stopTimer()
            
        default:
            break
        }
    }
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration)
        debugPrint(self.duration)
        
        switch self.timerStatus {
        case .end:
            self.timerStatus = .start
            UIView.animate(withDuration: 0.3, animations: {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true
            self.currentSeconds = self.duration * 100
            self.startTimer()
            
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend()
            
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        }
    }
    
    func setTimerInfoVisible(isHidden: Bool) {
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }
    
    func startTimer() {
        if self.timer == nil{
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 0.01)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1
                let hour = self.currentSeconds / 360000
                let minute = (self.currentSeconds % 360000) / 6000
                let seconds = (self.currentSeconds % 6000) / 100
                let miliseconds = self.currentSeconds % 100
                
                self.timerLabel.text = String(format: "%02d:%02d:%02d:%02d", hour, minute, seconds, miliseconds)
                self.progressView.setProgress(Float(self.currentSeconds) / Float(self.duration*100), animated: true)
                
                if self.rotateCount == 100 {
                    UIView.animate(withDuration: 0.25, delay: 0, animations: {
                        self.imageView.transform = CGAffineTransform(rotationAngle: .pi / 5)
                    })
                    UIView.animate(withDuration: 0.25, delay: 0.25, animations: {
                        self.imageView.transform = CGAffineTransform(rotationAngle: -(.pi / 5))
                    })
                    UIView.animate(withDuration: 0.25, delay: 0.5, animations: {
                        self.imageView.transform = CGAffineTransform(rotationAngle: .pi / 5)
                    })
                    UIView.animate(withDuration: 0.25, delay: 0.75, animations: {
                        self.imageView.transform = CGAffineTransform(rotationAngle: -(.pi / 5))
                    })
                    self.rotateCount = 0
                }
                self.rotateCount += 1
                
                if self.currentSeconds <= 0 {
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
        })
        self.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
        
        UIView.animate(withDuration: 0.5, delay: 0.1, animations: {
            self.imageView.transform = CGAffineTransform(rotationAngle: 0)
        })
    }
}

