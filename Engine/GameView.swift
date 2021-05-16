//
//  GameView.swift
//  Engine
//
//  Created by KunalSingh on 16/05/21.
//

import Cocoa
import MetalKit

class GameView: MTKView {
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    required init(coder: NSCoder){
        super.init(coder: coder)
        self.device = MTLCreateSystemDefaultDevice()
        self.clearColor = MTLClearColor(red:0.43,green:0.73,blue:0.35,alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        self.commandQueue = device?.makeCommandQueue()
        createRenderPipelineState()
        
    }
    override func draw(_ rect: NSRect){
        guard let drawable = self.currentDrawable,let renderPassDescriptor = self.currentRenderPassDescriptor else { return }
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
        
    }
    func createRenderPipelineState(){
        let library = device?.makeDefaultLibrary();
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        do{
        renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let error as NSError{
            print(error);
        }
    }
}
