//
//  ViewController.swift
//  FutureCalc
//
//  Created by fernando mendoza on 8/27/16.
//  Copyright © 2016 Fernando Mendoza. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    
    
    enum Operation: String{
        case Divide  = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty  = "Empty"
        
    }
    
    @IBOutlet weak var answerLabl: UILabel!
    
    var btnPress: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation = Operation.Empty
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnPress  = AVAudioPlayer(contentsOf: soundUrl as URL)
            btnPress.prepareToPlay()
        } catch  let err as NSError {
            print(err.debugDescription)
        }
            
    }

    @IBAction func uponNumPress(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        answerLabl.text = runningNumber
    
    }
    
    @IBAction func onDivPressed( sender: UIButton!){
        processOperation(op: (Operation.Divide))
    }
    
    @IBAction func onMultPressed(sender: UIButton){
        processOperation(op: (Operation.Multiply))
    }
    
    @IBAction func onAddPressed(sender: UIButton!){
        processOperation(op: (Operation.Add))
    }
    
    @IBAction func onSubPressed(sender: UIButton!){
        processOperation(op: (Operation.Subtract))
    }
    
    @IBAction func onEqualPressd(sender : UIButton){
        processOperation(op: (currentOperation))
    }
    
    @IBAction func onClearPressed(sender: UIButton){
        resetCal()
    }
    
    func processOperation(op : Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            // Run some math
            
            //A user selsected an operator, but then selected another operator without
            //first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr =  result
                answerLabl.text = result
                
            }
            
            currentOperation = op
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    
    func resetCal(){
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        answerLabl.text = "0"
        
    }
    
    func playSound(){
        if btnPress.isPlaying {
            btnPress.stop()
        }
        btnPress.play()
    }
    


}
