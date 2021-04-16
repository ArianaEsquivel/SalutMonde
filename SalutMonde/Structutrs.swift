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
    var id: Int?
    var username: String?
    var email: String?
    var created_at: String?
    var updated_at: String?
    var rol_id: Int?
}


struct listCamaras : Decodable{
    var cameras: [Camaras]?
}

struct Camaras : Decodable{
    var id: String?
    var code: String?
    var ip: String?
    var name: String?
    var user_id: String?
    var created_at: String?
    var updated_at: String?
}

struct Fotos : Decodable{
    var id: String?
    var route: String?
    var obj_type: String?
    var distance: String?
    var date_photo: String?
    var camera_id: String?
    var created_at: String?
    var updated_at: String?
}

struct listDatCam : Decodable{
    var id: String?
    var code: String?
    var ip: String?
    var name: String?
    var user_id: String?
    var created_at: String?
    var updated_at: String?
    var images : [Fotos]?
    var values : [Values]?
}

struct Values : Decodable{
    var id: String?
    var temperature: String?
    var humidity: String?
    var date_value: String?
    var camera_id: String?
    var created_at: String?
    var updated_at: String?
}

