//
//  Model.swift
//  MiniWeatherApp
//
//  Created by Денис Ефименков on 10.03.2025.
//

import Foundation

struct UserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let dob: Dob
    let phone: String
    let cell: String
    let picture: Picture
    let nat: String
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: String
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Dob: Codable {
    let date: String
    let age: Int
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
