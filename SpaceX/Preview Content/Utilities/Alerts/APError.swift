//
//  APError.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import Foundation

enum APError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
