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
//        updateLife()
        refreshUI()
        resultLabel.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        playersStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        playersStack.addArrangedSubview(addPlayerButton)

        for i in 0..<players.count {
            playersStack.addArrangedSubview(makePlayerRow(index: i))
        }

        playersStack.addArrangedSubview(resultLabel)
    }


    var history: [String] = []
//    var player1Life = 20
//    var player2Life = 20
    var players: [Int] = Array(repeating: 20, count: 4)
    var gameStarted = false
    
    @IBOutlet var amountFields: [UITextField]!
    
    
    @IBOutlet weak var addPlayerButton: UIButton!
    
    
    @IBOutlet weak var playersStack: UIStackView!
    
    @IBAction func addPlayerTapped(_ sender: UIButton) {
        guard players.count < 8 else {return}
        
        players.append(20)
        
        let newRow = makePlayerRow(index: players.count - 1)
        let insertIndex = playersStack.arrangedSubviews.count - 1
        playersStack.insertArrangedSubview(newRow, at: insertIndex)
        
        
    }
    
//    @IBOutlet weak var player1LifeLabel: UILabel!
////    
//    @IBOutlet weak var player2LifeLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
//    func updateLife() {
////        player1LifeLabel.text = "\(players[0])"
////        player2LifeLabel.text = "\(players[1])"
//        
//        if players.contains(where: {$0 <= 0}) {
//            let losingIndex = players.firstIndex(where: {$0 <= 0})!
//            resultLabel.text = "Player \(losingIndex + 1) LOSES!"
//            resultLabel.isHidden = false
//            
//            addPlayerButton.isEnabled = true
//            gameStarted = false
//        } else {
//            resultLabel.isHidden = true
//        }
//        
////        if players[0] <= 0 {
////            resultLabel.text = "Player 1 LOSES!"
////            resultLabel.isHidden = false
////        } else if players[1] <= 0 {
////            resultLabel.text = "Player 2 LOSES!"
////            resultLabel.isHidden = false
////        } else {
////            resultLabel.isHidden = true
////        }
//    }
    
    func gameStart() {
        if !gameStarted {
            gameStarted = true
            addPlayerButton.isEnabled = false
        }
    }
    
    func makePlayerRow(index: Int) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.alignment = .center
        
        let nameLabel = UILabel()
        nameLabel.text = "Player \(index + 1)"
        
        let lifeLabel = UILabel()
        lifeLabel.text = "\(players[index])"
        lifeLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        lifeLabel.tag = 100 + index
        
        let controls = UIStackView()
        controls.axis = .horizontal
        controls.spacing = 12
        
        let minus = UIButton(type: .system)
        minus.setTitle("-", for: .normal)
        minus.tag = index
        minus.addTarget(self, action: #selector(decreaseLife(_:)), for: .touchUpInside)
        
        let amount = UITextField()
        amount.placeholder = "amount"
        amount.text = "1"
        amount.keyboardType = .numberPad
        amount.textAlignment = .center
        amount.borderStyle = .roundedRect
        amount.widthAnchor.constraint(equalToConstant: 60).isActive = true
        amount.tag = 200 + index
        
        let plus = UIButton(type: .system)
        plus.setTitle("+", for: .normal)
        plus.tag = index
        plus.addTarget(self, action: #selector(increaseLife(_:)), for: .touchUpInside)
        
        controls.addArrangedSubview(minus)
        controls.addArrangedSubview(amount)
        controls.addArrangedSubview(plus)
        
        container.addArrangedSubview(nameLabel)
        container.addArrangedSubview(lifeLabel)
        container.addArrangedSubview(controls)
        
        return container
        
    }
    
//    func updateDynamicLifeLabels() {
//        for (i, life) in players.enumerated() {
//            if let label = playersStack.viewWithTag(100 + i) as? UILabel {
//                label.text = "\(life)"
//            }
//        }
//    }
    
    func refreshUI() {
        // update all life labels
        for (i, life) in players.enumerated() {
            if let label = playersStack.viewWithTag(100 + i) as? UILabel {
                label.text = "\(life)"
            }
        }

        // check game over
        if let losingIndex = players.firstIndex(where: { $0 <= 0 }) {
            resultLabel.text = "Player \(losingIndex + 1) LOSES!"
            resultLabel.isHidden = false
            addPlayerButton.isEnabled = true
            gameStarted = false
        } else {
            resultLabel.isHidden = true
        }
    }
    
    @objc func increaseLife(_ sender: UIButton) {
        let index = sender.tag
        let amount = getAmount(for: index)
        
        players[index] += amount
        history.append("Player \(index + 1) gained \(amount) life.")
        
        gameStart()
        refreshUI()
    }

    @objc func decreaseLife(_ sender: UIButton) {
        let index = sender.tag
        let amount = getAmount(for: index)
        
        players[index] -= amount
        history.append("Player \(index + 1) lost \(amount) life.")
        
        gameStart()
        refreshUI()
    }
    
    func getAmount(for index: Int) -> Int {
        if let field = playersStack.viewWithTag(200 + index) as? UITextField {
            return Int(field.text ?? "") ?? 1
        }
        return 1
    }
    
    func lifeChangeAmount(for playerIndex: Int) -> Int {
        let field  = amountFields.first { $0.tag == playerIndex}
        return Int(field?.text ?? "") ?? 1
    }
    
//    @IBAction func p1plus(_ sender: UIButton) {
//        players[0] += lifeChangeAmount(for: 0)
//        gameStart()
//        updateLife()
//    }
//    
//    @IBAction func p1minus(_ sender: UIButton) {
//        players[0] -= lifeChangeAmount(for: 0)
//        gameStart()
//        updateLife()
//    }
//    
//    
//    @IBAction func p2plus(_ sender: UIButton) {
//        players[1] += lifeChangeAmount(for: 1)
//        gameStart()
//        updateLife()
//    }
//    
//    @IBAction func p2minus(_ sender: UIButton) {
//        players[1] -= lifeChangeAmount(for: 1)
//        gameStart()
//        updateLife()
//    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory",
               let dest = segue.destination as? HistoryViewController {
                dest.history = history
        }
    }
    
}

