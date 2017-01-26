//
//  SourceManager.swift
//  DescHeaderTableView
//
//  Created by Vivatum on 1/26/17.
//  Copyright © 2017 vivatum. All rights reserved.
//

import Foundation

class SourceManager {
    
    static func createTableViewData(events: [MyEvent]) -> (years: [Int], events: [Int : [MyEvent]]) {
        
        var tableViewSourse = [Int : [MyEvent]]()
        var years = Set<Int>()
        
        func getYear(event: MyEvent) -> Int {
            return Calendar.current.component(.year, from: event.date)
        }
        
        // populate Set of years
        events.forEach {_ = years.insert(getYear(event: $0)) }
        
        // grouping events by years
        for year in years {
            
            var eventsYear = [MyEvent]()
            
            for event in events {
                if year == getYear(event: event) {
                    eventsYear.append(event)
                }
            }
            
            tableViewSourse[year] = eventsYear.sorted(by: {$0.date > $1.date})
        }
        
        // convert Set to Array & sorting
        let sortedYears = years.sorted(by: {$0 > $1})
        
        return (sortedYears, tableViewSourse)
    }
    
    static func createDate(_ dateString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: dateString)!
    }
    
    // create some events - just for example
    static func createEventList() -> [MyEvent] {
        
        var eventList = [MyEvent]()
        
        eventList.append(MyEvent(date: createDate("23/05/2016"), place: "New York, USA"))
        eventList.append(MyEvent(date: createDate("23/09/2016"), place: "New York, USA"))
        eventList.append(MyEvent(date: createDate("03/12/2016"), place: "Paris, France"))
        eventList.append(MyEvent(date: createDate("07/01/2016"), place: "La Havana, Cuba"))
        eventList.append(MyEvent(date: createDate("20/03/2016"), place: "La Havana, Cuba"))
        
        eventList.append(MyEvent(date: createDate("09/08/2014"), place: "New York, USA"))
        eventList.append(MyEvent(date: createDate("15/02/2014"), place: "La Havana, Cuba"))
        eventList.append(MyEvent(date: createDate("29/04/2014"), place: "Paris, France"))
        eventList.append(MyEvent(date: createDate("22/09/2014"), place: "La Havana, Cuba"))
        eventList.append(MyEvent(date: createDate("12/10/2014"), place: "New York, USA"))
        
        eventList.append(MyEvent(date: createDate("18/05/2015"), place: "Paris, France"))
        eventList.append(MyEvent(date: createDate("27/01/2015"), place: "La Havana, Cuba"))
        eventList.append(MyEvent(date: createDate("19/11/2015"), place: "New York, USA"))
        eventList.append(MyEvent(date: createDate("21/12/2015"), place: "New York, USA"))
        eventList.append(MyEvent(date: createDate("14/01/2015"), place: "La Havana, Cuba"))
        
        return eventList
    }
    
}

public struct MyEvent {
    let date: Date
    let place: String
}
