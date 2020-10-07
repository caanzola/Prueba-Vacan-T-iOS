//
//  HomeUserViewController.swift
//  Mov
//
//  Created by Camilo on 6/10/20.
//  Copyright © 2020 Camilo. All rights reserved.
//

import UIKit

class HomeUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let Url = String(format: "https://apiprueba.gopass.com.co/establishment/getAllEstablishment")
            guard let serviceUrl = URL(string: Url) else { return }
            
        
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "GET"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            
            request.timeoutInterval = 10
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        print("*********************")
                        print(result)
                        
                    } catch {
                        print(error)
                    }
                }
            }.resume()
    }
    
    struct Response: Decodable {
        let code: Int
        let return_: String
        let status: String
        let data: [Establecimiento]
    }
    
    public struct Establecimiento: Decodable, Encodable {
        public var idasociado: String?
        public var nombre: String?
        public var razonsocial: String?
        public var status: String?
    }
    
}
