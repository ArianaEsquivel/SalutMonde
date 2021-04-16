//
//  Device.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 14/04/21.
//

import UIKit

class Device: Decodable{
    var device:String = ""
    var id:String
    var token:String = ""
    
    internal init(device: String = "", id: String, token: String = "") {
        self.device = device
        self.id = id
        self.token = token
    }
}
