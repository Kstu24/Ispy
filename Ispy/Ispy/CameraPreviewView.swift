//
//  CameraPreviewView.swift
//  Ispy
//
//  Created by Kevin Stewart on 10/10/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit
import AVFoundation

/// Use this class to make a fullscreen or partial screen view that can
/// display a live camera preview

class CameraPreviewView: UIView {
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    var session: AVCaptureSession? {
        get { return videoPreviewLayer.session }
        set { videoPreviewLayer.session = newValue }
    }
}
