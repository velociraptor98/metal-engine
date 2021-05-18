//
//  GameView.swift
//  Engine
//
//  Created by KunalSingh on 16/05/21.
//

import Cocoa
import MetalKit

class GameView: MTKView {
    var renderer: Renderer!
    struct Vertex{
        var position: float3
        var color: float4
    }
    required init(coder: NSCoder){
        super.init(coder: coder)
        self.device = MTLCreateSystemDefaultDevice()
        Engine.Set(device: device!)
        self.clearColor = Preferences.clearColor
        self.colorPixelFormat = Preferences.MainPixelFormat
        self.renderer = Renderer()
        // delegate draw functionality to renderer
        self.delegate = renderer
    }
}
