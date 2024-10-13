import CoreImage
import UIKit

struct ImageFilteringHelper {
    
    // Apply multiple image adjustments
    static func applyFilters(to image: UIImage, with settings: FilterSettings) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let context = CIContext() // Create a new CIContext
        
        // Convert UIImage to CIImage
        let ciImage = CIImage(cgImage: cgImage)
        
        // Apply color controls (brightness, contrast, saturation)
        guard let colorControlsFilter = CIFilter(name: "CIColorControls") else { return nil }
        colorControlsFilter.setValue(ciImage, forKey: kCIInputImageKey)
        colorControlsFilter.setValue(settings.brightness, forKey: kCIInputBrightnessKey)
        colorControlsFilter.setValue(settings.contrast, forKey: kCIInputContrastKey)
        colorControlsFilter.setValue(settings.saturation, forKey: kCIInputSaturationKey)
        
        var currentImage = colorControlsFilter.outputImage
        
        // Apply vibrance
        if let vibranceFilter = CIFilter(name: "CIVibrance") {
            vibranceFilter.setValue(currentImage, forKey: kCIInputImageKey)
            vibranceFilter.setValue(settings.vibrance, forKey: "inputAmount")
            currentImage = vibranceFilter.outputImage
        }
        
        // Apply highlights and shadows
        if let highlightShadowFilter = CIFilter(name: "CIHighlightShadowAdjust") {
            highlightShadowFilter.setValue(currentImage, forKey: kCIInputImageKey)
            highlightShadowFilter.setValue(settings.highlights, forKey: "inputHighlightAmount")
            highlightShadowFilter.setValue(settings.shadows, forKey: "inputShadowAmount")
            currentImage = highlightShadowFilter.outputImage
        }
        
        // Apply warmth (color temperature)
        if let temperatureFilter = CIFilter(name: "CITemperatureAndTint") {
            temperatureFilter.setValue(currentImage, forKey: kCIInputImageKey)
            temperatureFilter.setValue(CIVector(x: CGFloat(settings.warmth), y: 0), forKey: "inputNeutral")
            temperatureFilter.setValue(CIVector(x: CGFloat(settings.tint), y: 0), forKey: "inputTargetNeutral")
            currentImage = temperatureFilter.outputImage
        }

        // Apply black point adjustment
        if let blackPointFilter = CIFilter(name: "CIBlackPointAdjust") {
            blackPointFilter.setValue(currentImage, forKey: kCIInputImageKey)
            blackPointFilter.setValue(settings.blackPoint, forKey: "inputBlackPoint")
            currentImage = blackPointFilter.outputImage
        }
        
        switch settings.selectedFilter {
                case .none:
                    // No pre-built filter applied
                    break
                case .vivid:
                    if let vividFilter = CIFilter(name: "CIColorControls") {
                        vividFilter.setValue(currentImage, forKey: kCIInputImageKey)
                        vividFilter.setValue(1.5, forKey: kCIInputContrastKey) // Increased contrast
                        vividFilter.setValue(1.5, forKey: kCIInputSaturationKey) // Boost saturation
                        currentImage = vividFilter.outputImage!
                    }
                case .vividWarm:
                    if let vividWarmFilter = CIFilter(name: "CITemperatureAndTint") {
                        vividWarmFilter.setValue(currentImage, forKey: kCIInputImageKey)
                        vividWarmFilter.setValue(CIVector(x: 8000, y: 0), forKey: "inputNeutral") // Warmer tone
                        currentImage = vividWarmFilter.outputImage!
                    }
                }

        // Apply exposure adjustment
        if let exposureFilter = CIFilter(name: "CIExposureAdjust") {
            exposureFilter.setValue(currentImage, forKey: kCIInputImageKey)
            exposureFilter.setValue(settings.exposure, forKey: kCIInputEVKey)
            currentImage = exposureFilter.outputImage
        }
        
        // Render the final image
        if let outputImage = currentImage,
           let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
        
        return nil
    }
}
