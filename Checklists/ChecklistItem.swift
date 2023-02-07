//
//  ChecklistItem.swift
//  Checklists
//
//  Created by HQ on 2023/2/6.
//

import Foundation

class ChecklistItem {
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked.toggle()
  }
}
