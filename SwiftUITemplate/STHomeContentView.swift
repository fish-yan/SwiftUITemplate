//
//  STHomeContentView.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/11/23.
//

import SwiftUI

struct STSectionModel {
    var title: String
    var widgets: [STWidgetModel]
}

struct STWidgetModel {
    var title: String
    var content: any View
}

struct STHomeContentView: View {
    let data = [
        STSectionModel(title: "Controls", widgets: [
            STWidgetModel(title: "Text", content: STText()),
            STWidgetModel(title: "TextField", content: STTextField())
        ]),
        STSectionModel(title: "Example", widgets: [
            STWidgetModel(title: "Number", content: STNumberView()),
            STWidgetModel(title: "Segment", content: STSegmentView())
        ])
    ]
    let a = 5
    var body: some View {
        NavigationView {
            List(data, id: \.title) { ele in
                Section(header: Text(ele.title).textCase(.none)) {
                    ForEach(ele.widgets, id: \.title) { widget in
                        NavigationLink {
                            AnyView(widget.content)
                        } label: {
                            Text(widget.title)
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        STHomeContentView()
    }
}
