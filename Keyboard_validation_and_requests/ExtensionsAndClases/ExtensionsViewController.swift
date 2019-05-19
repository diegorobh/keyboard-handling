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
    //Moving textFields on keyboard shows and hides
    //enviar viewContainer, activeField, Moved, IntroFields (Moved e IntroFields are inout vars defined in the viewController)
    func keyboardDidShow(notification:NSNotification, viewContainer:UIStackView, activeField:UITextField?, Moved: inout Bool, IntroFields: inout Bool) {
        if(activeField != nil){
            let additionalHeights = 0
            let heightTfldConstraint = 74 //teniendo en cuenta los espaciados
            let info = notification.userInfo
            let Keyboard:CGRect = info!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            let heightkeyboard = Keyboard.size.height
            let heightOfView:CGFloat = self.view.frame.size.height
            var heightTextField = activeField!.frame.maxY + CGFloat(heightTfldConstraint)
            //height in subview to use when tesxtfields are in some stack or view inside the viewContainer
            let heightTextFieldInSubView = activeField!.superview!.frame.maxY + CGFloat(heightTfldConstraint)
            let heightVisible = heightOfView - (heightkeyboard + CGFloat(additionalHeights))
            print("heightView = \(heightOfView), heightKeyboard = \(heightkeyboard), heightTextFieldInSubView = \(heightTextFieldInSubView), heightTextField = \(heightTextField), heightVisible = \(heightVisible)")
            
            if activeField!.superview! != viewContainer {
                //print("está en un stack view")
                heightTextField = heightTextFieldInSubView
            }
            
            if heightTextField > heightVisible {
                viewContainer.transform = CGAffineTransform(translationX: 0, y: -1*((heightTextField-heightVisible)+CGFloat(heightTfldConstraint)))
                Moved = true
            }
        }
    }
    func keyboardWillHide(notification:NSNotification, viewContainer:UIStackView, activeField:UITextField?, Moved: inout Bool, IntroFields: inout Bool) {
        if(activeField != nil){
            if((Moved && !IntroFields) || ((activeField?.tag)! == 8) ){
                viewContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                Moved = false
            }
            IntroFields = false
        }
    }
}


