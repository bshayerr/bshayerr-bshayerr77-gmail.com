//
//  CameraVC.swift
//  Madad
//
//  Created by rihab aldabbagh on 19/01/2018.
//  Copyright © 2018 GeekLoop. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML //doc
import Vision //doc

enum FlashState {
    case off
    case on
}

class CameraVC: UIViewController {
    
    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var photoData: Data?
    var flashControlState: FlashState = .off
        var speechSynthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var CaptureImageView: RoundedShadowImageView!
    @IBOutlet weak var flashBTN: CameraRoundedBtn!
    @IBOutlet weak var IdentificationLBL: UILabel!
    @IBOutlet weak var ConfidenceLBL: UILabel!
    @IBOutlet weak var CameraView: UIView!
    @IBOutlet weak var RoundedLabelView: RoundedShadowView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = CameraView.bounds
        speechSynthesizer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTapsRequired = 1
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSession.canAddInput(input) == true {
                captureSession.addInput(input)
            }
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddOutput(cameraOutput) == true {
                captureSession.addOutput(cameraOutput!)
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                CameraView.layer.addSublayer(previewLayer!)
                CameraView.addGestureRecognizer(tap)
                captureSession.startRunning()
            }
        } catch {
          debugPrint(error)
        }
    }
    
    @objc func didTapCameraView() {
        self.CameraView.isUserInteractionEnabled = false
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType, kCVPixelBufferWidthKey as String: 160, kCVPixelBufferHeightKey as String: 160]
        
        settings.previewPhotoFormat = previewFormat
        
        if flashControlState == .off {
            settings.flashMode = .off
        } else {
            settings.flashMode = .on
        }
        
        cameraOutput.capturePhoto(with: settings, delegate: self)

    }
    

    func resultsMethod(request: VNRequest, error: Error?){
        //handle changing the label text
guard let results = request.results as? [VNClassificationObservation] else { return }
        
        for classification in results {
            if classification.confidence < 0.7 { // 70% sure
                let unknownObjectMessage = "I'm not sure what is this. Please try again."
                self.IdentificationLBL.text = unknownObjectMessage
                    synthesizeSpeech(fromString: unknownObjectMessage)
                self.ConfidenceLBL.text = ""
                break
            } else {
                let identification = classification.identifier
                let confidence = Int(classification.confidence * 100)
                self.IdentificationLBL.text = identification
                self.ConfidenceLBL.text = "CONFIDENCE: \(confidence)%"
                let completeSentence = "This looks like a \(identification) and I'm \(confidence) percent sure."
                synthesizeSpeech(fromString: completeSentence)
                break
            }
        }
    }
    
 
    func synthesizeSpeech(fromString string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
    
    
    
    
    @IBAction func FlashBtnPressed(_ sender: Any) {
        switch flashControlState {
        case .off:
            flashBTN.setTitle("FLASH ON", for: .normal)
            flashControlState = .on
        case .on:
            flashBTN.setTitle("FLASH OFF", for: .normal)
            flashControlState = .off

        }
    }
    
 
}


extension CameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,didFinishProcessingPhoto photo: AVCapturePhoto,error: Error?){
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()
            
            do {
                // the brain that process the image
                let model = try VNCoreMLModel (for: SqueezeNet().model)
                // using the brain to make a thought
                let request = VNCoreMLRequest ( model:model,completionHandler: resultsMethod)
                // take the data and compare it, then send it
                let handler = VNImageRequestHandler(data:photoData!)
                try handler.perform([request])
            } catch{
                // Handle errors
                debugPrint(error)
            }
            
            let image = UIImage (data: photoData!)
            self.CaptureImageView.image = image
            
        }
    }
}

extension CameraVC: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.CameraView.isUserInteractionEnabled = true
    }
}
