//
//  GridView.swift
//  MyReminder
//
//  Created by User on 01.09.2024.
//

import SwiftUI

struct ComponentView: View {
  var labelText: String
  var labelCount: Int
  var systemImageName: String
  var imageForegroundColor: Color
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundStyle(.componentView)
      VStack(alignment: .leading) {
        HStack {
          Image(systemName: systemImageName)
            .resizable()
            .frame(maxWidth: 34, maxHeight: 34)
            .foregroundStyle(imageForegroundColor)
          Spacer()
          Text(String(labelCount))
            .font(.title)
        }
        .padding()
        Text(labelText)
          .font(.headline)
          .foregroundStyle(.gray)
          .padding(.bottom)
          .padding(.leading)
      }
    }
  }
}

#Preview {
  ComponentView(labelText: "Today", labelCount: 1, systemImageName: "calendar.circle.fill", imageForegroundColor: .red)
}
