//
//  IdRegisteViewController.swift
//  Mov
//
//  Created by Camilo on 6/10/20.
//  Copyright © 2020 Camilo. All rights reserved.
//

import UIKit

class IdRegisteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,  UITextFieldDelegate  {
    

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var idNumberTxt: UITextField!
    @IBOutlet weak var button: UIButton!
    var pickerData = ["C.C", "T.I", "C.E"]
    
    var nombres: String!
    var apellidos: String!
    var correo: String!
    var password: String!
    var typeId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.typeId = pickerData[row] as String
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.typeId = pickerData[row] as String
    }

    @IBAction func onClick(_ sender: Any) {
        
        if idNumberTxt.text!.isEmpty{
            let alert = UIAlertView()
                       alert.title = "Error"
                       alert.message = "El campo de número de identificación está vacío"
                       alert.addButton(withTitle: "Ok")
                       alert.show()
        }
        else {
            let storyboard = UIStoryboard (name: "Main", bundle: nil)
                             let resultVC = storyboard.instantiateViewController(withIdentifier: "phone")as! PhoneViewController
                resultVC.nombres = nombres
                resultVC.apellidos = apellidos
                resultVC.correo = correo
                resultVC.password = password
                resultVC.idNum = idNumberTxt.text!
                resultVC.typeId = self.typeId!
                
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
