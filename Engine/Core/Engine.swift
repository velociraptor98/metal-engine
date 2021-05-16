//
//  Engine.swift
//  Engine
//
//  Created by KunalSingh on 16/05/21.
//
import MetalKit

class Engine{
    public static var Device: MTLDevice!
    public static var CommandQueue: MTLCommandQueue!
    public static func Set(device: MTLDevice){
        self.Device = device
        self.CommandQueue = device.makeCommandQueue()
    }
}
