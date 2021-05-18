//
//  RenderPipelineDescriptorLibrary.swift
//  Engine
//
//  Created by KunalSingh on 18/05/21.
//

import MetalKit
enum RenderPipelineDescriptorTypes{
    case Basic
}
class RenderPipelineDescriptorLibrary{
    private static var renderPipelineDescriptors: [ RenderPipelineDescriptorTypes : RenderPipelineDescriptor] = [:]
    public static func initialize(){
        RenderPipelineDescriptors()
    }
    private static func RenderPipelineDescriptors(){
        renderPipelineDescriptors.updateValue(Basic_RenderPipelineDescriptor(),forKey: .Basic)
    }
    public static func descriptor(_ RenderPipelineDescriptorType:RenderPipelineDescriptorTypes)->MTLRenderPipelineDescriptor{
        return renderPipelineDescriptors[RenderPipelineDescriptorType]!.renderPipelineDescriptor
    }
}
protocol RenderPipelineDescriptor{
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor { get }
}
public struct Basic_RenderPipelineDescriptor: RenderPipelineDescriptor{
    var name: String = "Basic Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.descriptor(.Basic)
        return renderPipelineDescriptor
    }
}
