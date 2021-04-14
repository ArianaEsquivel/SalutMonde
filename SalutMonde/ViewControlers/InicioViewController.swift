//
//  InicioViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 14/04/21.
//

import UIKit

class InicioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(verificar), userInfo: nil, repeats: false)
    }
    @objc func verificar(){
        if (App.shared.defaults.object(forKey: "Token") as! String == "") {
            self.performSegue(withIdentifier: "segueGoToInicio", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "segueGoMenu", sender: self)
        }
    }
}
