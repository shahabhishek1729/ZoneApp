////
////  ProfileView.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////
//
import SwiftUI
//
//
//// MARK:- PROFILE (scroll enabled)
//struct ProfileView: View {
//    @State private var notifications = true
//    @State private var darkMode      = false
//    @State private var soundFx       = true
//
//    var body: some View {
//        NavigationStack {
//            ScrollView(.vertical, showsIndicators: true) {        // ← scrollable
//                VStack(spacing: 20) {
//
//                    // Avatar & name
//                    VStack(spacing: 12) {
//                        Image(systemName: "person.crop.circle.fill")
//                            .resizable().scaledToFill()
//                            .frame(width: 100, height: 100)
//                            .clipShape(Circle())
//                        Text("Emily Johnson").font(.title2.bold())
//                        Text("emily.johnson@example.com")
//                            .font(.caption).foregroundColor(.textSecondary)
//                    }
//
//                    // Quick stats
//                    HStack(spacing: 12) {
//                        circular("24", "Day Streak")
//                        circular("12", "Achievements")
//                        circular("32h", "This Week")
//                    }
//
//                    // Premium banner
//                    Card {
//                        VStack(alignment: .leading, spacing: 6) {
//                            HStack {
//                                Text("Premium Plan")
//                                    .font(.subheadline.weight(.semibold))
//                                Spacer(); Badge(text: "Active")
//                            }
//                            Text("Valid until May 09, 2026")
//                                .font(.caption2).foregroundColor(.textSecondary)
//                            Button("Manage") {}
//                                .font(.caption.weight(.semibold))
//                                .padding(.horizontal, 12).padding(.vertical, 6)
//                                .background(RoundedRectangle(cornerRadius: 8)
//                                                .fill(Color.white.opacity(0.2)))
//                                .overlay(RoundedRectangle(cornerRadius: 8)
//                                            .stroke(Color.white.opacity(0.4)))
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity, alignment: .trailing)
//                        }
//                    }
//                    .background(LinearGradient(colors:[.primaryPurple,
//                                                        .primaryPurple.opacity(0.7)],
//                                               startPoint:.topLeading,
//                                               endPoint:.bottomTrailing))
//                    .cornerRadius(12)
//                    .foregroundColor(.white)
//
//                    // Personal goals
//                    Card {
//                        HStack {
//                            Text("Personal Goals")
//                                .font(.subheadline.weight(.semibold))
//                            Spacer()
//                            Button("View All") {}
//                                .font(.caption).foregroundColor(.primaryPurple)
//                        }
//                        ForEach(sampleGoals) { goal in
//                            VStack(alignment: .leading, spacing: 4) {
//                                HStack {
//                                    Text(goal.title)
//                                        .font(.callout.weight(.semibold))
//                                    Spacer()
//                                    Badge(text: goal.status.rawValue,
//                                          style: goal.status.badgeStyle)
//                                }
//                                HorizontalBar(progress: goal.progress,
//                                              tint: goal.status.barColor)
//                                    .frame(height: 6)
//                                HStack {
//                                    Text(String(format: "%0.0f / %0.0f",
//                                                goal.current, goal.target))
//                                        .font(.caption2)
//                                        .foregroundColor(.textSecondary)
//                                    Spacer()
//                                    Text("\(goal.daysLeft) days left")
//                                        .font(.caption2)
//                                        .foregroundColor(.textSecondary)
//                                }
//                            }
//                            .padding(.vertical, 6)
//                        }
//                        Button { /* new goal */ } label: {
//                            HStack {
//                                Image(systemName: "plus")
//                                Text("Add New Goal")
//                            }
//                            .font(.caption.weight(.semibold))
//                            .frame(maxWidth: .infinity)
//                            .padding(8)
//                            .overlay(RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.primaryPurple))
//                        }
//                        .padding(.top, 4)
//                    }
//
//                    // Toggles
//                    Card {
//                        Text("Settings & Preferences")
//                            .font(.subheadline.weight(.semibold))
//                        Toggle("Notifications", isOn: $notifications)
//                            .toggleStyle(SwitchToggleStyle(tint: .primaryPurple))
//                        Toggle("Dark Mode", isOn: $darkMode)
//                            .toggleStyle(SwitchToggleStyle(tint: .primaryPurple))
//                        Toggle("Sound Effects", isOn: $soundFx)
//                            .toggleStyle(SwitchToggleStyle(tint: .primaryPurple))
//                    }
//
//                    // Connected devices
//                    Card {
//                        HStack {
//                            Text("Connected Devices")
//                                .font(.subheadline.weight(.semibold))
//                            Spacer()
//                            Button("Add Device") {}
//                                .font(.caption).foregroundColor(.primaryPurple)
//                        }
//                        ForEach(sampleDevices) { dev in
//                            HStack(spacing: 12) {
//                                Image(systemName: dev.icon)
//                                    .frame(width: 24, height: 24)
//                                VStack(alignment: .leading, spacing: 2) {
//                                    Text(dev.name)
//                                        .font(.callout.weight(.semibold))
//                                    Text(dev.subtitle)
//                                        .font(.caption2).foregroundColor(.textSecondary)
//                                }
//                                Spacer()
//                                if dev.primary { Badge(text: "Primary", style:.neutral) }
//                                Image(systemName: "ellipsis")
//                                    .foregroundColor(.textSecondary)
//                            }
//                            .padding(.vertical, 6)
//                        }
//                    }
//
//                    // Account management
//                    Card {
//                        Text("Account Management")
//                            .font(.subheadline.weight(.semibold))
//                        navRow("Privacy Settings")
//                        navRow("Data & Storage")
//                        navRow("Security")
//                        navRow("Log Out", tint: .errorRed)
//                    }
//
//                    // Help & support
//                    Card {
//                        Text("Help & Support")
//                            .font(.subheadline.weight(.semibold))
//                        navRow("FAQ")
//                        navRow("Contact Support")
//                        navRow("Terms & Privacy Policy")
//                        navRow("About", trailing: "Version 2.4.1")
//                    }
//
//                }
//                .padding()
//            }
//            .navigationTitle("")
//            .toolbar { ToolbarItem(placement: .navigationBarLeading) { Logo() } }
//            .background(Color.bgMain)
//        }
//    }
//
//    // Profile helpers
//    private func circular(_ v:String,_ l:String)->some View {
//        VStack(spacing:4){
//            Text(v).font(.headline.bold())
//            Text(l).font(.caption).foregroundColor(.textSecondary)
//        }
//        .frame(maxWidth:.infinity)
//        .padding(12)
//        .background(Color.bgCard)
//        .cornerRadius(10)
//    }
//    private func navRow(_ t:String,
//                        tint:Color = .textPrimary,
//                        trailing:String? = nil)->some View {
//        HStack {
//            Text(t).foregroundColor(tint)
//            Spacer()
//            if let tr = trailing {
//                Text(tr).font(.caption).foregroundColor(.textSecondary)
//            }
//            Image(systemName: "chevron.right")
//                .foregroundColor(.textSecondary)
//        }
//        .padding(.vertical, 8)
//    }
//}
// MARK:- PROFILE (scroll enabled)
struct ProfileView: View {
    @State private var notifications = true
    @State private var soundFx       = true
    @State private var goals: [Goal] = sampleGoals
    @State private var showNewGoalSheet = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {        // ← scrollable
                VStack(spacing: 20) {
                    // Avatar & name
                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable().scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Text("Emily Johnson").font(.title2.bold())
                        Text("emily.johnson@example.com")
                            .font(.caption).foregroundColor(.textSecondary)
                    }
                    // Quick stats
                    HStack(spacing: 12) {
                        circular("24", "Day Streak")
                        circular("12", "Achievements")
                        circular("32h", "This Week")
                    }
                    // Premium banner
                    Card {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Premium Plan")
                                    .font(.subheadline.weight(.semibold))
                                Spacer(); Badge(text: "Active")
                            }
                            Text("Valid until May 09, 2026")
                                .font(.caption2).foregroundColor(.textSecondary)
                            Button("Manage") {}
                                .font(.caption.weight(.semibold))
                                .padding(.horizontal, 12).padding(.vertical, 6)
                                .background(RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white.opacity(0.2)))
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white.opacity(0.4)))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .background(LinearGradient(colors:[.primaryPurple,
                                                        .primaryPurple.opacity(0.7)],
                                               startPoint:.topLeading,
                                               endPoint:.bottomTrailing))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    // Personal goals
                    Card {
                        HStack {
                            Text("Personal Goals")
                                .font(.subheadline.weight(.semibold))
                            Spacer()
                            Button("View All") {}
                                .font(.caption).foregroundColor(.primaryPurple)
                        }
                        ForEach(goals) { goal in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(goal.title)
                                        .font(.callout.weight(.semibold))
                                    Spacer()
                                    Badge(text: goal.status.rawValue,
                                          style: goal.status.badgeStyle)
                                }
                                HorizontalBar(progress: goal.progress,
                                              tint: goal.status.barColor)
                                    .frame(height: 6)
                                HStack {
                                    Text(String(format: "%0.0f / %0.0f",
                                                goal.current, goal.target))
                                        .font(.caption2)
                                        .foregroundColor(.textSecondary)
                                    Spacer()
                                    Text("\(goal.daysLeft) days left")
                                        .font(.caption2)
                                        .foregroundColor(.textSecondary)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                        Button {
                            showNewGoalSheet = true
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add New Goal")
                            }
                            .font(.caption.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primaryPurple))
                        }
                        .padding(.top, 4)
                        .sheet(isPresented: $showNewGoalSheet) {
                            NewGoalPickerView { selectedGoal in
                                let newGoal = Goal(
                                    title: selectedGoal,
                                    progress: 0,
                                    current: 0,
                                    target: 100,
                                    daysLeft: 30,
                                    status: .onTrack
                                )
                                goals.append(newGoal)
                            }
                            .presentationDetents([.fraction(0.65)])
                        }
                    }
                    // Toggles
                    Card {
                        Text("Settings & Preferences")
                            .font(.subheadline.weight(.semibold))
                        Toggle("Notifications", isOn: $notifications)
                            .toggleStyle(SwitchToggleStyle(tint: .primaryPurple))
                        Toggle("Sound Effects", isOn: $soundFx)
                            .toggleStyle(SwitchToggleStyle(tint: .primaryPurple))
                    }
                    // Connected devices
                    Card {
                        HStack {
                            Text("Connected Devices")
                                .font(.subheadline.weight(.semibold))
                            Spacer()
                            Button("Add Device") {}
                                .font(.caption).foregroundColor(.primaryPurple)
                        }
                        ForEach(sampleDevices) { dev in
                            HStack(spacing: 12) {
                                Image(systemName: dev.icon)
                                    .frame(width: 24, height: 24)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(dev.name)
                                        .font(.callout.weight(.semibold))
                                    Text(dev.subtitle)
                                        .font(.caption2).foregroundColor(.textSecondary)
                                }
                                Spacer()
                                if dev.primary { Badge(text: "Primary", style:.neutral) }
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.textSecondary)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    // Account management
                    Card {
                        Text("Account Management")
                            .font(.subheadline.weight(.semibold))
                        navRow("Privacy Settings")
                        navRow("Data & Storage")
                        navRow("Security")
                        navRow("Log Out", tint: .errorRed)
                    }
                    // Help & support
                    Card {
                        Text("Help & Support")
                            .font(.subheadline.weight(.semibold))
                        navRow("FAQ")
                        navRow("Contact Support")
                        navRow("Terms & Privacy Policy")
                        navRow("About", trailing: "Version 2.4.1")
                    }
                }
                .padding()
            }
            .navigationTitle("")
            .toolbar { ToolbarItem(placement: .navigationBarLeading) { Logo() } }
            .background(Color.bgMain)
        }
    }
    // Profile helpers
    private func circular(_ v:String,_ l:String)->some View {
        VStack(spacing:4){
            Text(v).font(.headline.bold())
            Text(l).font(.caption).foregroundColor(.textSecondary)
        }
        .frame(maxWidth:.infinity)
        .padding(12)
        .background(Color.bgCard)
        .cornerRadius(10)
    }
    private func navRow(_ t:String,
                        tint:Color = .textPrimary,
                        trailing:String? = nil)->some View {
        HStack {
            Text(t).foregroundColor(tint)
            Spacer()
            if let tr = trailing {
                Text(tr).font(.caption).foregroundColor(.textSecondary)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.textSecondary)
        }
        .padding(.vertical, 8)
    }
}
