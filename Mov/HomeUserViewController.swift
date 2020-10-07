//
//  HomeUserViewController.swift
//  Mov
//
//  Created by Camilo on 6/10/20.
//  Copyright © 2020 Camilo. All rights reserved.
//

import UIKit

class HomeUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tabla: UITableView!
    var establecimientos: [Establecimiento] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabla.delegate = self
        self.tabla.dataSource = self
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
                        print(json)
                        
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        
                        for res in result.data {
                            self.establecimientos.append(res)
                           DispatchQueue.main.async {
                            self.tabla.reloadData()
                            }
                            
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return establecimientos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EstablecimientoTableViewCell
        if establecimientos.count > 0 {
            
                cell.nameLbl?.text = self.establecimientos[indexPath.row].nombre
        }
        return cell
    }
    
    struct Response: Decodable {
        let code: Int
        let status: Int
        let data: [Establecimiento]
    }
    
    public struct Establecimiento: Decodable, Encodable {
        public var idasociado: String?
        public var nombre: String?
        public var razonsocial: String?
        public var status: String?
        public var ciudadestablecimiento: String?
        public var code: String?
        public var codigoEDS: String?
        public var color: String?
        public var direccion: String?
        public var fechaActualizacion: String?
        public var fechaCreacion: String?
        public var horario: String?
        public var idestablecimiento: String?
        public var imageurl: String?
        public var latitud: String?
        public var longitud: String?
        public var nit: String?
        public var splitReceivers: String?
        public var splitRule: String?
        public var tarifaMoto: String?
        public var tarifaVehiculo: String?
        public var telefono: String?
    }
    
}
