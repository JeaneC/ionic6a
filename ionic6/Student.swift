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
    
    init(firstName: String, lastName: String, siteLocation: String, ID: Int, gList: [Dictionary<String, String>]) {
        self._firstName = firstName
        self._lastName = lastName
        self._fullName = ("\(firstName) \(lastName)")
        self._siteLocation = siteLocation
        self._ID = ID
        
        for g in gList {
            guardians.append(g["Name"]!)
        }
        
    }
    

}
