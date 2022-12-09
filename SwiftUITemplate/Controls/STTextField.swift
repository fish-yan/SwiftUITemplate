//
//  STTextField.swift
//  SwiftUITemplate
//
//  Created by 薛焱 on 2022/12/9.
//

import SwiftUI

struct STTextField: View {
    @State var text = ""
    @State var textColor: Color = .black
    @State var fontSize: Int = 16
    @State var alignment: TextAlignment = .leading
    var body: some View {
        VStack {
            List {
                TextField(text: $text, prompt: Text("input a text"), label: {
                    Text("aaaa")
                })
                .frame(height: 100)
                .font(.system(size: CGFloat(fontSize)))
                .foregroundColor(textColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color(UIColor.separator), lineWidth: 2)
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textFieldStyle(.plain)
                .multilineTextAlignment(alignment)
                .keyboardType(.numberPad)
                .deleteDisabled(false)
                .toolbarRole(.editor)
                .onChange(of: text) { newValue in
                    print(text)
                }
                .onSubmit {
                    print(text)
                }
                SecureField("Secure Field", text: $text)
                    .bold()

                Section("Basic") {
                    ColorPicker("Color", selection: $textColor)
                    Stepper("Font：\(fontSize)", value: $fontSize, in: 10...40)
                    Picker("Aligment", selection: $alignment) {
                        Text("leading").tag(TextAlignment.leading)
                        Text("center").tag(TextAlignment.center)
                        Text("trailing").tag(TextAlignment.trailing)
                    }
                    .pickerStyle(.automatic)
                }
                .textCase(.none)
            }
        }
        .navigationTitle("TextField")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct STTextField_Previews: PreviewProvider {
    static var previews: some View {
        STTextField()
    }
}
