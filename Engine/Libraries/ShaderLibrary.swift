//
//  ShaderLibrary.swift
//  Engine
//
//  Created by KunalSingh on 16/05/21.
//

import MetalKit
public enum VertexShaderTypes{
    case Basic
}
public enum FragmentShaderTypes{
    case Basic
}
class ShaderLibrary{
    
}
protocol Shader{
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction { get }
}
