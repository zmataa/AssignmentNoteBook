
//
//  ContentView.swift
//  AssignmentNoteBook
//
//  Created by Zane Matarieh on 1/22/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.Notes) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueOn, style: .date)
                            .font(.subheadline)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            }
            
            .scrollContentBackground(.hidden)
            .background(Color(red: 1.0, green: 0.95, blue: 0.49))
            .navigationBarTitle("AssignmentNoteBook", displayMode: .inline)
            
            .sheet(isPresented: $showingAddAssignmentView, content: {
                AddAssignmentView(assignmentList: assignmentList)
            })
            .navigationBarItems(leading: EditButton(), trailing: Button(action : {
                showingAddAssignmentView = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

#Preview {
    ContentView()
}

struct Note: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueOn = Date()
}

