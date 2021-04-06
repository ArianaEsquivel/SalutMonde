//
//  Service.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 27/03/21.
//

import Foundation
import Alamofire

class Service {
    fileprivate var baseUrl = ""
    var headers : HTTPHeaders!
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        self.headers = [
            .contentType("application/json")]
    }
    
    func registrar(endPoint: String, parameters: [String: String], completionHandler: @escaping (Bool)-> ()) {
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: self.headers).responseJSON { (responseData) in
//            print(responseData.data as Any)
            switch responseData.result {
            case .success(let data):
                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                    guard let jsonRespons = (json as AnyObject) as? [String:Any] else {return}
                    guard let jsonResponse = responseData.value as? [String:Any] else { return }
                    print(jsonResponse)
                    let errors = jsonResponse.values  //["errors"] as? [Dictionary<String, Any>]
//                    let detail = errors as? [String: Any]
                    print(errors, "errors")
//                    let source = errors["source"] as? [String:Any]
//                    print(source)
//                    let pointer = errors["pointer"] as? [String:Any]
//                    print(pointer)
                    if responseData.response?.statusCode == 201 {
                        completionHandler(true)
                    }
                    else {
                        completionHandler(false)
                    }
                } catch {
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func login(endPoint: String, parameters: [String: String], completionHandler: @escaping (Bool)-> ()) {
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: self.headers).responseJSON { (responseData) in
            switch responseData.result {
            case .success(let data):
                do {
                    print(data)
                    //Cambiar a .response nada mas
//                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                    print(json)
//                    let decodedData = try? JSONDecoder().decode(loginInfo.self, from: data!)
//                    print(decodedData)
                    
                    if responseData.response?.statusCode == 200 {
                        guard let jsonResponse = responseData.value as? [String:Any] else { return }
                        print(jsonResponse, "jsonResponse")
                        let tokenInfo = jsonResponse["token"] as? [String:Any]
                        let type = tokenInfo?["type"] as? String ?? ""
                        let token = tokenInfo?["token"] as? String ?? ""
                        let refreshToken = tokenInfo?["refreshToken"] as? String ?? ""
                        print(tokenInfo, "tokenInfo")
//                        print(type)
//                        print(token)
//                        print(refreshToken)
                        if token != "" {
                            App.shared.Token = token
                            App.shared.Typee = type
                            App.shared.RefreshToken = refreshToken
                            print(App.shared.Token ?? "")
                        }
                        completionHandler(true)
                    }
                    else {
                        completionHandler(false)
                    }
                }
//                catch {
//                    print(error.localizedDescription)
//                    completionHandler(false)
//                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false)
            }
        }
    }
}
