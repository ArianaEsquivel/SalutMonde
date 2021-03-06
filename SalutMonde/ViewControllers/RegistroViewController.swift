//
//  Registro2ViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 27/03/21.
//

import UIKit
import Alamofire

class RegistroViewController: UIViewController {
    
    @IBOutlet weak var tfUsuario: UITextField!
    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var tfContrasena: UITextField!
    @IBOutlet weak var tfConfirmContrasena: UITextField!
    @IBOutlet weak var btnRegistrarse: UIButton!


    var service: Service!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.service = Service()
    }
    
    @IBAction func registrar(_ sender: Any) {
        let usuario : String = tfUsuario.text ?? ""
        let correo : String = tfCorreo.text ?? ""
        let contrasena : String = tfContrasena.text ?? ""
        let confirmContrasena : String = tfConfirmContrasena.text ?? ""
        let parameters: [String: String] = [
            "username": usuario,
            "email": correo,
            "password": contrasena
        ]
        if contrasena != "" && confirmContrasena != "" && contrasena == confirmContrasena {
            self.service.registrar(endPoint: "auth/signup", parameters: parameters) { (isSuccess) in
                if isSuccess {
//                    self.performSegue(withIdentifier: "iniciar", sender: ViewController.self)
                    self.alertDefault(with: "Registrado", andWithMsg: "Ha sido registrado exitosamente", completion: true)
                }
                else {
                    self.alertDefault(with: "Algo salió mal", andWithMsg: "Verifique que su user y email no haya sido registrado antes", completion: false)
                }

            }
        }
        else {
            self.alertDefault(with: "Contraseña incorrecta", andWithMsg: "Verifique que la contraseña sea la misma en ambos campos", completion: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.performSegue(withIdentifier: "iniciar", sender: ViewController.self)
        if segue.identifier == "iniciar"{
            _ = segue.destination as! ViewController
//            iniciar.tfCorreo.text = self.tfCorreo.text
//            iniciar.tfCorreo.text!.append(self.tfCorreo.text!)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func ocultarTeclado(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}
extension UIViewController{
    func alertDefault(with title:String, andWithMsg description:String, completion: Bool){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        if completion == true {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: { self.dismiss(animated: true, completion: nil) } )}))
        }
        else {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: nil)}))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}
