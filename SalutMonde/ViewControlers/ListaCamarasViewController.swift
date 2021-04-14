//
//  ListaCamarasViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 05/04/21.
//

import UIKit

class ListaCamarasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblListaCamaras: UITableView!
    var service: Service!
    var listaCamaras = listCamaras()
    override func viewDidLoad() {
        super.viewDidLoad()

        tblListaCamaras.delegate = self
        tblListaCamaras.dataSource = self
        self.service = Service(baseUrl: "http://127.0.0.1:3333/v1/api/camera/")
        self.service.getListaCamara(endPoint: "mycamera")
        self.service.completionHandler { (listaCamaras, status, message) in
            if status {
                guard let _listaCamaras = listaCamaras else {return}
                self.listaCamaras = _listaCamaras
                self.tblListaCamaras.reloadData()
            }
        }
    }
    
    @IBAction func btnAnadir(_ sender: Any) {
        self.performSegue(withIdentifier: "showAgregardList", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCamaras.cameras?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaListaCamaras") as! ListaCamarasTableViewCell
        cell.lblNombre.text = listaCamaras.cameras?[indexPath.row].name
        return cell
    }
}


