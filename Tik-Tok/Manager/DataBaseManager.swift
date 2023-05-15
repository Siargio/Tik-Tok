//
//  DataBaseManager.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()

    private init() {}

    //Public

    public func getAllUsers(completion: ([String]) -> Void) {

    }
}
