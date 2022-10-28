//
//  FullExampleViewController.swift
//  CADisplayLinkExamples
//
//  Created by Steven Curtis on 07/12/2020.
//

import UIKit

class FullExampleViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        resetAll()
    }
    
    @IBOutlet weak var semgentedControl: UISegmentedControl!
    
    // seconds for the time, 60th of a second for CADisplayLink
    var seconds = 0
    
    // the timer instance
    var timer = Timer()
    
    // set up the CADisplayLink
    var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startAction(_ sender: UIButton) {
        switch semgentedControl.selectedSegmentIndex {
        case 0:
            runTimer()
        default:
            runCADisplay()
        }
        startButton.isEnabled = false
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        resetAll()
    }
    
    // invalidate the timers and reset the time
    func resetAll() {
        // invalidate displayLink
        displayLink?.invalidate()
        // invalidate the timer
        timer.invalidate()
        // reset the seconds
        seconds = 0
        // set the label to be zero again
        timerLabel.text = Double(seconds).asTime(style: .positional)
        // enable the startbutton
        startButton.isEnabled = true
    }
    
    func runCADisplay() {
        // setup the displaylink
        displayLink = CADisplayLink(target: self, selector: #selector(updateCADisplayLink))
        // preferred framerate, the default is 0 which is the device's maximum
        displayLink?.preferredFramesPerSecond = 0
        // register the displayLink with a runLoop. Common is the mode to use for timers
        displayLink?.add(to: .current, forMode: .common)
    }
    
    func runTimer() {
        // set up the timer to run updateTimer every second
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FullExampleViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    // the function that the CADisplayLink will fire
    @objc func updateCADisplayLink() {
        // increment the number of seconds, actually a screen refresh here
        seconds += 1
        // each "second" here is actually a screen refresh, so /60 of a second
        // we can use mod and / to convert to seconds
        if seconds % 60 == 0 {
            // update the timerLabel
            timerLabel.text = Double(seconds / 60).asTime(style: .positional)
        }
    }
    
    @objc func updateTimer() {
        // increment the number of seconds, actually a screen refresh here
        seconds += 1
        // update the timerLabel
        timerLabel.text = Double(seconds).asTime(style: .positional)
    }
}



