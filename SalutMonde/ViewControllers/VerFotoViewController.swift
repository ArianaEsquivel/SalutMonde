//
//  VerFotoViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 16/04/21.
//

import UIKit

class VerFotoViewController: UIViewController {

    @IBOutlet weak var ivFoto: UIImageView!
    
    var service: Service!
    var nameFoto : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.nameFoto
        let url = URL(string: "http://127.0.0.1:3333/v1/api/repo/img/\(self.nameFoto ?? "")")!
        downloadImage(from: url)
//        service.downloadImage(from: self.nameFoto, img: ivFoto)
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url ) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.ivFoto.image = UIImage(data: data)
            }
        }
    }

}
