//
//  String+Extensions.swift
//  MyReminder
//
//  Created by User on 07.09.2024.
//

import Foundation

extension String {
  var localized: String {
    NSLocalizedString(self, comment: "\(self) could not be found in Localizable.string")
  }
  
  func localizedPlural(_ arg: Int) -> String {
    let formatString = NSLocalizedString(self, comment: "\(self) could not be found in Localizable.stringdict")
    return Self.localizedStringWithFormat(formatString, arg)
  }
}
