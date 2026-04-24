import Foundation
import UIKit
import CoreText

public struct FontRegistrar {
    public static func registerFonts() {
        let fonts = [
            "BPdotsVertical.otf",
            "BPdotsVerticalBold.otf",
            "SpaceMono-Bold.ttf",
            "SpaceMono-Regular.ttf",
            "Telka-Extended-Black.otf",
            "Telka-Extended-Bold.otf",
            "Telka-Extended-Light.otf",
            "Telka-Extended-Medium.otf",
            "Telka-Extended-Regular.otf",
            "Telka-Extended-Super.otf",
            "Telka-Medium.otf",
            "Telka-Regular.otf"
        ]
        
        for font in fonts {
            let parts = font.components(separatedBy: ".")
            guard parts.count == 2,
                  let fontURL = Bundle.main.url(forResource: parts[0], withExtension: parts[1]) else {
                print("Failed to locate \(font) in app bundle.")
                continue
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error) {
                print("Failed to register font \(font): \(error.debugDescription)")
            } else {
                print("Successfully registered \(font) dynamically.")
            }
        }
    }
}
