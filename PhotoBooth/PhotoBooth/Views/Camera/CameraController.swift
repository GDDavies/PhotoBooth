//
//  CameraController.swift
//  PhotoBooth
//
//  Created by George Davies on 09/04/2021.
//

import AVFoundation
import UIKit

final class CameraController: NSObject {

    enum CameraError: Error {
        case cameraNotFound
        case decodingImage
    }

    private var didFinishPickingPhoto: ((Result<UIImage, Error>) -> Void)?

    private var videoDataOutput: AVCaptureVideoDataOutput?
    private var videoDataOutputQueue: DispatchQueue?

    private var photoDataOutput: AVCapturePhotoOutput?
    private var photoDataOutputQueue: DispatchQueue?

    private var session: AVCaptureSession?
    private var vision: AVCaptureVideoDataOutputSampleBufferDelegate?

    private var previewLayer: AVCaptureVideoPreviewLayer?
    private let view: UIView

    init(view: UIView) {
        self.view = view
        super.init()
    }

    func startSession() throws {
        guard session == nil else {
            session?.startRunning()
            return
        }
        session = try setupCaptureSession()
        session?.startRunning()
    }

    func stopSession() {
        session?.stopRunning()
    }

    func takePhoto(completion: @escaping (Result<UIImage, Error>) -> Void) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.__availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType]

        settings.previewPhotoFormat = previewFormat
        didFinishPickingPhoto = completion
        photoDataOutput?.capturePhoto(with: settings, delegate: self)
    }
}

private extension CameraController {
    func setupCaptureSession() throws -> AVCaptureSession? {
        let captureSession = AVCaptureSession()
        do {
            try self.configureBackCamera(for: captureSession)
            self.configurePhotoDataOutput(captureSession: captureSession)
            configureVideoDataOutput(captureSession: captureSession)
            designatePreviewLayer(for: captureSession)
            return captureSession
        } catch {
            teardownAVCapture()
            throw error
        }
    }

    func configureBackCamera(for captureSession: AVCaptureSession) throws {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back
        )
        if let device = deviceDiscoverySession.devices.first {
            let deviceInput = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(deviceInput) {
                captureSession.addInput(deviceInput)
            }
        } else {
            throw CameraError.cameraNotFound
        }
    }

    func configureVideoDataOutput(captureSession: AVCaptureSession) {
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        let videoDataOutputQueue = DispatchQueue(label: "com.gdaviesdev.photoBooth.videoOutput")
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
        }
        let videoConnection = videoDataOutput.connection(with: .video)
        if let connection = videoConnection {
            if connection.isVideoOrientationSupported {
                connection.videoOrientation = .portrait
            }
            if connection.isVideoMirroringSupported {
                connection.isVideoMirrored = true
            }
        }
        self.videoDataOutput = videoDataOutput
        self.videoDataOutputQueue = videoDataOutputQueue
    }

    func configurePhotoDataOutput(captureSession: AVCaptureSession) {
        let photoDataOutput = AVCapturePhotoOutput()
        let videoDataOutputQueue = DispatchQueue(label: "com.gdaviesdev.photoBooth.photoOutput")
        if captureSession.canAddOutput(photoDataOutput) {
            captureSession.addOutput(photoDataOutput)
        }

        photoDataOutput.connection(with: .video)?.isEnabled = true
        self.photoDataOutput = photoDataOutput
        self.photoDataOutputQueue = videoDataOutputQueue
    }

    func designatePreviewLayer(for captureSession: AVCaptureSession) {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = videoPreviewLayer

        videoPreviewLayer.name = "CameraPreviewLayer"
        videoPreviewLayer.backgroundColor = UIColor.black.cgColor
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        let previewRootLayer = view.layer
        previewRootLayer.masksToBounds = true
        videoPreviewLayer.frame = previewRootLayer.bounds
        previewRootLayer.insertSublayer(videoPreviewLayer, at: 0)
    }

    func teardownAVCapture() {
        self.videoDataOutput = nil
        self.videoDataOutputQueue = nil
        self.photoDataOutput = nil
        self.photoDataOutputQueue = nil

        if let previewLayer = self.previewLayer {
            previewLayer.removeFromSuperlayer()
            self.previewLayer = nil
        }
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        if let error = error {
            didFinishPickingPhoto?(.failure(error))
        } else {
            guard let data = photo.fileDataRepresentation(),
                  let image = UIImage(data: data) else {
                didFinishPickingPhoto?(.failure(CameraError.decodingImage))
                return
            }
            didFinishPickingPhoto?(.success(image))
        }
    }
}
