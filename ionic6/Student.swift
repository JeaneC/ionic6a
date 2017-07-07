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
    
    //private var _guardians: [<String, String>]!
    
    init(firstName: String, lastName: String, siteLocation: String) {
        self._firstName = firstName
        self._lastName = lastName
        self._siteLocation = siteLocation

    }
}
