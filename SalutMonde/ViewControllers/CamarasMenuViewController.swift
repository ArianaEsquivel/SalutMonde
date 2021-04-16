//
//  CamarasMenuViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 15/04/21.
//

import UIKit

class CamarasMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblMenuCam: UITableView!
    
    var opMenuCam = ["Transmisión de video", "Fotos de la cámara", "Registro de actividad"]
    var seguesCam =  ["showTransmision", "showFotosCamara", "showActividad"]
    var codeImage : String!
    var nameImage : String!
    var ipCam : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuCam.delegate = self
        tblMenuCam.dataSource = self
        
        self.navigationItem.title = self.nameImage
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return opMenuCam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaCamaraOp") as! CamarasMenuTableViewCell
        cell.lblCamaraMenu.text = opMenuCam[indexPath.row]
        print(opMenuCam[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: seguesCam[indexPath.row], sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTransmision":
            let tra = segue.destination as! TransmisionViewController
            tra.nameImage = self.nameImage
            tra.ipCam = self.ipCam
        case "showFotosCamara":
            let foto = segue.destination as! FotosViewController
            foto.codeImg = self.codeImage
            foto.nameImg = self.nameImage
        case "showActividad":
            let act = segue.destination as! ValoresViewController
            act.codeImage = self.codeImage
            act.nameImage = self.nameImage
        default:
            print("Opcion no válida")
        }
    }
}
