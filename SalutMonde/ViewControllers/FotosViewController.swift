//
//  MisFotosViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 05/04/21.
//

import UIKit

class FotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionsFotos: UICollectionView!
    var service: Service!
    var listaFotos = listDatCam()
    var codeImg : String!
    var nameImg : String!
    var nameFoto : String!
    var foto : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = self.nameImg
        
        collectionsFotos.delegate = self
        collectionsFotos.dataSource = self
        
        self.service = Service()
        self.service.getListDatCam(endPoint: "api/camera/\(codeImg ?? "")")
        self.service.completionHandlerDC { (listaFotos, status, message) in
            if status {
                guard let _listaFotos = listaFotos else {return}
                self.listaFotos = _listaFotos
                self.collectionsFotos.reloadData()
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaFotos.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fotoCell", for: indexPath) as! FotosCollectionViewCell
        service.downloadImage(from: listaFotos.images![indexPath.row].route!, img: cell.ivFoto)
        
        print(listaFotos.images![indexPath.row].route as Any)
        cell.layer.cornerRadius = cell.frame.height / 5
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.nameFoto = listaFotos.images![indexPath.row].route!
        performSegue(withIdentifier: "goToVerFoto", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVerFoto"{
            let vf = segue.destination as! VerFotoViewController
            vf.nameFoto = self.nameFoto
        }
    }

}
