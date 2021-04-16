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
    var headersToken : HTTPHeaders!
    typealias camarasCallBack = (_ camaras: listCamaras?, _ status: Bool, _ message: String) -> Void
    var callBack: camarasCallBack?
    typealias datCamCallBack = (_ datCam: listDatCam?, _ status: Bool, _ message: String) -> Void
    var callBackDC: datCamCallBack?
    typealias perfilCallBack = (_ user: userInfo?, _ status: Bool, _ message: String) -> Void
    var pCallBack: perfilCallBack?
    
    init() {
        self.baseUrl = "http://127.0.0.1:3333/v1/"
        self.headers = [
            .contentType("application/json")]
//        self.headersToken = [
//            .contentType("application/json"),
//            .authorization(bearerToken: App.shared.Token)]
    }
    
    func registrar(endPoint: String, parameters: [String: String], completionHandler: @escaping (Bool)-> ()) {
        AF.request(self.baseUrl + endPoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: self.headers).responseJSON { (responseData) in
//            print(responseData.data as Any)
            switch responseData.result {
            case .success(_): //poner let data
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
                        print("tokenInfo")
//                        print(type)
//                        print(token)
//                        print(refreshToken)
                        if token != "" {
                            App.shared.defaults.setValue(token, forKey: "Token")
                            App.shared.defaults.setValue(type, forKey: "Typee")
                            App.shared.defaults.setValue(refreshToken, forKey: "RefreshToken")
                            print(App.shared.defaults.object(forKey: "Token") as! String)
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
    
    func getListaCamara (endPoint: String){
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: [.contentType("application/json"), .authorization(bearerToken: App.shared.defaults.object(forKey: "Token") as! String)], interceptor: nil).response {
            (responseData) in
                        guard let data = responseData.data else { return }
                        do {
                            let camaras = try JSONDecoder().decode(listCamaras.self, from: data)
//                            print(camaras.cameras)
                            self.callBack?(camaras, true, "")
                        } catch {
                            print(error)
                            self.callBack?(nil, false, error.localizedDescription)
                        }

                    }
    }
    
    func completionHandler(callBack: @escaping camarasCallBack){
        self.callBack = callBack
    }
    
    func getPerfil (endPoint: String){
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: [.contentType("application/json"), .authorization(bearerToken: App.shared.defaults.object(forKey: "Token") as! String)], interceptor: nil).response {
            (responseData) in
                        guard let data = responseData.data else { return }
                        do {
                            let perfil = try JSONDecoder().decode(userInfo.self, from: data)
                            print(perfil)
                            self.pCallBack?(perfil, true, "")
                        } catch {
                            print(error)
                            self.pCallBack?(nil, false, error.localizedDescription)
                        }

                    }
    }
    
    func completionHandlerP(callBack: @escaping perfilCallBack){
        self.pCallBack = callBack
    }
    
    func editPerfil(endPoint: String, parameters: [String: String], completionHandler: @escaping (Bool)-> () ) {
        AF.request(self.baseUrl + endPoint, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: [.contentType("application/json"), .authorization(bearerToken: App.shared.defaults.object(forKey: "Token") as! String)]).responseJSON { (responseData) in
            switch responseData.result {
            case .success(let data):
                print(data)
                if responseData.response?.statusCode == 200 {
                    guard let jsonResponse = responseData.value as? [String:Any] else { return }
                    print(jsonResponse, "jsonResponse")
                    completionHandler(true)
                }
                else {
                    completionHandler(false)
                }
            case .failure(let err):
                print("erroooor", err.localizedDescription)
                completionHandler(false)
            }
        }
    }
    
    func getListDatCam (endPoint: String){
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: [.contentType("application/json"), .authorization(bearerToken: App.shared.defaults.object(forKey: "Token") as! String)], interceptor: nil).response {
            (responseData) in
                        guard let data = responseData.data else { return }
                        do {
                            let datCam = try JSONDecoder().decode(listDatCam.self, from: data)
//                            print(camaras.cameras)
                            self.callBackDC?(datCam, true, "")
                        } catch {
                            print(error)
                            self.callBackDC?(nil, false, error.localizedDescription)
                        }

                    }
    }
    
    func completionHandlerDC(callBack: @escaping datCamCallBack){
        self.callBackDC = callBack
    }
    
    func getData(from endpoint: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let url = URL(string: "\(self.baseUrl)api/repo/img/\(endpoint ?? "")")!
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from endpoint: String, img: UIImageView) {
        getData(from: endpoint ) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                img.image = UIImage(data: data)
            }
        }
    }
    
}


