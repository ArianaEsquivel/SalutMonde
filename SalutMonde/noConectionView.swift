//
//  noConectionView.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 16/04/21.
//

import UIKit

class noConectionView: UIView {

    var lblTitulo : UILabel?
    
    func build() -> UIView {
        self.lblTitulo = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.lblTitulo?.textColor = .black
        self.lblTitulo?.textAlignment = .center
        self.lblTitulo?.font = UIFont(name: "Arial", size: 38)
        self.lblTitulo?.center = center
        self.lblTitulo?.text = "No hay internet"
        self.backgroundColor = .white
        return self
    }

}
