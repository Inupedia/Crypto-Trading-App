//
//  UIViewController+Preview.swift
//  XcodePreviewsDemo
//
//  Created by Alex Nagy on 09.03.2021.
//

import UIKit

#if DEBUG && canImport(SwiftUI)
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    private struct UIPreview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        UIPreview(viewController: self)
    }
}
#endif

