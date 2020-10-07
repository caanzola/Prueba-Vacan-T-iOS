//
//  PhoneViewController.swift
//  Mov
//
//  Created by Camilo on 6/10/20.
//  Copyright © 2020 Camilo. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var phoneTxt: UITextField!
    var nombres: String!
    var apellidos: String!
    var correo: String!
    var password: String!
    var idNum: String!
    var typeId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }

    @IBAction func onClick(_ sender: Any) {
        if phoneTxt.text!.isEmpty{
            let alert = UIAlertView()
                                  alert.title = "Error"
                                  alert.message = "El campo de número de celular está vacío"
                                  alert.addButton(withTitle: "Ok")
                                  alert.show()
        }
        else{
            let Url = String(format: "https://apiprueba.gopass.com.co/client/registre")
                    guard let serviceUrl = URL(string: Url) else { return }
                    let parameters: [String: Any] = [
                        "request": [
                                "nombres" : nombres,
                                "apellidos": apellidos ,
                                "correo": correo ,
                                "password": password ,
                                "numeroIdentificacion": idNum ,
                                "tipoDocumento": typeId ,
                                "telefonoMovil": phoneTxt.text,
                        ]
                    ]
                
                print(parameters)
                    var request = URLRequest(url: serviceUrl)
                    request.httpMethod = "POST"
                    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                        return
                    }
                    request.httpBody = httpBody
                    request.timeoutInterval = 10
                    let session = URLSession.shared
                    session.dataTask(with: request) { (data, response, error) in
                        if let response = response {
                            print(response)
                        }
                        if let data = data {
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                                print(json)
                            } catch {
                                print(error)
                            }
                        }
                    }.resume()
            
                let storyboard = UIStoryboard (name: "Main", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: "home")as! HomeUserViewController
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
