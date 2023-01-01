//
//  FaceDetectVC.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/28.
//

import UIKit
import AVFoundation
import Foundation
import Vision

class FaceDetectVC: SubLevelViewController, AVCapturePhotoCaptureDelegate {

    lazy var checkLabel: CATextLayer = {
        let label = CATextLayer()
        label.string = "签到"
        label.foregroundColor = UIColor.hex("#FFFFFF").cgColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRectMake(ScreenWidth / 2 - 50, 148, 100, 50);
        label.alignmentMode = .center
        return label
    }()

    lazy var detailLabel: CATextLayer = {
        let label = CATextLayer()
        label.string = "人脸识别中"
        label.foregroundColor = UIColor.hex("#FFFFFF").cgColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.alignmentMode = .center
        label.frame = CGRectMake(ScreenWidth / 2 - 100, ScreenHeight / 2 + ScreenWidth / 2 + 30, 200, 50);
        return label
    }()

    open var didSelectImageWith:((_ img: UIImage) -> ())?

    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private var faceLayers: [CAShapeLayer] = []
    private let photoOutput = AVCapturePhotoOutput()

    var circleCGPath: CGPath? = nil
    var circleCGPath2: CGPath? = nil
    var processingImage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        captureSession.startRunning()

        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }

        let midX = view.bounds.midX
        let midY = view.bounds.midY
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: midX, y: midY), radius: CGFloat(self.view.bounds.width / 2 - 40), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: midX, y: midY), radius: CGFloat(self.view.bounds.width / 2 - 55), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

        circleCGPath = circlePath.cgPath
        circleCGPath2 = circlePath2.cgPath

        let markLayer = CAShapeLayer();
        markLayer.frame = view.bounds;
        markLayer.fillColor = UIColor.hex("#000000", alpha: 0.7).cgColor
        markLayer.fillRule = .evenOdd;

        let pathRef = CGMutablePath()
        pathRef.addRect(view.bounds)
        pathRef.addPath(circlePath2.cgPath)
        markLayer.fillRule = .evenOdd;
        markLayer.path = pathRef;

        let shapeLayerPath = CAShapeLayer()

        shapeLayerPath.path = circlePath.cgPath
        shapeLayerPath.fillColor = UIColor.clear.cgColor
        shapeLayerPath.strokeColor = UIColor.white.cgColor
        shapeLayerPath.lineWidth = 3

        let shapeLayerPath2 = CAShapeLayer()

        shapeLayerPath2.path = circlePath2.cgPath
        shapeLayerPath2.fillColor = UIColor.clear.cgColor
        shapeLayerPath2.strokeColor = UIColor.white.cgColor
        shapeLayerPath2.lineWidth = 1

        view.layer.addSublayer(markLayer)
        view.layer.addSublayer(shapeLayerPath)
        view.layer.addSublayer(shapeLayerPath2)
        view.layer.addSublayer(checkLabel)
        view.layer.addSublayer(detailLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navBarStyle(.clear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navBarStyle(.white)
    }

    private func setupCamera() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front)
        if let device = deviceDiscoverySession.devices.first {
            if let deviceInput = try? AVCaptureDeviceInput(device: device) {
                if captureSession.canAddInput(deviceInput) {
                    captureSession.addInput(deviceInput)
                    setupPreview()
                }
            }
        }
    }

    private func setupPreview() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.frame
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        let videoConnection = self.videoDataOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
    }
}

extension FaceDetectVC: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                self.faceLayers.forEach({ drawing in drawing.removeFromSuperlayer() })
                if let observations = request.results as? [VNFaceObservation] {
                    self.handleFaceDetectionObservations(observations: observations)
                }
            }
        })

        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: imageBuffer, orientation: .leftMirrored, options: [:])
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch {
            print(error.localizedDescription)
        }
    }

    private func handleFaceDetectionObservations(observations: [VNFaceObservation]) {
        if !processingImage {
            for observation in observations {
                let faceRectConverted = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observation.boundingBox)
                let faceRectanglePath = CGPath(rect: faceRectConverted, transform: nil)

                let circleBox = circleCGPath!.boundingBox
                let faceBox = faceRectanglePath.boundingBox

                let faceArea = faceBox.size.width * faceBox.size.height
                if (circleBox.contains(faceBox) && faceArea > 50000) {
                    processingImage = true
                    if captureSession.isRunning {
                        let settings = AVCapturePhotoSettings()
                        photoOutput.capturePhoto(with: settings, delegate: self)
                    }
                }

                let faceLayer = CAShapeLayer()
                faceLayer.path = faceRectanglePath
                faceLayer.fillColor = UIColor.clear.cgColor
                faceLayer.strokeColor = UIColor.red.cgColor

                faceLayers.append(faceLayer)
                view.layer.addSublayer(faceLayer)
            }
        }
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        let previewImage = UIImage(data: imageData)
        processingImage = true
        
        if previewImage != nil {
            didSelectImageWith?(previewImage!)
        }
    }
}
