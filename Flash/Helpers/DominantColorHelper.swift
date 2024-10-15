//
//  DominantColorHelper.swift
//  Flash
//
//  Created by Shreyas Patil on 10/15/24.
//

import UIKit

struct DominantColorHelper {
    // Function to extract dominant color from a UIImage
    static func dominantColor(from image: UIImage) -> UIColor? {
        // Resize the image to a small size (like 10x10) to reduce the number of colors to analyze
        let resizedImage = image.resized(to: CGSize(width: 5, height: 5))
        
        // Get the pixel data from the resized image
        guard let pixelData = resizedImage.pixelData() else { return nil }

        // Dictionary to count occurrences of each color
        var colorCounts: [UIColor: Int] = [:]
        
        // Iterate over the pixel data to count occurrences of each color
        for i in 0..<pixelData.count/4 {
            let red = CGFloat(pixelData[i * 4]) / 255.0
            let green = CGFloat(pixelData[i * 4 + 1]) / 255.0
            let blue = CGFloat(pixelData[i * 4 + 2]) / 255.0
            let alpha = CGFloat(pixelData[i * 4 + 3]) / 255.0

            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            
            if let count = colorCounts[color] {
                colorCounts[color] = count + 1
            } else {
                colorCounts[color] = 1
            }
        }

        // Find the color with the highest count
        let dominantColor = colorCounts.max { $0.value < $1.value }?.key
        
        return dominantColor
    }
}

extension UIImage {
    // Function to resize the image to a small size
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }

    // Function to get pixel data from the image
    func pixelData() -> [UInt8]? {
        guard let cgImage = self.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let totalBytes = height * bytesPerRow
        
        var pixelData = [UInt8](repeating: 0, count: totalBytes)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        
        guard let context = CGContext(
            data: &pixelData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        ) else { return nil }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return pixelData
    }
}
