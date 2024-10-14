import CoreImage
import UIKit

struct ImageFilteringHelper {
    
    static func applyFilters(to image: UIImage, with settings: FilterSettings) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let context = CIContext() // Create a new CIContext
        
        // Convert UIImage to CIImage
        var currentImage = CIImage(cgImage: cgImage)
        
        // Print the filter settings to debug
        print("Applying Tint: \(settings.tint), Black Point: \(settings.blackPoint)")

        // Apply color controls (brightness, contrast, saturation) only if non-default values are set
        if settings.brightness != 0.0 || settings.contrast != 1.0 || settings.saturation != 1.0 {
            if let colorControlsFilter = CIFilter(name: "CIColorControls") {
                colorControlsFilter.setValue(currentImage, forKey: kCIInputImageKey)
                colorControlsFilter.setValue(settings.brightness, forKey: kCIInputBrightnessKey)
                colorControlsFilter.setValue(settings.contrast, forKey: kCIInputContrastKey)
                colorControlsFilter.setValue(settings.saturation, forKey: kCIInputSaturationKey)
                currentImage = colorControlsFilter.outputImage ?? currentImage
            }
        }

        // Apply other filters similarly only if the values have changed from default
        if settings.vibrance != 0.0 {
            if let vibranceFilter = CIFilter(name: "CIVibrance") {
                vibranceFilter.setValue(currentImage, forKey: kCIInputImageKey)
                vibranceFilter.setValue(settings.vibrance, forKey: "inputAmount")
                currentImage = vibranceFilter.outputImage ?? currentImage
            }
        }

        if settings.highlights != 0.0 || settings.shadows != 0.0 {
            if let highlightShadowFilter = CIFilter(name: "CIHighlightShadowAdjust") {
                highlightShadowFilter.setValue(currentImage, forKey: kCIInputImageKey)
                highlightShadowFilter.setValue(settings.highlights, forKey: "inputHighlightAmount")
                highlightShadowFilter.setValue(settings.shadows, forKey: "inputShadowAmount")
                currentImage = highlightShadowFilter.outputImage ?? currentImage
            }
        }

        // Apply warmth (color temperature) and tint only if they are not neutral
        if settings.warmth != 6500.0 || settings.tint != 0.0 {
            if let temperatureFilter = CIFilter(name: "CITemperatureAndTint") {
                let warmth = CGFloat(settings.warmth)
                let tint = CGFloat(settings.tint)
                temperatureFilter.setValue(currentImage, forKey: kCIInputImageKey)
                temperatureFilter.setValue(CIVector(x: warmth, y: 0), forKey: "inputNeutral")
                temperatureFilter.setValue(CIVector(x: 6500, y: tint), forKey: "inputTargetNeutral")
                currentImage = temperatureFilter.outputImage ?? currentImage
            }
        }

        // Apply black point only if it's not 0 (neutral)
        if settings.blackPoint != 0.0 {
            if let exposureFilter = CIFilter(name: "CIExposureAdjust") {
                let blackPointValue = CGFloat(settings.blackPoint)
                
                // Apply a stronger exposure reduction to mimic black point adjustment
                exposureFilter.setValue(currentImage, forKey: kCIInputImageKey)
                exposureFilter.setValue(-blackPointValue * 2.0, forKey: kCIInputEVKey) // Stronger effect by multiplying more
                
                currentImage = exposureFilter.outputImage ?? currentImage
            }
        }



        switch settings.selectedFilter {
            case .none:
                break
            case .vivid:
                // Apply vivid filter: moderate increase in contrast and saturation
                if let vividFilter = CIFilter(name: "CIColorControls") {
                    vividFilter.setValue(currentImage, forKey: kCIInputImageKey)
                    vividFilter.setValue(1.15, forKey: kCIInputContrastKey)  // Moderate contrast increase
                    vividFilter.setValue(1.2, forKey: kCIInputSaturationKey)  // Moderate saturation increase
                    vividFilter.setValue(0.05, forKey: kCIInputBrightnessKey) // Slightly brighter
                    currentImage = vividFilter.outputImage ?? currentImage
                }
        case .vividWarm:
               // Apply vivid warm filter: moderate saturation increase, warmer tone
               if let vividWarmFilter = CIFilter(name: "CIColorControls") {
                   vividWarmFilter.setValue(currentImage, forKey: kCIInputImageKey)
                   vividWarmFilter.setValue(1.08, forKey: kCIInputContrastKey) // Slight contrast increase
                   vividWarmFilter.setValue(1.15, forKey: kCIInputSaturationKey) // Subtle saturation increase
                   currentImage = vividWarmFilter.outputImage ?? currentImage
               }

               // Now, adjust warmth for a classic warm effect
               if let warmthFilter = CIFilter(name: "CITemperatureAndTint") {
                   warmthFilter.setValue(currentImage, forKey: kCIInputImageKey)
                   warmthFilter.setValue(CIVector(x: 7800, y: 0), forKey: "inputNeutral")  // Classic warm tone (7800K)
                   warmthFilter.setValue(CIVector(x: 6500, y: 0), forKey: "inputTargetNeutral") // Keep the base neutral
                   currentImage = warmthFilter.outputImage ?? currentImage
               }
        }


        // Apply exposure adjustment
               if let exposureFilter = CIFilter(name: "CIExposureAdjust") {
                   exposureFilter.setValue(currentImage, forKey: kCIInputImageKey)
                   exposureFilter.setValue(settings.exposure, forKey: kCIInputEVKey)
                   currentImage = exposureFilter.outputImage ?? currentImage
               }

        // Render the final image after all filters are applied
        if let cgimg = context.createCGImage(currentImage, from: currentImage.extent) {
            return UIImage(cgImage: cgimg)
        }
        
        return nil
    }
}
