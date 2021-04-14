//
//  ViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 26/03/21.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var tfContrasena: UITextField!
    var service: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfCorreo.text = ""
        self.service = Service(baseUrl: "http://127.0.0.1:3333/v1/auth/")
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        let correo : String = tfCorreo.text ?? ""
        let contrasena : String = tfContrasena.text ?? ""
        let parameters: [String: String] = [
            "email": correo,
            "password": contrasena
        ]
        
        self.service.login(endPoint: "login", parameters: parameters) { (isSuccess) in
            if isSuccess == true {
//                self.performSegue(withIdentifier: "logearse", sender: MenuViewController.self)
//                self.alertDefault(with: "Loggeado", andWithMsg: "Ha ingresado correctamente", completion: false)
                self.performSegue(withIdentifier: "segueGoToMenu", sender: ViewController.self)
            }
            else {
                self.alertDefault(with: "Campos no válidos", andWithMsg: "Verifique sus datos sean correctos", completion: false)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

