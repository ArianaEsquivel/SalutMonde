//
//  Structutrs.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 28/03/21.
//

import Foundation

struct errorsSignUp : Decodable{
    var title: String
    var detail: String
    var source: [String: String]
}

struct loginResponse : Decodable{
    var login: loginInfo
}

struct loginInfo : Decodable{
    var token: tokenInfo
    var user: userInfo
}

struct tokenInfo : Decodable{
    var type: String
    var token: String
    var refreshToken: String
}

struct userInfo : Decodable{
    var id: Int
    var first_name: String
    var last_name: String
    var second_last_name: String
    var username: String
    var email: String
    var created_at: String
    var updated_at: String
    var rol_id: Int
}
