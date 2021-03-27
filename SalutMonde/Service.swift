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
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: self.headers).response { (responseData) in
//            print(responseData.data as Any)
            switch responseData.result {
            case .success(let data):
                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
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
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: self.headers).response { (responseData) in

            switch responseData.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if responseData.response?.statusCode == 200 {
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
}
