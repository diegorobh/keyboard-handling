//
//  KeyboardTools.swift
//  Keyboard_validation_and_requests
//
//  Created by Diego Paredes on 5/19/19.
//  Copyright © 2019 D-Fine. All rights reserved.
//

import Foundation
import UIKit

class KeyboardTools {
    
    var Moved: Bool = false
    var IntroFields: Bool = false
    var myViewController: UIViewController = UIViewController()
    var viewContainer:UIStackView = UIStackView()
    var activeField:UITextField? = UITextField()
    var maxTags:Int = Int()
    //Moving textFields on keyboard shows and hides
    //enviar viewContainer, activeField, Moved, IntroFields (Moved e IntroFields are inout vars defined in the viewController)
    func keyboardDidShow(notification:NSNotification) {
        if(activeField != nil){
            let additionalHeights = 0
            let heightTfldConstraint = 74 //teniendo en cuenta los espaciados
            let info = notification.userInfo
            let Keyboard:CGRect = info!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            let heightkeyboard = Keyboard.size.height
            let heightOfView:CGFloat = myViewController.view.frame.size.height
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
    func keyboardWillHide(notification:NSNotification) {
        if(activeField != nil){
            if((Moved && !IntroFields) || ((activeField?.tag)! == maxTags) ){
                viewContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                Moved = false
            }
            IntroFields = false
        }
    }
}
