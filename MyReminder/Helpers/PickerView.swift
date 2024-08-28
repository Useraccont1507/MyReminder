//
//  PickerView.swift
//  MyReminder
//
//  Created by User on 28.08.2024.
//

import SwiftUI

struct PickerView: View {
  @Binding var selection: PickerModel
  
    var body: some View {
      Picker("Show", selection: $selection) {
        Text("Show important").tag(PickerModel.important)
        Text("Show normal").tag(PickerModel.normal)
        Text("Show all").tag(PickerModel.all)
      }
      .pickerStyle(.menu)
    }
}

#Preview {
  PickerView(selection: .constant(.all))
}
