//
//  ActividadViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 15/04/21.
//

import UIKit

class ValoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tblValores: UITableView!
    
    var service: Service!
    var listaValores = listDatCam()
    var codeImage : String!
    var nameImage : String!

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = self.nameImage
        
        tblValores.delegate = self
        tblValores.dataSource = self
        
        self.service = Service()
        self.service.getListDatCam(endPoint: "api/camera/\(codeImage ?? "")")
        self.service.completionHandlerDC { (listaValores, status, message) in
            if status {
                guard let _listaValores = listaValores else {return}
                self.listaValores = _listaValores
                self.tblValores.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaValores.values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaValores") as! ValoresTableViewCell
        cell.lblFecha.text = listaValores.values![indexPath.row].date_value
        cell.lblTemperatura.text = listaValores.values![indexPath.row].temperature
        cell.lblHumedad.text = listaValores.values![indexPath.row].humidity
        return cell
    }

}
