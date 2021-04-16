//
//  InicioViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 14/04/21.
//

import UIKit

class InicioViewController: UIViewController{

    @IBOutlet weak var ivIcono: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(verificar), userInfo: nil, repeats: false)
        
//        self.ivIconoo = UIImage(data: data)
        let url = URL(string: "http://127.0.0.1:3333/v1/api/repo/img/imagen.jpeg")!
            downloadImage(from: url)
            print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
//        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.ivIcono.image = UIImage(data: data)
            }
        }
    }
    
    @objc func verificar(){
//        if (App.shared.defaults.object(forKey: "Token") as! String == "") {
//            self.performSegue(withIdentifier: "segueGoToInicio", sender: self)
//        }
//        else {
            self.performSegue(withIdentifier: "segueGoMenu", sender: self)
//        }
    }
}
//extension UIImageView {
//    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit){
//        contentMode = mode
//        URLSession.shared.dataTask(with: url){ data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//            else{return}
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//        }.resume()
//    }
//
//    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspecfit){
//        guard let url = URL(string: link) else {return}
//        downloadFrom(url: url, contentMode: mode)
//    }
//
//}
