//
//  AddAssignmentView.swift
//  AssignmentNoteBook
//
//  Created by Zane Matarieh on 1/28/25.
//

import SwiftUI

struct AddAssignmentView: View {
    @ObservedObject var assignmentList: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueOn = Date()
    static let courses = ["Economics", "Math", "Science", "Computer Science", "English", "History", "World Language", "Fine Arts"]
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in Text(course)}
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueOn, displayedComponents: .date)
            }
            .scrollContentBackground(.hidden)
            .background(Color(red: 1.0, green: 0.95, blue: 0.49))
            .navigationBarTitle("Add New To-Do Note", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if course.count > 0 && description.count > 0 {
                    let note = Note(id: UUID(), course: course, description: description, dueOn: dueOn)
                    assignmentList.Notes.append(note)
                    presentationMode.wrappedValue.dismiss()
                }
            })
            .background(.yellow)
        }
    }
}

#Preview {
    AddAssignmentView(assignmentList: AssignmentList())
}
