//
//  ViewController.swift
//  Countdown Timer
//
//  Created by MacBook on 04.07.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // audi player created from AVFoundation class
    var audioPlayer: AVAudioPlayer?
    
    // initialized class Timer from Apple UIKit
    var timer = Timer()
    // I had to create variable here, due to func counter didn't see creation variable in IBAction
    var timeRemaining = 10
    // array to choose boiling time
    let boilingTime = ["Soft": 2, "Medium": 4, "Hard": 8]
    // variable to fix 100% of proggres bar
    var totalBar: Float = 1.0
    // variable to coundown progress bar
    var currentBar: Float = 1.0
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // progress bar show 100% when application runs
        progressBar.progress = 1

    }

    @IBAction func anyButtonPressed(_ sender: UIButton) {
        
        // invalidate method provides to cancel previous countdown
        timer.invalidate()
        // invalidate current progress bar
        progressBar.progress = 1
        
        // unwrapping current tittle of button with guard statement
        guard let pressedButton = sender.currentTitle else {
            return
        }
        // retrieved a value from dictionary, name of keys perform to titles of buttons
        // unwrapping value from dictionary with "if let" statement
        if let valueOfDictionary = boilingTime[pressedButton] {
            // transfer variable from boilingTime to function counter
            timeRemaining = valueOfDictionary
            currentBar = Float(timeRemaining)
            topLabel.text = "\(timeRemaining)"
        } else {
            print("error")
        }
        // initilizaton of timer and fetched data to countdown 
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        
    }
    // added objective C function to sequence of countdown start
   
    @objc func counter() {
       
        // conditional statement to countdown
        if timeRemaining > 0 {
            // countdown progress bar equation added
            totalBar = totalBar - (1 / Float(currentBar))
            // countdown time
            timeRemaining -= 1
            // countdown data appears on the screen
            topLabel.text = "\(timeRemaining)"
     
        } else {
            // sound play to notify that coundown is over
            // Done appears on the screen
            // timer stop function triggered
           
            playSound()
            topLabel.text = "Done"
            timer.invalidate()
            
        }
        // show on screen progress bar countdown
        
        // show on screen progress bar countdown
        progressBar.progress = totalBar

    }
    func playSound() {
        
        //  create URL session
        //  change a name tittle to pressedButton
        let url = Bundle.main.url(forResource: "F", withExtension: "wav")
        
        //  url became optiona, so I have to unwrap url, I use guard (it's shortage way)
        guard url != nil else {
            return
        }
        // Create the audio player and play the a sound from url session
        // transfer to variable URL session, add try, and add do - carch block
        // also I have to add exclamation mark to url
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
            
        } catch {
            print("error popped up, let's RFM again")
        }
    }
    
    
    
}

