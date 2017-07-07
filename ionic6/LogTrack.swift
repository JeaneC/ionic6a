//
//  Logs.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import Foundation

class LogTrack{
    
    private var _date: String!
    private var _in: String!
    private var _out: String!
    private var _pickedUp: String!
    private var _student: Student!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    init(){
        
    }
}
