//
//  TabContentView.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/11/23.
//

import SwiftUI

struct STRootTabContentView: View {
    var body: some View {
        TabView {
            STHomeContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        STRootTabContentView()
    }
}
