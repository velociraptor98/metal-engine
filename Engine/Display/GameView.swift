//
//  GameView.swift
//  Engine
//
//  Created by KunalSingh on 16/05/21.
//

import Cocoa
import MetalKit

class GameView: MTKView {
    var renderPipelineState: MTLRenderPipelineState!
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
        createRenderPipelineState()
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
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
        
    }
    func createRenderPipelineState(){
        let library = Engine.Device?.makeDefaultLibrary();
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        let vertexDescriptor = MTLVertexDescriptor()
        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        //Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.size
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.size
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        do{
        renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let error as NSError{
            print("Error: ",error);
        }
    }
}
