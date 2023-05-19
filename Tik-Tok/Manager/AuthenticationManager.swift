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

    enum AuthError: Error {
        case signInFailed
    }

    //Public

    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }

    public func singIn(with email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(AuthError.signInFailed))
                }
                return
            }

            // Success full sing in
            completion(.success(email))
        }
    }

    public func singUp(with username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        // MAKE sure entered username is available

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }

            DatabaseManager.shared.insertUser(with: email, username: username, completion: completion)
        }
    }
    
    public func singOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        }
        catch {
            print(error)
            completion(false)
        }
    }
}
