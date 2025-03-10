//
//  DatabaseHelper.swift
//  Assignment
//
//  Created by Keval Thumar on 26/02/25.
//

import Foundation
import SQLite3
import UIKit

class DatabaseHelper {
    static let shared = DatabaseHelper()
    var db: OpaquePointer?

    private init() {
        self.openDatabase()
        self.createTable()
    }

    // Open Database
    func openDatabase() {
        guard
            let fileURL = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("UserData.sqlite")
        else {
            return
        }

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Failed to open database")
        } else {
            print("Database opened successfully at \(fileURL.path)")
        }
    }

    // Create Table
    func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS User(
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        firstName TEXT,
                        lastName TEXT,
                        height TEXT,
                        birthDate TEXT,
                        gender TEXT,
                        email TEXT UNIQUE
                    );
            """

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil)
            == SQLITE_OK
        {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table created successfully")
            } else {
                print("Table creation failed")
            }
        }
        sqlite3_finalize(statement)
    }

    func checkUserExists(email: String) -> Bool {
        let query = "SELECT COUNT(*) FROM User WHERE email = ?;"
        var statement: OpaquePointer?

        let email_String = email.cString(using: .utf8)

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, email_String, -1, nil)

            if sqlite3_step(statement) == SQLITE_ROW {
                let count = sqlite3_column_int(statement, 0)
                sqlite3_finalize(statement)
                return count > 0
            }
        }
        sqlite3_finalize(statement)
        return false
    }

    // Insert Data (Now returns true if successful, false if failed)
    func insertUser(
        firstName: String, lastName: String, height: String, birthDate: String,
        gender: String, email: String, viewController: UIViewController
    ) -> Bool {

        if checkUserExists(email: email) {
            AlertBoxExtension.shared.showAlert(
                title: "Error", message: "User already exists",
                viewController: viewController, style: .destructive)
            return false
        }
        
        let insertQuery =
            "INSERT INTO User (firstName, lastName, height, birthDate, gender) VALUES (?, ?, ?, ?, ?, ?);"

        var statement: OpaquePointer?

        let firstName_String = firstName.cString(using: .utf8)
        let lastName_String = lastName.cString(using: .utf8)
        let height_String = height.cString(using: .utf8)
        let birthDate_String = birthDate.cString(using: .utf8)
        let gender_String = gender.cString(using: .utf8)
        let email_String = email.cString(using: .utf8)

        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(statement, 1, firstName_String, -1, nil)
            sqlite3_bind_text(statement, 2, lastName_String, -1, nil)
            sqlite3_bind_text(statement, 3, height_String, -1, nil)
            sqlite3_bind_text(statement, 4, birthDate_String, -1, nil)
            sqlite3_bind_text(statement, 5, gender_String, -1, nil)
            sqlite3_bind_text(statement, 6, email_String, -1, nil)

            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            } else {
                sqlite3_finalize(statement)
                AlertBoxExtension.shared.showAlert(title: "Error", message: "Something went wrong!", viewController: viewController, style: .destructive)
                return false
            }
        } else {
            sqlite3_finalize(statement)
            AlertBoxExtension.shared.showAlert(title: "Error", message: "Something went wrong!", viewController: viewController, style: .destructive)
            return false
        }
    }

    //    Update User

    func updateUser(
        firstName: String, lastName: String, height: String, birthDate: String,
        gender: String, email: String, viewController: UIViewController
    ) -> Bool {

        let updateQuery = """
            UPDATE User 
            SET firstName = ?, lastName = ?, height = ?, birthDate = ?, gender = ? 
            WHERE email = ?;
            """

        var statement: OpaquePointer?

        let firstName_String = firstName.cString(using: .utf8)
        let lastName_String = lastName.cString(using: .utf8)
        let height_String = height.cString(using: .utf8)
        let birthDate_String = birthDate.cString(using: .utf8)
        let gender_String = gender.cString(using: .utf8)
        let email_String = email.cString(using: .utf8)

        if sqlite3_prepare_v2(db, updateQuery, -1, &statement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(statement, 1, firstName_String, -1, nil)
            sqlite3_bind_text(statement, 2, lastName_String, -1, nil)
            sqlite3_bind_text(statement, 3, height_String, -1, nil)
            sqlite3_bind_text(statement, 4, birthDate_String, -1, nil)
            sqlite3_bind_text(statement, 5, gender_String, -1, nil)
            sqlite3_bind_text(statement, 6, email_String, -1, nil)

            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            } else {
                sqlite3_finalize(statement)
                AlertBoxExtension.shared.showAlert(
                    title: "Error", message: "Failed to update data",
                    viewController: viewController, style: .destructive)
                return false
            }
        } else {
            sqlite3_finalize(statement)
            AlertBoxExtension.shared.showAlert(
                title: "Error", message: "Failed to prepare update query",
                viewController: viewController, style: .destructive)
            return false
        }
    }

    //    Get User
    
    func getUserData(email: String) -> (firstName: String, lastName: String, height: String, birthDate: String, gender: String)? {
        let query = "SELECT firstName, lastName, height, birthDate, gender FROM User WHERE email = ?;"
        var statement: OpaquePointer?
        let email_String = email.cString(using: .utf8)
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, email_String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_ROW {
                let firstName = String(cString: sqlite3_column_text(statement, 0))
                let lastName = String(cString: sqlite3_column_text(statement, 1))
                let height = String(cString: sqlite3_column_text(statement, 2))
                let birthDate = String(cString: sqlite3_column_text(statement, 3))
                let gender = String(cString: sqlite3_column_text(statement, 4))
                
                sqlite3_finalize(statement)
                return (firstName, lastName, height, birthDate, gender)
            }
        }
        
        sqlite3_finalize(statement)
        return nil
    }

}
