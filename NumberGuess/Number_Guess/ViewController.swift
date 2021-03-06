//
//  ViewController.swift
//  NumberGuess
//
//  Created by Tikautz Gregor on 01.10.21.
//

import UIKit

class ViewController: UIViewController {
    var model = Model()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBAction func onTextFieldEditingChange(_ sender: UITextField) {
        guessButton.isEnabled = model.isValid(guess: sender.text)
    }
    
    @IBAction func newGame(_ sender: Any) {
        model.reset()
        print("Zu erratende Zahl: \(model.numberToGuess)")
    }
    
    
    
    
    @IBAction func button(_ sender: Any) {
        //TODO: check input for not nil
        let guessedNumber = Int(inputTextField.text!)!
        model.countOfTries += 1
        model.listOfTries.append(guessedNumber)
        
        
        let text: String?
        
        switch model.compare(guess: guessedNumber){
        case 1:
            text = "Die Zahl ist zu groß"
        case -1:
            text = "Die Zahl ist zu klein"
        default:
            text = "Congrats richtig erraten du hast \(model.countOfTries) Versuche gebraucht"
            model.generateNewNumber = true
        }
        
        label.text = text
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.numberToGuess = Int.random(in: 0..<100)
        print("Zu erratende Zahl: \(model.numberToGuess)")
        
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let guessedNumber = Int(inputTextField.text!)!
        return model.compare(guess: guessedNumber)  == 0 || identifier == "tries" ? true : false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as? DetailViewController
        detailViewController?.model = model
        
    }

    override func viewDidAppear(_:Bool){
        if(model.generateNewNumber){
            label.text = "Errate die Zahl"
            inputTextField.text = ""
            model.generateNewNumber = false
        }
    }

}

