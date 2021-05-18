//
//  Renderer.swift
//  Engine
//
//  Created by KunalSingh on 19/05/21.
//

import MetalKit
class Renderer: NSObject {
    var gameObject: GameObject = GameObject()
}
extension Renderer:MTKViewDelegate{
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    func draw(in view: MTKView){
        guard let drawable = view.currentDrawable,let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        gameObject.render(renderCommandEncoder: renderCommandEncoder!)
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
