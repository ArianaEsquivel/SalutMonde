//
//  Device.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 14/04/21.
//

import UIKit

class Device: Decodable{
    var code:String = ""
    var name:String = ""
    
    internal init(code: String = "", name: String = "") {
        self.code = code
        self.name = name
    }
}
