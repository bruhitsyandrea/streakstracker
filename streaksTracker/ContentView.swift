//
//  ContentView.swift
//  streaksTracker
//
//  Created by Andrea Chen on 2024/3/29.
//

import SwiftUI

struct ContentView: View {
    @State var selectedDate: Date = Date()
    @State private var showDetailView = false
    @State private var addMode = false

    var body: some View {
        NavigationView {
            VStack {
                CalendarViewRepresentable(selectedDate: $selectedDate, showDetailView: $showDetailView)
                    .padding()
                    .background(Color(.systemBackground))
                    .edgesIgnoringSafeArea(.all)
                    .sheet(isPresented: $showDetailView) {
                        DetailView(date: $selectedDate)
                    }

                Spacer()

                Button(action: {
                    self.addMode = true
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
                .sheet(isPresented: $addMode) {
                    AddDetailView(existingItem: nil, selectedDate: $selectedDate)
                }
            }
            .navigationBarTitle("Calendar", displayMode: .inline)
        }
    }
}

struct AddDetailView: View {
    @State var existingItem: ListItem?
    @Binding var selectedDate: Date
    @State private var activityNotes: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Activity for \(selectedDate.formatted(date: .long, time: .omitted))")
                    .font(.headline)
                    .padding()

                TextEditor(text: $activityNotes)
                    .border(Color.gray, width: 1)
                    .padding()

                Button(action: {
                    // Save activity notes logic here
                    print("Activity notes saved for \(selectedDate): \(activityNotes)")
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Activity Details")
        }
    }
}

struct DetailView: View {
    @Binding var date: Date
    @State private var activityNotes: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Activity for \(date.formatted(date: .long, time: .omitted))")
                    .font(.headline)
                    .padding()

                TextEditor(text: $activityNotes)
                    .border(Color.gray, width: 1)
                    .padding()

                Button(action: {
                    // Save activity notes logic here
                    print("Activity notes saved for \(date): \(activityNotes)")
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Activity Details")
        }
    }
}

#Preview {
    ContentView()
}
