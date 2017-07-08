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
    private var _siteLocation: String!
    private var _gList: Dictionary<String, Dictionary<String,String>>!
    
    //private var _guardians: [<String, String>]!
    
    var firstName: String {
        return _firstName
    }
    
    var lastName: String {
        return _lastName
    }
    
    var siteLocation: String {
        return _siteLocation
    }
    
    var gList: Dictionary<String, Dictionary<String,String>>{
        return _gList
    }
    
    init(firstName: String, lastName: String, siteLocation: String, gList: Dictionary<String, Dictionary<String,String>>) {
        self._firstName = firstName
        self._lastName = lastName
        self._siteLocation = siteLocation
        self._gList = gList

    }
}
