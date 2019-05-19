//
//  ExtensionsViewController.swift
//  Keyboard_validation_and_requests
//
//  Created by Diego Paredes on 5/18/19.
//  Copyright © 2019 D-Fine. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //HIDE KEYBOARD TOUCHING OUTSIDE
    //Use this function inside the viewDidLoad
    func hideKeyboardOnTouch(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func DismissKeyboard(){
        self.view.endEditing(true)
    }
    //GOING TO THE NEXT TAG
    //Use this function inside the textFieldShouldReturn
    func goToNextTextField(textFieldArg: UITextField) {
        OperationQueue.main.addOperation {
            textFieldArg.endEditing(true) //probably unnecessary
            let nextTag = textFieldArg.tag + 1
            if let nextResponder = textFieldArg.superview?.viewWithTag(nextTag) {
                nextResponder.becomeFirstResponder()
            }else{
                textFieldArg.resignFirstResponder()
            }
        }
    }
    
}


