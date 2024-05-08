//
//  ViewController.swift
//  Hangman-group11
//
//  Created by Anand Krishna Shiju on 2023-11-03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var hangSomeone: UILabel!
    @IBOutlet weak var displayWordLabel: UILabel!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var hangmanImage: UIImageView!
    
    var wordArray =  [
        "PIZZAZZ",
        "ZYZZYVA",
        "FUZZBOX",
        "PIZAZZY",
        "JACUZZI",
        "JAZZMAN",
        "JAZZMEN",
        "JAZZBOS",
        "JAZZILY",
        "JAZZING",
        "ZIZZING",
        "QUIZZED",
        "ZIZZLED",
        "QUIZZER",
        "QUIZZES",
        "WAZZOCK",
        "ZIZZLES",
        "BUZZWIG",
        "JAZZERS",
        "JAZZIER",
        "BUZZCUT",
        "MUZJIKS",
        "BUZZING",
        "BUZZSAW",
        "FUZZILY",
        "FUZZING",
        "MUZZILY",
        "SCHIZZY",
        "ABBOZZO",
        "CHAZZAN",
        "CHAZZEN",
        "FIZZILY",
        "FIZZING",
        "FRIZZLY",
        "JEJUNUM",
        "JIMJAMS",
        "JUKEBOX",
        "JUMBUCK",
        "MEZUZAH",
        "MUZZLED",
        "PUZZLED",
        "SCHNOZZ",
        "WAZZING",
        "WHIZZED",
        "ZHUZHED",
        "BUZZARD",
        "FIZZLED",
        "GRIZZLY",
        "GUZZLED",
        "HUZZAHS",
        "JUJUBES",
        "JUJUISM",
        "MIZZLED",
        "MUEZZIN",
        "MUZZLER",
        "MUZZLES",
        "PUZZLER",
        "PUZZLES",
        "WHIZZER",
        "WHIZZES",
        "ZHUZHES",
        "BEZIQUE",
        "BEZZANT",
        "BUZZERS",
        "BUZZIER"
        ]


    var word = ""
    var wrongLettersArray = [Character]()
    var usedLetters = [Character]()
    var displayWordArray = [Character]()
    var displayWord = ""
    var guess: Character?
    var totalWins = 0
    var totalLosses = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        word = wordArray.randomElement()!
        usedLetters = Array(word)
        displayWordArray = Array(repeating: "?", count: word.count)
        displayWord = String(displayWordArray)
        displayWordLabel.text = displayWord
    }
    
@IBAction func guessButton(_ sender: UIButton) {
    
    if let guess1 = sender.titleLabel?.text{
//        guessTextField.resignFirstResponder()
        
            if guess1.count == 1 {
                guess = Character(guess1.uppercased())
                checkForLetter()
                displayWord = String(displayWordArray)
                displayWordLabel.text = displayWord
//                guessTextField.text = ""
                checkForWin()
            } else {
//                guessTextField.placeholder = "Enter one letter"
            }
        } else {
//            guessTextField.placeholder = "Enter a letter"
        }
    
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        totalWins = 0
            totalLosses = 0
            winsLabel.text = "Wins: 0"
            lossesLabel.text = "Losses: 0"
        //guessTextField.text = ""
        hangmanImage.image = nil
        
        wrongLettersArray.removeAll()
        //wrongLetters.text = ""
        displayWordLabel.text = ""
        
        word = wordArray.randomElement()!
        usedLetters = Array(word)
        displayWordArray = Array(repeating: "?", count: word.count)
        displayWord = String(displayWordArray)
        displayWordLabel.text = displayWord
    }
    
    func checkForLetter() {
        if usedLetters.contains(guess!) {
            for (index, letter) in usedLetters.enumerated() {
                if guess == letter {
                    displayWordArray[index] = guess!
                }
            }
        } else {
            wrongLettersArray.append(guess!)
            //wrongLetters.text = String(wrongLettersArray)
            placeImage()
        }
    }
    
    func placeImage() {
        let imageNames = ["hang1", "hang2", "hang3", "hang4", "hang5", "hang6", "hang7"]
        if wrongLettersArray.count <= imageNames.count {
            hangmanImage.image = UIImage(named: imageNames[wrongLettersArray.count - 1])
        }
    }
    
    func checkForWin() {
        if wrongLettersArray.count == 7 {
            totalLosses += 1
            lossesLabel.text = "Losses:\(totalLosses)"
            showAlert(title: "Game Over", message: "You lost. The word was: \(word)")
            resetGame() // Reset the game
        } else if !displayWord.contains("?") {
            totalWins += 1
            winsLabel.text = "Wins:\(totalWins)"
            showAlert(title: "You Win", message: "Congratulations! You guessed the word.")
            resetGame() // Reset the game
        }
    }


    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.resetGame() // Reset the game after the alert is dismissed
        })
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    
    func resetGame() {
        word = wordArray.randomElement()!
        usedLetters = Array(word)
        displayWordArray = Array(repeating: "?", count: word.count)
        displayWord = String(displayWordArray)
        displayWordLabel.text = displayWord
        wrongLettersArray.removeAll()
        hangmanImage.image = nil
        //guessTextField.text = "" // Optionally clear the guess text field
    }

}
