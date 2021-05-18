//
//  RenderPipelineStateLibrary.swift
//  Engine
//
//  Created by KunalSingh on 18/05/21.
//

import MetalKit
enum RenderPipelineStateTypes{
    case Basic
}
class RenderPipelineStateLibrary{
    private static var renderPipelineStates: [ RenderPipelineStateTypes :RenderPipelineState] = [:]
    public static func initialize(){
        createDefaultRenderPipelineStates()
    }
    private static func createDefaultRenderPipelineStates(){
        renderPipelineStates.updateValue(Basic_RenderPipelineState(),forKey: .Basic)
    }
    public static func PipelineState(_ renderPipelineStateType:RenderPipelineStateTypes)->MTLRenderPipelineState{
        return renderPipelineStates[renderPipelineStateType]!.renderPipelineState
    }
}

protocol RenderPipelineState{
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState { get }
}
public struct Basic_RenderPipelineState: RenderPipelineState{
    var name: String = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState {
        var renderPipelineState: MTLRenderPipelineState!
        do{
            renderPipelineState = try Engine.Device?.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.descriptor(.Basic))
        }catch let error as NSError{
            print("Error: ",error);
        }
        return renderPipelineState
    }
}
