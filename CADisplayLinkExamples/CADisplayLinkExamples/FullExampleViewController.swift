//
//  FullExampleViewController.swift
//  CADisplayLinkExamples
//
//  Created by Steven Curtis on 07/12/2020.
//

import UIKit

final class FullExampleViewController: UIViewController {

    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!

    private var lastUpdate: TimeInterval = 0
    private var elapsedTime: TimeInterval = 0
    
    // seconds for the time, 60th of a second for CADisplayLink
    private var seconds = 0
    
    // the timer instance
    private var timer = Timer()
    
    // set up the CADisplayLink
    private var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func segmentedAction(_ sender: UISegmentedControl) {
        resetAll()
    }

    @IBAction private func startAction(_ sender: UIButton) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            runTimer()
        default:
            runCADisplay()
        }
        startButton.isEnabled = false
    }
    
    @IBAction private func resetAction(_ sender: UIButton) {
        resetAll()
    }
    
    // invalidate the timers and reset the time
    private func resetAll() {
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
    
    private func runCADisplay() {
        // setup the displaylink
        displayLink = CADisplayLink(target: self, selector: #selector(updateCADisplayLink))
        // preferred preferredFrameRateRange - ios15 only
        displayLink?.preferredFrameRateRange = CAFrameRateRange(minimum: 8, maximum: 15, __preferred: 0)
        // register the displayLink with a runLoop. Common is the mode to use for timers
        displayLink?.add(to: .current, forMode: .common)
    }
    
    private func runTimer() {
        // set up the timer to run updateTimer every second
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FullExampleViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    // the function that the CADisplayLink will fire
//    @objc func updateCADisplayLink(displayLink: CADisplayLink) {
//        // only currently works for 60 frames a second.
//        let actualFramesPerSecond = 1 / (displayLink.targetTimestamp - displayLink.timestamp)
//        print(actualFramesPerSecond)
//        // increment the number of seconds, actually a screen refresh here
//        seconds += 1
//        // each "second" here is actually a screen refresh, so /60 of a second
//        // we can use mod and / to convert to seconds
//        if seconds % 60 == 0 {
//            // update the timerLabel
//            timerLabel.text = Double(seconds / 60).asTime(style: .positional)
//        }
//    }
    
    @objc private func updateCADisplayLink(displayLink: CADisplayLink) {
        // Check if this is the first frame
        if lastUpdate == 0 {
            lastUpdate = displayLink.timestamp
            return
        }
        
        // Calculate the elapsed time between frames
        let timestamp = displayLink.timestamp
        let frameDuration = timestamp - lastUpdate
        lastUpdate = timestamp
        elapsedTime += frameDuration
        
        if elapsedTime >= 1.0 {
            // Update every second
            seconds += 1
            
            // Update the timerLabel
            timerLabel.text = Double(
                seconds
            ).asTime(
                style: .positional
            )
            elapsedTime -= 1.0  // Subtract the second to start counting the next second
        }
    }
    
    @objc private func updateTimer() {
        // increment the number of seconds, actually a screen refresh here
        seconds += 1
        // update the timerLabel
        timerLabel.text = Double(seconds).asTime(style: .positional)
    }
}
