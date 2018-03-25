//
//  ViewController.swift
//  Tic Tac Toe Game
//
//  Created by Asiqul Hoque on 5/8/16.
//  Copyright © 2016 Asiqul Hoque. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var top1: UIImageView!
    @IBOutlet weak var top2: UIImageView!
    @IBOutlet weak var top3: UIImageView!
    

    @IBOutlet weak var middle1: UIImageView!
    @IBOutlet weak var middle2: UIImageView!
    @IBOutlet weak var middle3: UIImageView!

    
    
    @IBOutlet weak var bottom1: UIImageView!
    @IBOutlet weak var bottom2: UIImageView!
    @IBOutlet weak var bottom3: UIImageView!
    
    
    @IBOutlet weak var top1Btn: UIButton!
    @IBOutlet weak var top2Btn: UIButton!
    @IBOutlet weak var top3Btn: UIButton!
    
    @IBOutlet weak var middle1Btn: UIButton!
    @IBOutlet weak var middle2Btn: UIButton!
    @IBOutlet weak var middle3Btn: UIButton!
    
    
    @IBOutlet weak var bottom1Btn: UIButton!
    @IBOutlet weak var bottom2Btn: UIButton!
    @IBOutlet weak var bottom3Btn: UIButton!
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var lossLabel: UILabel!
    @IBOutlet weak var tiesLabel: UILabel!
    
    var winCount = 0
    var lossCount = 0
    var tieCount = 0
    
    var listMoves = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableAllButtons()
        clearImageViews()
        outputLabel.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startGame(sender: AnyObject) {
        playButton.hidden = true
        enableAllButtons()
        clearImageViews()
        listMoves = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
        outputLabel.text = "Your move!"
        outputLabel.hidden = false
        
    }
    
    
    
    @IBAction func xoButtonPressed(sender: AnyObject) {
        outputLabel.text = ""
        setXO(1, location: sender.tag)
        var isWinner = checkWinner()
        if isWinner == "x" {
            outputLabel.text = "You've Won!"
            winCount += 1
            winLabel.text = String(winCount)
            playButton.hidden = false
            disableAllButtons()
            return
        } else if isWinner == "draw" {
            outputLabel.text = "It's a draw!"
            tieCount += 1
            tiesLabel.text = String(tieCount)
            playButton.hidden = false
            disableAllButtons()
            return
        }
        pickSquare()
        isWinner  = checkWinner()
        if isWinner == "o" {
            outputLabel.text = " You lose! Play again?"
            lossCount += 1
            lossLabel.text = String(lossCount)
            playButton.hidden = false
            disableAllButtons()
            return
            
        } else if isWinner  == "draw" {
            outputLabel.text = "It's a draw!"
            tieCount += 1
            tiesLabel.text = String (tieCount)
            playButton.hidden = false
            disableAllButtons()
            return
        } else {
            let output = Int(arc4random_uniform(2))
            if output == 0 {
                outputLabel.text = "Your turn!"
            }
            else {
                outputLabel.text = "Your move!"
            }
        }
    }


    
    func pickSquare() {
        var place = false
        //Try to win
        place = checkAlgorithm(false)
        if !place {
            //Try to block
            place = checkAlgorithm(true)
            if !place {
                findAGoodSquare()
            }
        }
    }
    
    func findAGoodSquare() {
        var tempSquare: Int = 0
        for square in listMoves {
            if square == "x" || square == "o" {
                continue
            } else {
                if square == "4" {
                    setXO(0, location: 4)
                    return
                }
                tempSquare = Int(square)!
            }
        }
        setXO(0, location:tempSquare)
    }
       
    
    
    //Sets an X or O to the chosen ImageView
    func setXO(player:Int, location:Int) {
        var xoro = ""
        if player == 0 {
            xoro = "o"
        } else {
            xoro = "x"
        }
        if location == 0 {
            top1.image = UIImage (named: xoro)
        } else if location == 1 {
            top2.image = UIImage(named: xoro)
        } else if location == 2 {
            top3.image = UIImage(named: xoro)
        } else if location == 3 {
            middle1.image = UIImage(named: xoro)
        } else if location == 4 {
            middle2.image = UIImage(named: xoro)
        } else if location == 5 {
            middle3.image = UIImage(named: xoro)
        } else if location == 6 {
            bottom1.image = UIImage(named: xoro)
        } else if location == 7 {
            bottom2.image = UIImage(named: xoro)
        } else if location == 8 {
            bottom3.image = UIImage(named: xoro)
        }
        disableButton(location)
        listMoves[location] = xoro
    }
    
    //Blanks out the X's and O's
    func clearImageViews() {
        top1.image = nil
        top2.image = nil
        top3.image = nil
        middle1.image = nil
        middle2.image = nil
        middle3.image = nil
        bottom1.image = nil
        bottom2.image = nil
        bottom3.image = nil
    }
    
    //(Re)Enables all X and O buttons
    func enableAllButtons() {
        top1Btn.enabled = true
        top2Btn.enabled = true
        top3Btn.enabled = true
        middle1Btn.enabled = true
        middle2Btn.enabled = true
        middle3Btn.enabled = true
        bottom1Btn.enabled = true
        bottom2Btn.enabled = true
        bottom3Btn.enabled = true
    }
    
    //Disables all X and O buttons
    func disableAllButtons() {
        top1Btn.enabled = false
        top2Btn.enabled = false
        top3Btn.enabled = false
        middle1Btn.enabled = false
        middle2Btn.enabled = false
        middle3Btn.enabled = false
        bottom1Btn.enabled = false
        bottom2Btn.enabled = false
        bottom3Btn.enabled = false
    }
    
    //Disables/hides a single button
    func disableButton(location:Int) {
        if location == 0 {
            top1Btn.enabled = false;
        } else if location == 1 {
            top2Btn.enabled = false;
        } else if location == 2 {
            top3Btn.enabled = false;
        } else if location == 3 {
            middle1Btn.enabled = false;
        } else if location == 4 {
            middle2Btn.enabled = false;
        } else if location == 5 {
            middle3Btn.enabled = false;
        } else if location == 6 {
            bottom1Btn.enabled = false;
        } else if location == 7 {
            bottom2Btn.enabled = false;
        } else if location == 8 {
            bottom3Btn.enabled = false;
        }
    }
    //Checks for where the computer needs to block/can win
    func checkAlgorithm(block:Bool) -> Bool {
        var symbol = ""
        if block {
            symbol = "x"
        } else {
            symbol = "o"
        }
        
        if(listMoves[0] == symbol) {
            if(listMoves[1] == symbol) {
                if(listMoves[2] == "2") {
                    setXO(0, location: 2)
                    return true
                }
            }
            if(listMoves[2] == symbol) {
                if(listMoves[1] == "1") {
                    setXO(0, location: 1)
                    return true
                }
            }
            if(listMoves[3] == symbol) {
                if(listMoves[6] == "6") {
                    setXO(0, location: 6)
                    return true
                }
            }
            if(listMoves[6] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
            if(listMoves[4] == symbol) {
                if(listMoves[8] == "8") {
                    setXO(0, location: 8)
                    return true
                }
            }
            if(listMoves[8] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
        }
        if(listMoves[1] == symbol) {
            if(listMoves[0] == symbol) {
                if(listMoves[2] == "2") {
                    setXO(0, location: 2)
                    return true
                }
            }
            if(listMoves[2] == symbol) {
                if(listMoves[0] == "0") {
                    setXO(0, location: 0)
                    return true
                }
            }
            if(listMoves[4] == symbol) {
                if(listMoves[7] == "7") {
                    setXO(0, location: 7)
                    return true
                }
            }
            if(listMoves[7] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
        }
        if(listMoves[2] == symbol) {
            if(listMoves[1] == symbol) {
                if(listMoves[0] == "0") {
                    setXO(0, location: 0)
                    return true
                }
            }
            if(listMoves[0] == symbol) {
                if(listMoves[1] == "1") {
                    setXO(0, location: 1)
                    return true
                }
            }
            if(listMoves[4] == symbol) {
                if(listMoves[6] == "6") {
                    setXO(0, location: 6)
                    return true
                }
            }
            if(listMoves[6] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
            if(listMoves[5] == symbol) {
                if(listMoves[8] == "8") {
                    setXO(0, location: 8)
                    return true
                }
            }
            if(listMoves[8] == symbol) {
                if(listMoves[5] == "5") {
                    setXO(0, location: 5)
                    return true
                }
            }
        }
        if(listMoves[3] == symbol) {
            if(listMoves[0] == symbol) {
                if(listMoves[6] == "6") {
                    setXO(0, location: 6)
                    return true
                }
            }
            if(listMoves[6] == symbol) {
                if(listMoves[0] == "0") {
                    setXO(0, location: 0)
                    return true
                }
            }
            if(listMoves[4] == symbol) {
                if(listMoves[5] == "5") {
                    setXO(0, location: 5)
                    return true
                }
            }
            if(listMoves[5] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
        }
        if(listMoves[4] == symbol) {
            if(listMoves[0] == symbol) {
                if(listMoves[8] == "8") {
                    setXO(0, location: 8)
                    return true
                }
            }
            if(listMoves[1] == symbol) {
                if(listMoves[7] == "7") {
                    setXO(0, location: 7)
                    return true
                }
            }
            if(listMoves[2] == symbol) {
                if(listMoves[6] == "6") {
                    setXO(0, location: 6)
                    return true
                }
            }
            if(listMoves[3] == symbol) {
                if(listMoves[5] == "5") {
                    setXO(0, location: 5)
                    return true
                }
            }
            if(listMoves[5] == symbol) {
                if(listMoves[3] == "3") {
                    setXO(0, location: 3)
                    return true
                }
            }
            if(listMoves[6] == symbol) {
                if(listMoves[2] == "2") {
                    setXO(0, location: 2)
                    return true
                }
            }
            if(listMoves[7] == symbol) {
                if(listMoves[1] == "1") {
                    setXO(0, location: 1)
                    return true
                }
            }
            if(listMoves[8] == symbol) {
                if(listMoves[0] == "0") {
                    setXO(0, location: 0)
                    return true
                }
            }
        }
        if(listMoves[5] == symbol) {
            if(listMoves[2] == symbol) {
                if(listMoves[8] == "8") {
                    setXO(0, location: 8)
                    return true
                }
            }
            if(listMoves[8] == symbol) {
                if(listMoves[2] == "2") {
                    setXO(0, location: 2)
                    return true
                }
            }
            if(listMoves[4] == symbol) {
                if(listMoves[3] == "3") {
                    setXO(0, location: 3)
                    return true
                }
            }
            if(listMoves[3] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
        }
        if(listMoves[6] == symbol) {
            if(listMoves[3] == symbol) {
                if(listMoves[0] == "0") {
                    setXO(0, location: 0)
                    return true
                }
            }
            if(listMoves[0] == symbol) {
                if(listMoves[3] == "3") {
                    setXO(0, location: 3)
                    return true
                }
            }
            if(listMoves[4] == symbol) {
                if(listMoves[2] == "2") {
                    setXO(0, location: 2)
                    return true
                }
            }
            if(listMoves[2] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
            if(listMoves[7] == symbol) {
                if(listMoves[8] == "8") {
                    setXO(0, location: 8)
                    return true
                }
            }
            if(listMoves[8] == symbol) {
                if(listMoves[7] == "7") {
                    setXO(0, location: 7)
                    return true
                }
            }
        }
        if(listMoves[7] == symbol) {
            if(listMoves[6] == symbol) {
                if(listMoves[8] == "8") {
                    setXO(0, location: 8)
                    return true
                }
            }
            if(listMoves[8] == symbol) {
                if(listMoves[6] == "6") {
                    setXO(0, location: 6)
                    return true
                }
            }
            if(listMoves[4] == symbol) {
                if(listMoves[1] == "1") {
                    setXO(0, location: 1)
                    return true
                }
            }
            if(listMoves[1] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
        }
        if(listMoves[8] == symbol) {
            if(listMoves[4] == symbol) {
                if(listMoves[0] == "0") {
                    setXO(0, location: 0)
                    return true
                }
            }
            if(listMoves[0] == symbol) {
                if(listMoves[4] == "4") {
                    setXO(0, location: 4)
                    return true
                }
            }
            if(listMoves[5] == symbol) {
                if(listMoves[2] == "2") {
                    setXO(0, location: 2)
                    return true
                }
            }
            if(listMoves[2] == symbol) {
                if(listMoves[5] == "5") {
                    setXO(0, location: 5)
                    return true
                }
            }
            if(listMoves[7] == symbol) {
                if(listMoves[6] == "6") {
                    setXO(0, location: 6)
                    return true
                }
            }
            if(listMoves[6] == symbol) {
                if(listMoves[7] == "7") {
                    setXO(0, location: 7)
                    return true
                }
            }
        }
        return false
    }
    
    //Checks for a winner
    func checkWinner() -> String {
        var testNum = 0
        for number in listMoves {
            if Int(number) == testNum {
                testNum = -1
                break
            }
            testNum += 1
        }
        if testNum != -1 {
            return "draw"
        }
        if(listMoves[0] == listMoves[1] && listMoves[1] == listMoves[2] ||
            listMoves[0] == listMoves[4] && listMoves[4] == listMoves[8] ||
            listMoves[0] == listMoves[3] && listMoves[3] == listMoves[6]) {
            return listMoves[0]
        } else if (listMoves[3] == listMoves[4] && listMoves[4] == listMoves[5]) {
            return listMoves[3]
        } else if (listMoves[1] == listMoves[4] && listMoves[4] == listMoves[7]) {
            return listMoves[1]
        } else if (listMoves[2] == listMoves[5] && listMoves[5] == listMoves[8]) {
            return listMoves[2]
        } else if (listMoves[6] == listMoves[7] && listMoves[7] == listMoves[8] ||
            listMoves[6] == listMoves[4] && listMoves[4] == listMoves[2]) {
            return listMoves[6]
        } else {
            return ""
        }
    }
}
















































