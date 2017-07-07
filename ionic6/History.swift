//
//  History.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import Foundation

class History {
    private var logs = [LogTrack]()
    private var dates = [String]()
    
    init(){
        for log in logs {
            dates.append(log.date)
        }
        //In this initializer we go through each log and take out the Date variable and put it into our dates
    }
    
    func openLog(){
        //When the user selects
    }
}
