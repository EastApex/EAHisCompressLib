//
//  abc.swift
//  EAProductDemo
//
//  Created by Aye on 2025/7/11.
//

import Foundation
import SCompressLib;
import CoreGraphics
import UIKit

var _fullPath  = "global_path"
var decompressPic : CGImage?

var _isBg = false;

@objc public class EAHisCompress: NSObject {
    
    func extractPixelData(from image: UIImage) -> (redChannel: [UInt8], greenChannel: [UInt8], blueChannel: [UInt8], alphaChannel: [UInt8])? {
        guard let cgImage = image.cgImage else { return nil }
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        // 每个像素 4 字节（RGBA）
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        // 创建颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // 分配内存空间来存储像素数据
        var pixelData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        guard let context = CGContext(
            data: &pixelData,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }
        // 将图像绘制到上下文中，得到像素数据
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        // 创建存储通道值的数组，并预先分配足够的容量
        var redChannel = [UInt8](repeating: 0, count: width * height)
        var greenChannel = [UInt8](repeating: 0, count: width * height)
        var blueChannel = [UInt8](repeating: 0, count: width * height)
        var alphaChannel = [UInt8](repeating: 0, count: width * height)
        // 直接遍历并提取每个像素的 RGBA 值
        for i in 0..<(width * height) {
            let pixelIndex = i * bytesPerPixel
            redChannel[i] = pixelData[pixelIndex] // 红色通道
            greenChannel[i] = pixelData[pixelIndex + 1] // 绿色通道
            blueChannel[i] = pixelData[pixelIndex + 2] // 蓝色通道
            alphaChannel[i] = pixelData[pixelIndex + 3] // 透明度通道
        }
        return (redChannel, greenChannel, blueChannel, alphaChannel)
    }
    
    
    @objc public func compress(image:UIImage,isBg:Bool)  {
        
        _isBg = isBg;
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        print("width = \(width), height = \(height)")
        let pixelFormat = image.cgImage?.pixelFormatInfo
        print("pixelFormat = \(pixelFormat.debugDescription)")
        var sParam = SCompressParam()
        sParam.id = 15
        sParam.width = Int32(width)
        sParam.height = Int32(height)
        sParam.stride = Int32(width)
        sParam.modeRgb = 1
        sParam.modeAlpha = 1
        sParam.cmpMode = 0
        sParam.tileWidth = 4
        sParam.pixelFormat = 1
        
        
        /**
         
         tileWidth：压缩单元宽度：4--4x4；6--6x4；8--8x4；16--16x4，也叫压缩倍率分别对应4倍压缩，6倍压缩，8倍压缩，16倍压缩。
         modeAlpha：压缩模式：0-- 非压缩；1-- 压缩
         modeRgb：压缩模式：0--非压缩；1-- 压缩
         cmpMode: 0--手动压缩模式：按照固定配置参数进行压缩。当前版本仅支持cmpMode = 0
         
         */
        
        if let result = extractPixelData(from: image) {
            sParam.redChannel = result.redChannel
            sParam.greenChannel = result.greenChannel
            sParam.blueChannel = result.blueChannel
            sParam.alphaChannel = result.alphaChannel
        }
        print("red channel len = \(sParam.redChannel.count)")
        let picApi = SPicZipApi()
        SetZipEvent(picEvent: MyZipRets())
        picApi.Compress(compressParam: sParam)
        
    }

}

public func ReadChannelData (name : String) ->[UInt8] {
    let filePath = NSHomeDirectory() + "/Documents/" + name
    let fileHandler = FileHandle.init(forReadingAtPath: filePath)
    let fileData = fileHandler?.readDataToEndOfFile()
    let rets = [UInt8](fileData!)
    print("channel len == \(rets.count)")
    return rets
}

public func WriteCompressedFile(name : String, compressedData : [UInt8]) {
    let basedFilePath = NSHomeDirectory() + "/Documents"
    let fileManager = FileManager.default
    let format = DateFormatter()
    let now = Date()
    format.dateFormat = "HHmmss"
    let timeStamp = format.string(from: now)
    let fullPath = basedFilePath + "/CompressRets_" + name + timeStamp + ".bin"
    print("fullPath = \(fullPath)")
    let exist = fileManager.fileExists(atPath: fullPath)
    if !exist {
        let data = Data(bytes: compressedData, count: compressedData.count)
        fileManager.createFile(atPath: fullPath, contents: data)
    }
}



public func WriteCompressedFile(compressedData : [UInt8]) {
    
    let basedFilePath = NSHomeDirectory() + "/Documents"
    let fileManager = FileManager.default
    var name = _isBg ?  "bg" : "thumbnail";
    _fullPath = basedFilePath + "/Compressed_" + name + ".bin"
    print("fullPath = \(_fullPath)")
    let exist = fileManager.fileExists(atPath: _fullPath)
    if !exist {
        let data = Data(bytes: compressedData, count: compressedData.count)
        fileManager.createFile(atPath: _fullPath, contents: data)
    }
    else
    {
        print("try removeItem = \(_fullPath)")
        try? fileManager.removeItem(atPath: _fullPath)
        let data = Data(bytes: compressedData, count: compressedData.count)
        fileManager.createFile(atPath: _fullPath, contents: data)
    }
}


struct MyZipRets : PicZipEvent {
  
    func DecompressRets(id: Int, state: Int, decomRets: SCompressLib.SDecompressRets) {
        let imageWidth = Int(decomRets.width)
        let imageHeight = Int(decomRets.height)
        drawRect(decomRets: decomRets)
        print("decompress id ====== \(id)")
       
    }
    
    func CompressRets(id: Int, state: Int, tileWidth: Int, retData: [UInt8]) {
        WriteCompressedFile(compressedData: retData)
    }
}

func createBitmapContext(pixelsWide: Int, _ pixelsHigh: Int) -> CGContext? {
    let bytesPerPixel = 4 // 生成包括ARGB四个通道的像素点，每个像素点需要4个字节
    let bytesPerRow = bytesPerPixel * pixelsWide
    let bitsPerComponent = 8
    let byteCount = (bytesPerRow * pixelsHigh)
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let pixels = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity:byteCount)
    let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
    let context = CGContext(data: pixels, width: pixelsWide, height: pixelsHigh, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
    return context
}

func drawRect(decomRets: SCompressLib.SDecompressRets) {
    let width  = decomRets.width
    let height = decomRets.height
    let boundingBox = CGRectMake(0, 0, CGFloat(width), CGFloat(height))
    let context = createBitmapContext(pixelsWide: Int(width), Int(height))
    let data = context!.data
    var pixelIdx = 0
    var chanIdx = 0
    for i in 0...height - 1 {
        for j in 0...width - 1 {
            chanIdx = Int(i * width + j)
            data?.storeBytes(of:decomRets.alphaChannel[chanIdx], toByteOffset: pixelIdx, as: UInt8.self)
            pixelIdx += 1
            data?.storeBytes(of:decomRets.redChannel[chanIdx], toByteOffset: pixelIdx, as: UInt8.self)
            pixelIdx += 1
            data?.storeBytes(of:decomRets.greenChannel[chanIdx], toByteOffset: pixelIdx, as: UInt8.self)
            pixelIdx += 1
            data?.storeBytes(of:decomRets.blueChannel[chanIdx], toByteOffset: pixelIdx, as: UInt8.self)
            pixelIdx += 1
        }
    }
    decompressPic = context!.makeImage()
}


