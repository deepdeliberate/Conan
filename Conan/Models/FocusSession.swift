//
//  FocusSession.swift
//  Conan
//
//  Created by Naman Deep on 25/02/26.
//

import Foundation

struct FocusSession: Codable, Identifiable {
    let id: UUID
    let date: Date
    let duration: Int // in seconds
    let tag: UUID
}
