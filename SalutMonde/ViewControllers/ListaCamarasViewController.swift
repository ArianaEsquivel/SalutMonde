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
    var codeImage : String!
    var nameImage : String!
    var ipImage : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblListaCamaras.delegate = self
        tblListaCamaras.dataSource = self
        self.service = Service()
        self.service.getListaCamara(endPoint: "api/camera/mycamera")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nameImage = listaCamaras.cameras?[indexPath.row].name
        self.codeImage = listaCamaras.cameras?[indexPath.row].code
        print(listaCamaras.cameras?[indexPath.row].code as Any)
        performSegue(withIdentifier: "goToCamaraOp", sender: self)
    }
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCamaraOp"{
            let cm = segue.destination as! CamarasMenuViewController
            cm.codeImage = self.codeImage
            cm.nameImage = self.nameImage
            cm.ipCam = self.ipImage
        }
    }
}


