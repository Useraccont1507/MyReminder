//
//  TextFieldViews.swift
//  MyReminder
//
//  Created by User on 11.09.2024.
//

import SwiftUI

struct TextFieldTitleView: View {
  @Binding var text: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("title".localized.localizedCapitalized)
      TextField("add_text_here".localized, text: $text)
        .textFieldStyle(.automatic)
        .onChange(of: text) { newValue in
          if newValue.count > 18 {
            text = String(newValue.prefix(18))
          }
        }
    }
  }
}

struct TextFieldBodyView: View {
  @Binding var text: String?
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("body".localized)
      TextField("add_text_here".localized, text: Binding(
        get: { text ?? "" },
        set: { newValue in
          text = newValue.isEmpty ? nil : newValue
        }
      ))
      .textFieldStyle(.automatic)
      .onChange(of: text ?? "") { newValue in
        if newValue.count > 50 {
          text = String(newValue.prefix(50))
        }
      }
    }
  }
}

#Preview {
  TextFieldTitleView(text: .constant(""))
}
