//
//  Item.swift
//  Todo
//
//  Created by 김기원 on 6/11/25.
//

import Foundation
import SwiftData

enum GoalType: String, Codable {
    case yearly = "연간"
    case monthly = "월간"
    case weekly = "주간"
    case daily = "일간"
}

@Model
final class Goal: Identifiable {
    var title: String
    var goalDescription: String
    var timestamp: Date
    var isCompleted: Bool
    var type: GoalType
    var id: UUID
    
    // 상위 목표 (예: 월간 목표의 경우 연간 목표)
    var parentGoal: Goal?
    
    // 하위 목표들 (예: 연간 목표의 경우 월간 목표들)
    @Relationship(deleteRule: .cascade) var subGoals: [Goal] = []
    
    init(title: String = "", 
         description: String = "", 
         timestamp: Date = Date(),
         type: GoalType = .daily,
         isCompleted: Bool = false,
         parentGoal: Goal? = nil) {
        self.title = title
        self.goalDescription = description
        self.timestamp = timestamp
        self.type = type
        self.isCompleted = isCompleted
        self.parentGoal = parentGoal
        self.id = UUID()
    }
}
