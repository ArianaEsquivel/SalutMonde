//
//  MenuTableViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 05/04/21.
//

import UIKit


var optionsMenu = ["Perfil", "Lista de cámaras", "Agregar cámara"]
var seguesMenu =  ["showPerfil", "showListaCamaras", "showAgregarCamara"]
class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return optionsMenu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaMenu") as! MenuTableViewCell
        cell.menuLbl.text = optionsMenu[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: seguesMenu[indexPath.row], sender: self)
//        print(indexPath.row)
    }
    
    
    @IBAction func btnSalir(_ sender: Any) {
        App.shared.defaults.setValue("", forKey: "Token")
        App.shared.defaults.setValue("", forKey: "Typee")
        App.shared.defaults.setValue("", forKey: "RefreshToken")
        self.performSegue(withIdentifier: "segueSalir", sender: self)
    }

}
