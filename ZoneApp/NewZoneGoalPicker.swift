//
//  NewZoneGoalPicker.swift
//  ZoneApp
//
//  Created by Abhishek on 6/7/25.
//
import SwiftUI

// MARK:- NewGoalPickerView
struct NewGoalPickerView: View {
    var onSave: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var selectedGoal: String? = nil
    private let goalOptions = [
        "Complete 40 hours of focus",
        "Maintain 7-day focus streak",
        "Reduce distractions by 50%",
        "Block apps for 4h/day",
        "Limit social media to 30m/day"
    ]
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Select a Goal")
                    .font(.headline)
                    .padding(.top)
                ForEach(goalOptions, id: \.self) { option in
                    Button(action: {
                        selectedGoal = option
                    }) {
                        HStack {
                            Text(option)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedGoal == option {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.primaryPurple)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedGoal == option ? Color.primaryPurple.opacity(0.1) : Color.clear)
                        )
                    }
                }
                Spacer()
                Button("Save") {
                    if let goal = selectedGoal {
                        onSave(goal)
                        dismiss()
                    }
                }
                .disabled(selectedGoal == nil)
                .padding()
                .frame(maxWidth: .infinity)
                .background(selectedGoal == nil ? Color.gray : Color.primaryPurple)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationTitle("New Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
