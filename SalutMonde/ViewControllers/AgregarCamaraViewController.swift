//
//  AgregarCamaraViewController.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 05/04/21.
//

import UIKit
import AVFoundation

class AgregarCamaraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession:AVCaptureSession!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var service:Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        self.service = Service()
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput){
                captureSession.addInput(videoInput)
            }else{
                failed()
                
            }
        }catch {
            print("Error \(error)")
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)){
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readbleObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readbleObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            foundText(stringValue)
        }
    }
    
    func foundText (_ textFromQR:String){
        print(textFromQR)
        guard let data = textFromQR.data(using: .utf8) else { return }
        print(data)
        let parameters: [String: String] = [
            "code": textFromQR,
            "na":"jeje"
        ]

        self.service.regCam(endPoint: "api/camera/create", parameters: parameters) { (isSuccess) in
            if isSuccess {
//                self.alertDefault(with: "Cámara registrada", andWithMsg: "La cámara se vinculó correctamente a su cuenta", completion: true)
                let ac = UIAlertController(title: "Cámara registrada", message: "La cámara se vinculó correctamente a su cuenta", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(ac, animated: true)
            }
            else {
//                self.alertDefault(with: "Algo salió mal", andWithMsg: "Algo salió mal con la vinculación de la cámara", completion: false)
                
                let ac = UIAlertController(title: "Error de vinculación", message: "Algo salió mal con la vinculación de la cámara", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.captureSession.startRunning()
                }))
                self.present(ac, animated: true)
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
}
