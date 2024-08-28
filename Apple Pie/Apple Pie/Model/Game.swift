//
//  Game.swift
//  Apple Pie
//
//  Created by Mahmoud Alaa on 28/08/2024.
//

import Foundation

struct Game{
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed (letter: Character){
        guessedLetters.append(letter)
        
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
        
    }
    
    var formattedWord: String{
        
        var guessedString = ""
        for letter in word {
            if guessedLetters.contains(letter){
                guessedString.append(letter)
            }else{
                guessedString.append("_")
            }
        }
        
        return guessedString
    }
    
}
