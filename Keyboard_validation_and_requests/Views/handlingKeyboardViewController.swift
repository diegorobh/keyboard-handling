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
    @IBOutlet weak var nueveTfd: UITextField!
    //******************END LAYOUT ELEMENTS*******************
    //******************SCOPE VARS****************************
    var keyboardTools = KeyboardTools()
     //weak var activeField: UITextField?
    //var Moved: Bool = false
    //var IntroFields: Bool = false
    //******************END SCOPE VARS****************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTouch()
        let center: NotificationCenter = NotificationCenter.default;
        keyboardTools.myViewController = self
        keyboardTools.viewContainer = self.viewContainer
        keyboardTools.maxTags = 9
        
        center.addObserver(self, selector:#selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object:nil)
        center.addObserver(self, selector:#selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object:nil)

    }
    //******************KEYBOARD HANDLING*********************
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardTools.activeField = textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.goToNextTextField(textFieldArg: textField)
        return true
    }
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String){
        let _:CGFloat = textField.frame.maxY
    }
    @objc func keyboardDidShow(notification:NSNotification) {
        keyboardTools.keyboardDidShow(notification: notification)
    }
    @objc func keyboardWillHide(notification:NSNotification) {
        keyboardTools.keyboardWillHide(notification: notification)
    }
    //******************KEYBOARD HANDLING*********************
    //******************ACTIONS*************************
    @IBAction func acceptBtn(_ sender: Any) {
    }
    //******************END ACTIONS*************************

}
