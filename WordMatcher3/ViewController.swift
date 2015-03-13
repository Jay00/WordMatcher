//
//  ViewController.swift
//  WordMatcher
//
//  Created by Jason Clark on 3/7/15.
//  Copyright (c) 2015 Jason Clark. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate, UITextFieldDelegate {
    
    var coreDataStack: CoreDataStack!
    var fetchedResultsController: NSFetchedResultsController!
    
    let tallLetters = "bdfhklt"
    let shortLetters = "aceimnorsuvwx"
    let hangLetters = "gjpqy"
    
    
    
    var words: [String] = []
    //var num = 0
    var regExpression: String!
    
    
    
    //
    //var arrayOfWWords =
    
    
    @IBOutlet weak var enterField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    
    
    @IBAction func findMatchPressed(sender: UIButton) {
        // match = test
        findMatch()

        //var regex = NSRegularExpression(pattern: searchString, options: nil, error: nil)
        
        return
    } //END FUNCTION FIND MATCH BUTTON PRESSED
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("Prepare for Segue Called")
        let nextController = segue.destinationViewController as ResultsViewController
        nextController.coreDataStack = coreDataStack
        //nextController.num = num
        nextController.userInput = enterField.text
        nextController.regExpression = regExpression
        println("Exiting Prepared for Segue")
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true) // Dismisses the keyboard if tap is outside of a field
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("TextFieldShould Return Called")
        textField.resignFirstResponder()
        findMatch()
        performSegueWithIdentifier("mySegue", sender: nil)
        return true
    }
    
    
    func findMatch()->() {
    var userInput = enterField.text
    //num = userInput.utf16Count as Int
    
    
    var searchString: String = ""
    var string: String = ""
    
    var numArray: [String] = []
        
    for letter in userInput {
    
        switch letter {
        case "b", "d", "f", "h", "k", "l", "t":
        println("\(letter) is tall")
        string = "[\(tallLetters)]"
        numArray.append(string)
        
        case "a", "c", "e", "i", "m", "n", "o", "r", "s", "u", "v", "w", "x", "z" :
        println("\(letter) is short")
        string = "[\(shortLetters)]"
        numArray.append(string)
        case "g", "j", "p", "q", "y":
        println("\(letter) is a hanger")
        string = "[\(hangLetters)]"
        numArray.append(string)
        default:
        println("\(letter) is not a letter")
        }
    
    searchString = searchString + string
        
    }
    
    
    println("The regex expresssion is = \(searchString)")
    
    regExpression = searchString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

