//
//  ViewController.swift
//  Mov
//
//  Created by Camilo on 9/8/19.
//  Copyright © 2019 Camilo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    /*
     Continue button
     */
    @IBOutlet weak var buton: UIButton!
    
    /*
    Text field for names
    */
    @IBOutlet weak var nombresTxt: UITextField!
    
    /*
    Text field for last names
    */
    @IBOutlet weak var apellidosTxt: UITextField!
    
    /*
    Text field for email
    */
    @IBOutlet weak var correoTxt: UITextField!
    
    /*
    Text field for password
    */
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buton.layer.cornerRadius = 20
        buton.clipsToBounds = true
    }

    @IBAction func onClick(_ sender: Any) {
        
        if nombresTxt.text!.isEmpty {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "El campo de nombres está vacío"
            alert.addButton(withTitle: "Ok")
            alert.show()
        }
        else if apellidosTxt.text!.isEmpty {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "El campo de apellidos está vacío"
            alert.addButton(withTitle: "Ok")
            alert.show()
        }
        else if correoTxt.text!.isEmpty {
            let alert = UIAlertView()
                       alert.title = "Error"
                       alert.message = "El campo de correo está vacío"
                       alert.addButton(withTitle: "Ok")
                       alert.show()
        }
        else if passwordTxt.text!.isEmpty {
            let alert = UIAlertView()
                       alert.title = "Error"
                       alert.message = "El campo de contraseña está vacío"
                       alert.addButton(withTitle: "Ok")
                       alert.show()
        }
        else{
            let storyboard = UIStoryboard (name: "Main", bundle: nil)
            let resultVC = storyboard.instantiateViewController(withIdentifier: "idRegister")as! IdRegisteViewController
            resultVC.nombres = nombresTxt.text!
            resultVC.apellidos = apellidosTxt.text!
            resultVC.correo = correoTxt.text!
            resultVC.password = passwordTxt.text!
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
       }
       
       func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
       view.resignFirstResponder()
           return true
       }

}

