//
//  ViewController.swift
//  Countdown Timer
//
//  Created by MacBook on 04.07.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //
    var audioPlayer: AVAudioPlayer?
    
    // initialized class Timer from Apple UIKit
    var timer: Timer!
    var timeRemaining = 10
    let boilingTime = ["Soft": 3, "Medium": 5, "Hard": 8]
   

    @IBOutlet weak var topLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func anyButtonPressed(_ sender: UIButton) {
        // unwrapping current tittle of button with guard statement
        guard let pressedButton = sender.currentTitle else {
            return
        }
        // retrieved a value from dictionary, name of keys perform to titles of buttons
        // unwrapping value from dictionary with guard statement
        if let valueOfDictionary = boilingTime[pressedButton] {
            // transfer variable from boilingTime to function counter
            timeRemaining = valueOfDictionary
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
            timeRemaining -= 1
     
        } else {
            // sound play to notify that coundown is over
            // timer stop function triggered
            playSound()
            timer.invalidate()
        }
        topLabel.text = "\(timeRemaining)"

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

