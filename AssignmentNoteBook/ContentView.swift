import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.Notes) { item in
                    AssignmentRow(item: item) // Use a separate row view
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.Notes.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.Notes.remove(atOffsets: indexSet)
                })
            }
            .scrollContentBackground(.hidden)
            .background(Color(red: 1.0, green: 0.95, blue: 0.49))
            .navigationBarTitle("AssignmentNoteBook", displayMode: .inline)
            .sheet(isPresented: $showingAddAssignmentView) {
                AddAssignmentView(assignmentList: assignmentList)
            }
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: { showingAddAssignmentView = true }) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

struct AssignmentRow: View {
    var item: Note

    var body: some View {
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

#Preview {
    ContentView()
}

struct Note: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueOn = Date()
}
