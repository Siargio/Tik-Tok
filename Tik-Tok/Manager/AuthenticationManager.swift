//
//  AuthenticationManager.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()

    private init() {}

    enum SingInMethod {
        case email
        case facebook
        case google
    }

    //Public

    public func singIn(with method: SingInMethod) {

    }
    
    public func singOut() {

    }
}
