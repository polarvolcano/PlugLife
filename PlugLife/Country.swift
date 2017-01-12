//
//  Country.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import Foundation

class Country {
    private var _name: String!
    private var _isoCode: String!
    private var _plugType: String!
    
    var name: String {
        return _name
    }
    
    var isoCode: String {
        return _isoCode
    }
    
    var plugType: String {
        return _plugType
    }
    
    init(name: String, isoCode: String, plugType: String) {
        self._name = name
        self._isoCode = isoCode
        self._plugType = plugType
    }
    
}
