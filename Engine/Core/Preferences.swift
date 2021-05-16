//
//  Preferences.swift
//  Engine
//
//  Created by KunalSingh on 16/05/21.
//

import MetalKit
public enum ClearColors{
    static let White: MTLClearColor = MTLClearColor(red:1.0,green:1.0,blue:1.0,alpha: 1.0)
    static let Green: MTLClearColor = MTLClearColor(red:0.0,green:1.0,blue:0.0,alpha: 1.0)
    static let Grey: MTLClearColor = MTLClearColor(red:0.5,green:0.5,blue:0.5,alpha: 1.0)
    static let Black: MTLClearColor = MTLClearColor(red:0.0,green:0.0,blue:0.0,alpha: 1.0)

}
class Preferences{
    public static var clearColor:MTLClearColor = ClearColors.Grey
    public static var MainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm
}
