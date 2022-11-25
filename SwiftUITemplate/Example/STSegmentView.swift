//
//  STSegmentView.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/11/24.
//

import SwiftUI

struct STSegmentView: View {
    let titles = ["关注", "推荐", "热点", "热榜", "疫情", "世界杯", "科技", "数码", "军事", "历史"]
    @State var selectedIndex = 0
    @State var rects: [Anchor<CGRect>] = []
    private var selectedRect: Anchor<CGRect> {
        return rects[selectedIndex]
    }
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(titles.enumerated()), id: \.element) { (index, title) in
                        STSegmentItemView(text: title, index: index, selectedIndex: $selectedIndex)
                    }
                }
                .backgroundPreferenceValue(STSegmentPreferenceKey.self) { preferences in
                    GeometryReader { prox in
                        makeBottomLine(prox, preferences: preferences)
                    }
                }
            }
            Spacer()
        }
    }

    func makeBottomLine(_ prox: GeometryProxy, preferences: [STSegmentPreferenceValue]) -> some View {
        let anch = preferences[selectedIndex].rect
        let rect = prox[anch]
        return LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: rect.width - 20, height: 4)
            .cornerRadius(2)
            .offset(x: rect.minX + 10, y: rect.height - 4)
            .animation(.easeInOut, value: rect)
    }
}

struct STSegmentPreferenceValue: Equatable {
    var index: Int
    var rect: Anchor<CGRect>
}

struct STSegmentPreferenceKey: PreferenceKey {
    static var defaultValue: [STSegmentPreferenceValue] = []

    static func reduce(value: inout [STSegmentPreferenceValue], nextValue: () -> [STSegmentPreferenceValue]) {
        value.append(contentsOf: nextValue())
    }

    typealias Value = [STSegmentPreferenceValue]
}

struct STSegmentItemView: View {
    let text: String
    let index: Int
    @Binding var selectedIndex: Int
    var body: some View {
        Text(text)
            .font(.title2)
            .padding(10)
            .scaleEffect(index == selectedIndex ? 1.3 : 1)
            .foregroundColor(index == selectedIndex ? .primary : .gray)
            .anchorPreference(key: STSegmentPreferenceKey.self, value: .bounds, transform: {[STSegmentPreferenceValue(index: index, rect: $0)]})
            .onTapGesture {
                selectedIndex = index
            }
            .animation(.easeInOut, value: index == selectedIndex)
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        STSegmentView()
    }
}
