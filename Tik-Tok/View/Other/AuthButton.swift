//
//  AuthButton.swift
//  Tik-Tok
//
//  Created by Sergio on 19.05.23.
//

import UIKit

class AuthButton: UIButton {

    enum ButtonType {
        case singIng
        case singUp
        case plain

        var title: String {
            switch self {
            case .singIng: return "Sing In"
            case .singUp: return "Sing Up"
            case .plain: return "-"
            }
        }
    }

    let type: ButtonType

    init(type: ButtonType, title: String?) {
        self.type = type
        super.init(frame: .zero)
        if let title = title {
            setTitle(title, for: .normal)
        }
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        if type != .plain {
            setTitle(type.title, for: .normal)
        }
        setTitleColor(.white, for: .normal)
        switch type {
        case .singIng: backgroundColor = .systemBlue
        case .singUp: backgroundColor = .systemGreen
        case .plain:
            setTitleColor(.link, for: .normal)
            backgroundColor = .clear
        }

        titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
