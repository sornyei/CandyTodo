//
//  UpcomingListView.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct UpcomingListView: View {
    var todos = Todo.examples
    var body: some View {
        VStack {
            TitleView(title: "SCHEDULER", subtitle: "Upcoming tasks")
            List {
                ForEach(Utils.upcomingTodos(todos), id:\.date) {dailyTodo in
                    Section(header: SectionHeader(title: dailyTodo.date)) {
                        ForEach(dailyTodo.todos) {todo in
                            TodoListViewRow(todo: todo)
                        }
                    }
                    .background(Color.white)
                }
            }
            .padding(.top, -30)
            
            Spacer()
        }
    }
    
}


struct UpcomingListView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingListView()
    }
}
