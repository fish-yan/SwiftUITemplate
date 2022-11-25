//
//  STNumberView.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/11/24.
//

import SwiftUI

struct STNumberView: View {
    @State private var activeNumber: Int = 1
    @State private var rects: [CGRect] = Array<CGRect>(repeating: .zero, count: 9)
    private var currentRect: CGRect {
        return rects[activeNumber - 1]
    }
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                HStack {
                    STNumberItemView(activeNumber: $activeNumber, number: 1)
                    STNumberItemView(activeNumber: $activeNumber, number: 2)
                    STNumberItemView(activeNumber: $activeNumber, number: 3)
                }
                HStack {
                    STNumberItemView(activeNumber: $activeNumber, number: 4)
                    STNumberItemView(activeNumber: $activeNumber, number: 5)
                    STNumberItemView(activeNumber: $activeNumber, number: 6)
                }
                HStack {
                    STNumberItemView(activeNumber: $activeNumber, number: 7)
                    STNumberItemView(activeNumber: $activeNumber, number: 8)
                    STNumberItemView(activeNumber: $activeNumber, number: 9)
                }
            }
            Circle()
                .stroke(Color.green, lineWidth: 5)
                .frame(width: currentRect.width, height: currentRect.height)
                .offset(x: currentRect.minX, y: currentRect.minY)
                .animation(.easeInOut, value: currentRect)
        }
        .onPreferenceChange(NumberPreferenceKey.self) { preferences in
            for pre in preferences {
                rects[pre.index] = pre.react
            }
        }
        .coordinateSpace(name: "ZStack")
    }
}

struct NumberPreferenceValue: Equatable {
    var index: Int
    var react: CGRect
}

struct NumberPreferenceKey: PreferenceKey {
    static var defaultValue: [NumberPreferenceValue] = []

    static func reduce(value: inout [NumberPreferenceValue], nextValue: () -> [NumberPreferenceValue]) {
        value.append(contentsOf: nextValue())
    }

    typealias Value = [NumberPreferenceValue]


}

struct STNumberItemView: View {
    @Binding var activeNumber: Int
    let number: Int
    var body: some View {
        Text("\(number)")
            .font(.largeTitle)
            .frame(width: 100, height: 100)
            .bold()
            .background(
                GeometryReader { proxy in
                    Circle()
                        .stroke(Color.orange)
                        .preference(key: NumberPreferenceKey.self, value: [NumberPreferenceValue(index: number - 1, react: proxy.frame(in: .named("ZStack")))])
                }
            )
            .onTapGesture {
                activeNumber = number
            }
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        STNumberView()
    }
}
