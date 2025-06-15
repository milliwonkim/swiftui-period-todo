//
//  AddMonthlyGoalView.swift
//  Todo
//
//  Created by 김기원 on 6/14/25.
//

import SwiftData
import SwiftUI
import Foundation

struct AddMonthlyGoalView: View {
    @Environment(\.modelContext) private var modelContext
    @State var title: String = ""
    @State var description: String = ""
    var parentGoal: AnnualGoal
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section("제목") {
                    TextField("월간 목표 제목을 입력하세요", text: $title)
                }

                Section("내용") {
                    TextEditor(text: $description)
                        .frame(minHeight: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                
                Section("연결된 연간 목표") {
                    Text(parentGoal.title)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("월간 목표 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        saveMonthlyGoal()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveMonthlyGoal() {
        let newMonthlyGoal = MonthlyGoal(
            title: title,
            description: description,
            timestamp: Date(),
            type: .monthly,
            parentAnnualGoalId: parentGoal.id
        )
        modelContext.insert(newMonthlyGoal)
        isPresented = false
    }
} 