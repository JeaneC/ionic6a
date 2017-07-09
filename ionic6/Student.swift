//
//  Student.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import Foundation

class Student {
    private var _firstName: String!
    private var _lastName: String!
    private var _fullName: String!
    private var _siteLocation: String!
    private var _ID: Int!
    private var _leaveAlone: Bool!
    
    var guardians = [String]()

    
    //private var _guardians: [<String, String>]!
    
    var firstName: String {
        return _firstName
    }
    
    var lastName: String {
        return _lastName
    }
    
    var fullName: String {
        return _fullName
    }
    var siteLocation: String {
        return _siteLocation
    }
    
    var leaveAlone: Bool {
        return _leaveAlone
    }
    
    
    init(firstName: String, lastName: String, siteLocation: String, ID: Int, gList: [Dictionary<String, String>], leaveAlone: Bool) {
        self._firstName = firstName
        self._lastName = lastName
        self._fullName = ("\(firstName) \(lastName)")
        self._siteLocation = siteLocation
        self._ID = ID
        self._leaveAlone = leaveAlone
        
        for g in gList {
            guardians.append(g["Name"]!)
        }
        
    }
    

}
