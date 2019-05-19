//
//  handlingKeyboardViewController.swift
//  Keyboard_validation_and_requests
//
//  Created by Diego Paredes on 5/18/19.
//  Copyright © 2019 D-Fine. All rights reserved.
//

import UIKit

class handlingKeyboardViewController: UIViewController, UITextFieldDelegate {

    //******************LAYOUT ELEMENTS*******************
    @IBOutlet weak var fullNameTfd: UITextField!
    @IBOutlet weak var phoneTfd: UITextField!
    @IBOutlet weak var dateTfd: UITextField!
    @IBOutlet weak var addressTfd: UITextField!
    @IBOutlet weak var zipCodeTfd: UITextField!
    @IBOutlet weak var viewContainer: UIStackView!
    @IBOutlet weak var cincoTfd: UITextField!
    @IBOutlet weak var seisTfld: UITextField!
    @IBOutlet weak var sieteTfld: UITextField!
    @IBOutlet weak var ochoTfd: UITextField!
    //******************END LAYOUT ELEMENTS*******************
    //******************SCOPE VARS****************************
     weak var activeField: UITextField?
    var Moved: Bool = false
    var IntroFields: Bool = false
    //******************END SCOPE VARS****************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTouch()
        let center: NotificationCenter = NotificationCenter.default;
        
        center.addObserver(self, selector:#selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object:nil)
        center.addObserver(self, selector:#selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object:nil)

    }
    //******************KEYBOARD HANDLING*********************
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    @objc func keyboardDidShow(notification:NSNotification) {
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
                self.Moved = true
            }
        }
    }
    @objc func keyboardWillHide(notification:NSNotification    ) {
        if(activeField != nil){
            if((Moved && !IntroFields) || ((activeField?.tag)! == 8) ){
                viewContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                self.Moved = false
            }
            self.IntroFields = false
        }
    }
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String){
        let _:CGFloat = textField.frame.maxY
    }

    //******************KEYBOARD HANDLING*********************
    //******************ACTIONS*************************
    @IBAction func acceptBtn(_ sender: Any) {
    }
    //******************END ACTIONS*************************

}
