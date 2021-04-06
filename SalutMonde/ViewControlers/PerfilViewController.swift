//
//  PerfilViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 05/04/21.
//

import UIKit

class PerfilViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "showEditar", sender: self)
    }
    
}
