//
//  TimerViewController.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/22/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var exercises: [Exercise]?
    var workoutName: String?
    var timer = Timer()
    var isTimerRunning = false
    var counter = 10
    var sets = 0
    var exerciseCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        setUp()
        if let exercises = exercises {
            workoutNameLabel.text = workoutName
            print("Timer exercises: \(exercises)")
        }
        // Do any additional setup after loading the view.
    }
    
    func setUp(){
        guard let exercises = self.exercises else  { return }
        //workoutNameLabel.text = workoutName
        exerciseNameLabel.text = exercises[0].name
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var currentTimerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBAction func startTapped(_ sender: Any) {
        
        if isTimerRunning{
            startButton.setTitle("RESUME", for: .normal)
            timer.invalidate()
            isTimerRunning = false
            return
        } else if !isTimerRunning {
            if startButton.titleLabel!.text != "RESUME" {
               sets = exercises![exerciseCounter].sets
            }
            startButton.setTitle("PAUSE", for: .normal)
            
            
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(runTimer),
                                         userInfo: nil,
                                         repeats: true)
            isTimerRunning = true
        }
    }
    @IBAction func stopTapped(_ sender: Any) {
        timer.invalidate()
        counter = 10
        currentTimerLabel.text = "00:00:00"
        isTimerRunning = false
        startButton.setTitle("START", for: .normal)
        setUpTimer()
    }
    
    @objc func runTimer() {
        print(sets)
        setLabel.text = "Sets Remaining: \(sets)"
        counter -= 1
        // MM:SS:_
        if counter == 0 {
            if sets > 1 {
                counter = 10
                sets -= 1
                return
            }
            if sets == 1 {
            exerciseCounter += 1
                if exerciseCounter < exercises!.count{
            exerciseNameLabel.text = exercises![exerciseCounter].name
                }
            }
            if exerciseCounter < exercises!.count {
                exerciseNameLabel.text = exercises![exerciseCounter].name
                sets = exercises![exerciseCounter].sets
//                exerciseCounter += 1
                counter = 10
                currentTimerLabel.text = "00:00:\(counter)"
            } else {
            setLabel.text = "Done!"
            exerciseCounter = 0
            counter = 10
            currentTimerLabel.text = "Good Workout!"
            timer.invalidate()
//            currentTimerLabel.backgroundColor = UIColor.red
            
            }
        }
        let flooredCounter = Int(floor(Double(counter)))
        let hour = flooredCounter / 3600
        
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        currentTimerLabel.text = "\(hour):\(minuteString):\(secondString)"
    }
    
    func setUpTimer() {
        currentTimerLabel.text = "00:00:\(counter)"
//        resetButton.isEnabled = false
//        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    
//    func continueTimer() {
//        exercises![0].reps
//    }
}
