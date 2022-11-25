//
//  STTextCode.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/11/24.
//

import SwiftUI

struct STTextCode: View {
    let content = #"""
        ```swift
        struct STTextConfig {
            var color = Color(red: 0, green: 0, blue: 0)
            var fontSize = 16
            var isUnderline = false
            var isItalic = false
        }

        struct STText: View {
            @State var config = STTextConfig()
            @State var dateStyleName = "date"
            private var now: Date { Date() }
            private var future: Date { now.addingTimeInterval(3600) }
            private let dateStyles: [String] = ["date", "time", "offset", "timer", "relative", "range", "interval"]
            private var dateStyle: Text.DateStyle {
            switch dateStyleName {
                case "date":
                    return .date
                case "time":
                    return .time
                case "offset":
                    return .offset
                case "timer":
                    return .timer
                case "relative":
                    return .relative
                default:
                    return .date
                }
            }
            var body: some View {
                VStack {
                    List {
                        HStack {
                            Spacer()
                            Text("Hello, World!")
                                .frame(height: 100)
                                .foregroundColor(config.color)
                                .font(Font.system(size: CGFloat(config.fontSize)))
                                .underline(config.isUnderline)
                                .italic(config.isItalic)
                            // foregroundStyle 与 foregroundColor 冲突，谁在前谁起作用
                                .foregroundStyle(.linearGradient(colors: [.orange, .yellow, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Spacer()
                        }
                        // basic
                        Section("Basic") {
                            ColorPicker("Color", selection: $config.color)
                            Stepper("Font：\(config.fontSize)", value: $config.fontSize, in: 10...40)
                        }
                        .textCase(.none)
                        // advance
                        Section("Advance") {
                            Toggle("Underline", isOn: $config.isUnderline)
                            Toggle("Italic", isOn: $config.isItalic)
                        }
                        .textCase(.none)
                        Section("Date") {
                            HStack {
                                if (dateStyleName == "range") {
                                    Text(now...future)
                                } else if (dateStyleName == "interval") {
                                    Text(DateInterval(start: now, end: future))
                                } else {
                                    Text(now, style: dateStyle)
                                }
                                Picker("", selection: $dateStyleName) {
                                    ForEach(dateStyles, id: \\.self) {
                                        Text("\($0)")
                                    }
                                }
                            }
                        }
                        .textCase(.none)
                        Section("AttributeText") {
                            (Text(" Hello ")
                                .foregroundColor(.blue)
                                .font(.title2)
                             + Text(" \(Image(systemName: "swift"))")
                                .font(.title)
                             + Text(" is amazing")
                                .italic())
                            .foregroundStyle(.linearGradient(colors: [.red, .orange, .yellow, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                        .textCase(.none)
                    }
                }
                .navigationTitle("Text")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    HStack {
                        NavigationLink {
                            STTextCode()
                        } label: {
                            Image(systemName: "terminal")
                        }
                    }
                }
            }
        }
        ```
        """#
    var body: some View {
        STCodeView(content)
    }
}

struct STTextCode_Previews: PreviewProvider {
    static var previews: some View {
        STTextCode()
    }
}
