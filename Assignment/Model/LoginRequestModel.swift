//
//  LoginRequestModel.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import Foundation

struct LoginRequest: Codable {
    let userName: String
    let password: String
    let softwareType: String
    let releaseVersion: String
}
