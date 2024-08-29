//
//  ViewController.swift
//  Apple Pie
//
//  Created by Mahmoud Alaa on 27/08/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var lettersBtn: [UIButton]!
    
    var listOfWords = ["buccaneer" ,"swift" ,"glorious" ,"incandescent" ,"bug" ,"program"]
    
    let incorrectMovesAllowed = 7
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound()
    }
    
    var currentGame: Game!
    
    func newRound(){
        
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableButtons(true)
            updateUI()
        }else{
            enableButtons(false)
        }
    }

    func updateUI(){
        
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        updateGameState()
        scoreLabel.text = "Wins: \(totalWins) ,Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func enableButtons(_ enable: Bool){
        for button in lettersBtn{
            button.isEnabled = enable
        }
        if !enable { correctWordLabel.text = "The game is end"}

    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
    }
    
    @IBAction func letterBtnPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
     
        currentGame.playerGuessed(letter: letter)
        updateUI()
    }
    
}

