//
//  ChecklistItem.swift
//  MixApp
//
//  Created by Dastan Mambetaliev on 22/2/21.
//

import Foundation

class ChecklistItem: NSObject  {
    
    var text = ""
    var desc = ""
    var checked = false
    
    func toggleChecked() {
    checked = !checked
    }
    
}
