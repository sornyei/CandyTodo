//
//  Utils.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

class Utils {
    
    static func todayPredicate() -> NSPredicate  {
        let dateFrom = Calendar.current.startOfDay(for: Date())
        let dateTo = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        
        return NSPredicate(format: "%K BETWEEN {%@, %@}", "due", dateFrom as NSDate, dateTo as NSDate)
    }
    
    static func notifications(_ notifications: [CandyNotification]) -> [DailyCandyNotification] {
        return notifications.reduce([DailyCandyNotification]()) { (list, notification) in
            var found = false
            var foundIndex = -1
            var list = list
            for index in (0..<list.count) {
                if list[index].date == notification.date {
                    found = true
                    foundIndex = index
                    break
                }
            }
            if found {
                list[foundIndex].notifications.append(notification)
            } else {
                list.append(DailyCandyNotification(date: notification.date, notifications: [notification]))
            }
            
            return list
        }

    }
    
    static func dateToString(_ dt: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium        
        
        if Calendar.current.isDateInToday(dt) {
            return "Today"
        } else if Calendar.current.isDateInTomorrow(dt) {
            return "Tomorrow"
        }
        
        return formatter.string(from: dt)
    }
    
    static func upcomingTodos(_ todos: FetchedResults<Todo>) -> [Todo.DailyTodo] {
        
        var dailyTodos = [Todo.DailyTodo]()
        
        for todo in todos {
                   let date = dateToString(todo.due)
                   var found = false
                   var foundIndex = -1
                   for index in (0..<dailyTodos.count) {
                       if dailyTodos[index].date == date {
                           found = true
                           foundIndex = index
                           break
                       }
                   }
                   if found {
                       dailyTodos[foundIndex].todos.append(todo)
                   } else {
                    let dailyTodo = Todo.DailyTodo(date: date, todos: [todo])
                       dailyTodos.append(dailyTodo)
                   }
               
               }
               
               return dailyTodos
    }
    
    private static func dayFromDate(_ dt: Date) -> Date {
        let componens = Calendar.current.dateComponents(in: .current, from: dt)
        return Calendar.current.date(from: DateComponents(year: componens.year, month: componens.month, day: (componens.day ?? 0) + 1))!
    }

}

