//
//  ViewController.swift
//  Array
//
//  Created by Mark Meretzky on 1/8/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import UIKit;

class ViewController: UIViewController {
    
    //how many times has the UITextField's return key been pressed?
    var presses: Int = 0;
    
    var numbers: [Int] = [Int]();   //start with the array empty.
    var count: Int = 0;           //how many numbers will be stored in the array
    
    @IBOutlet weak var topLabel: UILabel!;
    @IBOutlet weak var textField: UITextField!;
    @IBOutlet weak var barchartLabel: UILabel!;
    
    //The error message and the button you press to dismiss it.
    @IBOutlet weak var errorLabel: UILabel!;
    @IBOutlet weak var okButton: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Called when the user presses the UITextField's return key.

    @IBAction func textField(_ sender: UITextField) {
        sender.resignFirstResponder();   //Dismiss kbd. Postpone till all numbers are in?
        let i: Int = Int(sender.text!)!; //Get the number the user typed.
        
        if presses == 0 {
            //The user just typed the number of numbers.
            if i < 0 || i > 10 {
                errorLabel.text = "Must have 0 to 10 numbers.";
                errorLabel.isHidden = false;
                okButton.isHidden = false;
                return;
            }
            count = i;
        } else {
            //The user just typed one of the numbers in the array.
            if i <= 0 || i > 1000 {
                errorLabel.text = "Each number must be in range 0 to 1000.";
                errorLabel.isHidden = false;
                okButton.isHidden = false;
                return;
            }
            numbers.append(i);
        }
        
        presses += 1;

        if presses <= count {
            //Invite the user to type another number.
            sender.placeholder = "Please type number \(presses)";
            sender.text = nil;   //Make the placeholder visible.
        } else {
            //All the numbers have been typed in.
            sender.isEnabled = false;
            sender.placeholder = nil;
            sender.text = nil;
            processTheArray();
        }
    }
    
    //Called when the user taps the UITextField.
    //Previous sins (if any) are forgotten.
    
    @IBAction func editingDidBegin(_ sender: UITextField) {
        errorLabel.isHidden = true;
        okButton.isHidden = true;
    }

    //Called when OK button is pressed.
    //Previous sins are forgotten.
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        errorLabel.isHidden = true;
        okButton.isHidden = true;
        textField.text = nil;
    }
    
    func processTheArray() {
        print(numbers);
        if numbers.isEmpty {
            topLabel.text = "An empty list has no min or max.";
        } else {
            topLabel.text = "minimum = \(numbers.min()!), maximum = \(numbers.max()!)";
        }
        
        for number in numbers {
            barchartLabel.text! += String(format: "%4d ", number);
            barchartLabel.text! += String(repeating: "*", count: number / 100);
            barchartLabel.text! += "\n";
        }
        
        barchartLabel.isHidden = false;
    }
}

