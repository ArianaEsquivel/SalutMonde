//
//  Registro1ViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 27/03/21.
//

import UIKit

class Registro1ViewController: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfApPat: UITextField!
    @IBOutlet weak var tfApMat: UITextField!
    @IBOutlet weak var btnContinuar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "continuar" {
            let registro2 = segue.destination as! Registro2ViewController
            registro2.nombre = tfNombre.text ?? ""
            registro2.appa = tfNombre.text ?? ""
            registro2.apma = tfNombre.text ?? ""
            
        }
    }

}
