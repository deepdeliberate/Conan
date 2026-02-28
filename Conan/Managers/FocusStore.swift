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
    
    private let tagsKey = "focus_tags.json"
    private let tagsURL: URL
    
    private init() {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        fileURL = documents.appendingPathComponent("focus_sessions.json")
        tagsURL = documents.appendingPathComponent(tagsKey)
        
        createDefaultTagsIfNeeded()
        
        #if DEBUG
        createSampleSessionsIfNeeded()
        #endif
    }
    
    // MARK: - Default Tags Creation Once
    private func createDefaultTagsIfNeeded() {
        if FileManager.default.fileExists(atPath: tagsURL.path){
            return
        }
        
        let defaults: [FocusTag] = [
            FocusTag(id: UUID(), name: "Work", colorHex: "#007AFF" ), // Blue
            FocusTag(id: UUID(), name: "Study", colorHex: "#34C759" ), // Green
            FocusTag(id: UUID(), name: "Deep Focus", colorHex: "#AF52DE" )  // Purple
        ]
        
        saveTags(defaults)
    }
    
    // MARK: - Tags functions
    func loadTags() -> [FocusTag] {
        do {
            let data = try Data(contentsOf: tagsURL)
            return try JSONDecoder().decode([FocusTag].self, from: data)
        }catch {
            return []
        }
    }
    
    func saveTags(_ tags: [FocusTag]){
        do{
            let data = try JSONEncoder().encode(tags)
            try data.write(to: tagsURL)
        }catch {
            print("Tag save error:", error)
        }
    }
    
    // MARK: - Save Session
    func addSession(duration: Int, tag: UUID){
        var sessions = loadSessions()
        
        let newSession = FocusSession(
            id: UUID(),
            date: Date(),
            duration: duration,
            tag: tag
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
    
    // MARK: - Sample Data
    private func generateSampleSessions() -> [FocusSession] {
        let tags = loadTags()
        guard let work = tags.first else {return [] }
        
        let sampleSessions: [FocusSession] = [
            FocusSession(id: UUID(), date: Date().addingTimeInterval(-3600), duration: 25*60, tag: work.id),
            FocusSession(id: UUID(), date: Date().addingTimeInterval(-7200), duration: 45*60, tag: work.id),
            FocusSession(id: UUID(), date: Date().addingTimeInterval(-86400), duration: 30*60, tag: work.id)
            ]
        
        return sampleSessions
    }
    
    private func createSampleSessionsIfNeeded(){
        if FileManager.default.fileExists(atPath: fileURL.path){
            return
        }
        let samples = generateSampleSessions()
        saveSession(samples)
    }
}
