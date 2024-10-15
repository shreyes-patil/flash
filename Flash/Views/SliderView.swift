import SwiftUI

struct CustomSliderView: View {
    @Binding var value: Float // This is the actual slider value
    let range: ClosedRange<Float> // The functional range of the slider
    let step: Float
    let title: String
    let displayRange: ClosedRange<Float> // The visible range (-100 to 100)
    
    // Helper to map the actual value to the display value (from -100 to 100)
    var displayValue: Float {
        let normalizedValue = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return displayRange.lowerBound + normalizedValue * (displayRange.upperBound - displayRange.lowerBound)
    }
    
    var body: some View {
        VStack {
            // Display title and current value
            HStack {
                Spacer()
                Text("\(Int(displayValue))") // Display current value mapped to -100 to 100
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.yellow)
                    .frame(width: 50, height: 50)
                    .background(Circle().strokeBorder(Color.yellow, lineWidth: 2))
                    .padding(.bottom, 5)
                Spacer()
            }

            // Custom slider with ticks and slider control
            ZStack(alignment: .center) {
                GeometryReader { geometry in
                    let sliderWidth = geometry.size.width - 40 // Slider width and ticks width
                    
                    // Create tick marks aligned with the slider
                    HStack(spacing: 0) {
                        // Add padding to the left to make ticks align with the slider start
                        Spacer()
                            .frame(width: 45) // Adjust this value to shift the ticks a little more right
                        
                        ForEach(0..<31) { i in // Set number of ticks to 31
                            Rectangle()
                                .fill(i == 15 ? Color.black : Color.gray) // Highlight center tick (15th tick)
                                .frame(width: 1, height: i % 5 == 0 ? 15 : 10) // Longer ticks for every 5th tick
                            
                            // Spread ticks evenly, without padding
                            if i < 30 { Spacer() }
                        }
                    }
                    .frame(width: sliderWidth)
                    
                    // Actual slider control
                    Slider(value: $value, in: range, step: step)
                        .accentColor(.black)
                        .padding(.horizontal, 20)
                }
                .frame(height: 30)
            }
        }
        .padding()
        Text(title)
            .font(.headline)
            .padding(.top, 5)
    }
}
