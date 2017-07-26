//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Michael Mirochnik on 7/25/17.
//  Copyright © 2017 Michael Mirochnik. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
        
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    
    @IBAction func onDividePressed (sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed (sender: AnyObject) {
            processOperation(operation: .Multiply)
    }
    
    @IBAction func onAddPressed (sender: AnyObject) {
            processOperation(operation: .Add)
    }
    
    @IBAction func onSubtractPressed (sender: AnyObject) {
            processOperation(operation: .Subtract)
    }
    
    
    @IBAction func onEqualButtonPressed (sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            ///User selected an operator, but then selected another operator without first entering a number.
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else { ///this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
   
    @IBAction func clearPressed(_ sender: Any) {
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        outputLbl.text = "0"
    }
    
    
}
