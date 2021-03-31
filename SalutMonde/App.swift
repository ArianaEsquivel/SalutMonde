//
//  App.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 28/03/21.
//

import UIKit

class App: NSObject {
    static let shared = App()
    let defaults = UserDefaults.standard
    var Token: String!
    var Typee: String!
    var RefreshToken: String!
}
