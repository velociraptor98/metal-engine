//
//  GameView.swift
//  Engine
//
//  Created by KunalSingh on 16/05/21.
//

import Cocoa
import MetalKit

class GameView: MTKView {
    //var renderPipelineState: MTLRenderPipelineState!
    struct Vertex{
        var position: float3
        var color: float4
    }
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    func createBuffers(){
        vertexBuffer = Engine.Device?.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride*vertices.count,options: [])
    }
    required init(coder: NSCoder){
        super.init(coder: coder)
        self.device = MTLCreateSystemDefaultDevice()
        Engine.Set(device: device!)
        self.clearColor = Preferences.clearColor
        self.colorPixelFormat = Preferences.MainPixelFormat
        //createRenderPipelineState()
        createVertices()
        createBuffers()
        
    }
    func createVertices(){
        vertices = [
            Vertex(position: float3(0,1,0), color: float4(1,0,0,1)),
            Vertex(position: float3(-1,-1,0), color: float4(0,1,0,1)),
            Vertex(position: float3(1,-1,0), color: float4(0,0,1,1))
        ]
    }
    override func draw(_ rect: NSRect){
        guard let drawable = self.currentDrawable,let renderPassDescriptor = self.currentRenderPassDescriptor else { return }
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        //renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder?.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
        
    }
}
