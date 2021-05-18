//
//  GameObject.swift
//  Engine
//
//  Created by KunalSingh on 18/05/21.
//

import MetalKit

class GameObject{
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    func createBuffers(){
        vertexBuffer = Engine.Device?.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride*vertices.count,options: [])
    }
    func createVertices(){
        vertices = [
            Vertex(position: float3(0,1,0), color: float4(1,0,0,1)),
            Vertex(position: float3(-1,-1,0), color: float4(0,1,0,1)),
            Vertex(position: float3(1,-1,0), color: float4(0,0,1,1))
        ]
    }
    init(){
        createVertices()
        createBuffers()
    }
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}
