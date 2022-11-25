//
//  STCodeView.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/11/25.
//

import SwiftUI

struct STCodeView: View {
    @State private var content: String
    var body: some View {
        Markdown(content: $content)
            .onAppear {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            }
            .onDisappear {
                DispatchQueue.main.async {
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                }
            }
    }

    init(_ content: String) {
        self.content = content
    }
}

struct STCodeView_Previews: PreviewProvider {
    static var previews: some View {
        STCodeView("")
    }
}
