//
//  PinTextField.swift
//  DooDooIOS
//
//  Created by Артем Лавров on 25.03.2022.
//

import SwiftUI
import UIKit
import Foundation

struct PinTextField: View {
    @Binding var text: String
    let count: Int
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(0..<self.count) { index in
                    Text(String(index < text.count ? Array(text)[index] : "-"))
                }
            }
            UIPinKeyInputRepresentable(text: $text, count: count)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct UIPinKeyInputRepresentable : UIViewRepresentable {
    @Binding var text: String
    let count: Int
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        return
    }
    
    func makeUIView(context: Context) -> some UIView {
        return UIPinKeyInput(text: $text, count: count)
    }
}

class UIPinKeyInput : UIControl, UIKeyInput {
    @Binding var text: String
    let count: Int
    
    var hasText: Bool { !text.isEmpty }
    
    override var canBecomeFirstResponder: Bool { true }
    
    @objc private func onTap(_: AnyObject) {
        becomeFirstResponder()
    }
    
    var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        }
        set {
            
        }
    }
    
    init(text: Binding<String>, count: Int) {
        self._text = text
        self.count = count
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
        becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func insertText(_ text: String) {
        self.text += text.prefix(self.count - self.text.count)
        if self.text.count == self.count {
            resignFirstResponder()
        }
    }
    
    func deleteBackward() {
        if hasText {
            _ = self.text.popLast()
        }
    }
}

struct PinTextField_Previews: PreviewProvider {
    static var previews: some View {
        var value = "1234"
        Group {
            PinTextField(text: Binding(get: {value}, set: {value=$0}), count: 4)
        }
    }
}
