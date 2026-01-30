//
//  ViewController.swift
//  lifecounter
//
//  Created by Christian James Dizon Correa on 1/29/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateLife()
        resultLabel.isHidden = true
    }

    var player1Life = 20
    var player2Life = 20
    
    @IBOutlet weak var player1LifeLabel: UILabel!
    
    @IBOutlet weak var player2LifeLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    func updateLife() {
        player1LifeLabel.text = "\(player1Life)"
        player2LifeLabel.text = "\(player2Life)"
        
        if player1Life <= 0 {
            resultLabel.text = "Player 1 LOSES!"
            resultLabel.isHidden = false
        } else if player2Life <= 0 {
            resultLabel.text = "Player 2 LOSES!"
            resultLabel.isHidden = false
        } else {
            resultLabel.isHidden = true
        }
    }
    
    @IBAction func p1plus(_ sender: UIButton) {
        player1Life += 1
        updateLife()
    }
    
    @IBAction func p1minus(_ sender: UIButton) {
        player1Life -= 1
        updateLife()
    }
    
    @IBAction func p1plusfive(_ sender: UIButton) {
        player1Life += 5
        updateLife()
    }
    
    @IBAction func p1minusfive(_ sender: UIButton) {
        player1Life -= 5
        updateLife()
    }
    
    @IBAction func p2plus(_ sender: UIButton) {
        player2Life += 1
        updateLife()
    }
    
    @IBAction func p2minus(_ sender: UIButton) {
        player2Life -= 1
        updateLife()
    }
    
    @IBAction func p2plusfive(_ sender: UIButton) {
        player2Life += 5
        updateLife()
    }
    
    @IBAction func p2minusfive(_ sender: UIButton) {
        player2Life -= 5
        updateLife()
    }
    
    
    
    
}

