//
//  Logs.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import Foundation

class LogTrack{
    
    var date: String!
    var ins: String!
    var out: String!
    var droppedOff: String!
    var pickedUp: String!
    var fullName: String!
//    private var _student: Student! // a bit advanced for now
    
    
    init(date: String, ins: String, out: String, pickedUp: String, droppedOff: String, fullName: String){
        self.date = date
        self.ins = ins
        self.out = out
        self.pickedUp = pickedUp
        self.fullName = fullName
        self.droppedOff = droppedOff
        
    }
}
