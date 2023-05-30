//
//  SwitchCellViewModel.swift
//  Tik-Tok
//
//  Created by Sergio on 30.05.23.
//

import Foundation

struct SwitchCellViewModel {
    let title: String
    var isOn: Bool

    mutating func setOn(_ on: Bool) {
        self.isOn = on
    }
}
