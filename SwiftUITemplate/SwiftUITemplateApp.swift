//
//  SwiftUITemplateApp.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/11/23.
//

import SwiftUI

@main
struct SwiftUITemplateApp: App {
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}
