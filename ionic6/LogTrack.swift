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
    private var _ins: String!
    private var _out: String!
    private var _droppedOff: String!
    private var _pickedUp: String!
    private var _fullName: String!
//    private var _student: Student! // a bit advanced for now
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var ins: String {
        return _ins
    }
    
    var out: String {
        return _out
    }
    
    var pickedUp: String {
        return _pickedUp
    }
    
    var fullName: String {
        return _fullName
        
    }
    
    var droppedOff: String {
        return _droppedOff
    }
    
    init(date: String, ins: String, out: String, pickedUp: String, droppedOff: String, fullName: String){
        self._date = date
        self._ins = ins
        self._out = out
        self._pickedUp = pickedUp
        self._fullName = fullName
        self._droppedOff = droppedOff
        
    }
}
