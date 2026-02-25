//
//  FocusStore.swift
//  Conan
//
//  Created by Naman Deep on 25/02/26.
//

import Foundation

class FocusStore {
    static let shared = FocusStore()
    
    private let fileURL: URL
    
    private init() {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        fileURL = documents.appendingPathComponent("focus_sessions.json")
        
        print("File path: ", fileURL.path)
    }
    
    // MARK: - Save Session
    func addSession(duration: Int){
        var sessions = loadSessions()
        
        let newSession = FocusSession(
            id: UUID(),
            date: Date(),
            duration: duration
        )
        
        sessions.append(newSession)
        saveSession(sessions)
    }
    
    // MARK: - Load
    func loadSessions() -> [FocusSession] {
        do {
            let data = try Data(contentsOf: fileURL)
            let sessions = try JSONDecoder().decode([FocusSession].self, from: data)
            print("Loaded sessions: ", sessions.count)
            
            return sessions
        } catch {
            print("Load ERROR:", error.localizedDescription)
            return []
        }
        
    }
    
    // MARK: - Save
    
    private func saveSession(_ sessions: [FocusSession]) {
        do {
            let data = try JSONEncoder().encode(sessions)
            try data.write(to: fileURL)
            print("Saved sessions:", sessions.count)
        } catch {
            print("Save ERROR", error.localizedDescription)
        }
    }
}
