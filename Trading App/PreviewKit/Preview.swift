//
//  Preview.swift
//  XcodePreviewsDemo
//
//  Created by Alex Nagy on 09.03.2021.
//

import SwiftUI

struct Preview: Codable, Hashable {
    static let defaultPreview = Preview(device: .iPhone_12_Pro_Max, colorScheme: .light, displayName: nil)
    
    let device: String?
    let colorScheme: String?
    let displayName: String?
    let width: CGFloat?
    let height: CGFloat?
    
    init(width: CGFloat, height: CGFloat, colorScheme: ColorScheme? = nil, displayName: String? = nil) {
        self.width = width
        self.height = height
        self.colorScheme = colorScheme?.rawValue()
        self.displayName = displayName
        self.device = nil
    }
    
    init(device: PreviewDevice? = nil, colorScheme: ColorScheme? = nil, displayName: String? = nil) {
        self.width = nil
        self.height = nil
        self.colorScheme = colorScheme?.rawValue()
        self.displayName = displayName
        self.device = device?.rawValue
    }
    
    func getDevice() -> PreviewDevice? {
        guard let device = device else {
            return nil
        }
        return PreviewDevice(rawValue: device)
    }
    
    func isDevice() -> Bool {
        return getDevice() != nil
    }
    
    func getColorScheme() -> ColorScheme {
        guard let colorScheme = colorScheme else {
            return .light
        }
        return .initFromRawValue(colorScheme)
    }
    
    func getDisplayName() -> String {
        guard let displayName = displayName else {
            if let device = getDevice() {
                return device.rawValue
            } else {
                if let width = width, let height = height {
                    return "\(width) x \(height)"
                } else {
                    return "Size that Fits"
                }
            }
        }
        return displayName
    }
    
}

struct PreviewData: Codable {
    let previews: [Preview]
    init(preview: Preview) {
        self.previews = [preview]
    }
    
    init(previews: [Preview]) {
        self.previews = previews
    }
}

extension ColorScheme {
    func rawValue() -> String {
        return self == ColorScheme.light ? "light" : "dark"
    }
    static func initFromRawValue(_ rawValue: String) -> ColorScheme {
        for colorScheme in ColorScheme.allCases {
            if colorScheme.rawValue() == rawValue {
                return colorScheme
            }
        }
        fatalError("Cannot create ColorScheme from raw value \(rawValue)")
    }
}
extension View {
    func preview(_ preview: Preview) -> some View {
        return self
            .background(Color(.systemBackground))
            .previewDevice(preview.getDevice())
            .previewLayout(preview.isDevice() ? .device : preview.width == nil ? .sizeThatFits : .fixed(width: preview.width ?? 350, height: preview.height ?? 667))
            .previewColorScheme(preview.getColorScheme())
            .previewDisplayName(preview.getDisplayName())
        
    }
    
    func preview(_ data: PreviewData) -> some View {
        return Group {
            ForEach(data.previews, id: \.self) { preview in
                self.preview(preview)
            }
        }
    }
    
    func previewColorScheme(_ value: ColorScheme) -> some View {
        return self.environment(\.colorScheme, value)
    }
    
    func previewDevices(_ values: [PreviewDevice]) -> some View {
        Group {
            ForEach(0..<values.count, id: \.self) {
                index in
                self.previewDevice(values[index])
            }
        }
    }
    
    func previewContentSizeCategory(_ value: ContentSizeCategory) -> some View {
        return self.environment(\.sizeCategory, value)
    }
}
