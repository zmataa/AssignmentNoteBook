//
//  AssignmentList.swift
//  AssignmentNoteBook
//
//  Created by Zane Matarieh on 1/28/25.
//

import Foundation
class AssignmentList: ObservableObject {
    @Published var Notes : [Note] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(Notes) {
                UserDefaults.standard.set(encodedData, forKey: "data")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "data") {
            if let decodedData = try? JSONDecoder().decode([Note].self, from: data) {
                Notes = decodedData
                return
            }
        }
        Notes = []
    }
}

 
