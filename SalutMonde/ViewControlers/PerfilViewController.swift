//
//  PerfilViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 05/04/21.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var lblCorreo: UILabel!
    var service: Service!
    var user = userInfo()
    var usuario: String!
    var correo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = Service(baseUrl: "http://127.0.0.1:3333/v1/api/profile/")
        self.service.getPerfil()
        self.service.completionHandlerP { (user, status, message) in
            if status {
                guard let _user = user else {return}
                self.user = _user
                self.lblUsuario.text = self.user.username
                self.lblCorreo.text = self.user.email
            }
        }
    }
    
    @IBAction func editBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "showEditar", sender: self)
    }
}
