//
//  History.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import Foundation

class History {
    var logs = [LogTrack]() // More of student logs
    var date = ""
    var students = [String]()
    
    //private var dates = [String]()
    
    init(date: String, logsB: [LogTrack]){
//        for log in logs {
//            dates.append(log.date)
//        }
        self.date = date
        self.logs = logsB
    }
    
    func openLog(){
        //When the user selects
    }
}
