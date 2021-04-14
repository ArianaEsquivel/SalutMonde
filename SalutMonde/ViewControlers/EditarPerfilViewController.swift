//
//  EditarPerfilViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 14/04/21.
//

import UIKit

class EditarPerfilViewController: UIViewController {

    @IBOutlet weak var tfUsuario: UITextField!
    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var btnGuardar: UIButton!
    
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
                self.tfUsuario.text = self.user.username
                self.tfCorreo.text = self.user.email
            }
        }
    }
    @IBAction func guardar(_ sender: Any) {
        let usuario : String = tfUsuario.text ?? ""
        let correo : String = tfCorreo.text ?? ""
        let parameters: [String: String] = [
            "username": usuario,
            "email": correo
        ]
        
        self.service.editPerfil(endPoint: "edit", parameters: parameters) { (isSuccess) in
            if isSuccess == true {
                self.navigationController?.popViewController(animated: true)
//                self.alertDefault(with: "Perfil editado", andWithMsg: "Cambios guardados con exito", completion: false)
            }
            else {
                self.alertDefault(with: "Campos no válidos", andWithMsg: "Verifique sus datos no sean igual que antes de editarlo", completion: false)
            }
        }
    }
    
}


