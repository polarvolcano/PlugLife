//
//  Plug.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-12.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import Foundation

class Plug {
    private var _plugType: String!
    private var _iecURL: String!

    
    var plugType: String {
        return _plugType
    }
    
    var iecURL: String {
        return _iecURL
    }
    
    
    init(plugType: String) {
        self._plugType = plugType
        self._iecURL = "www.iec.ch/worldplugs/type\(self.plugType).htm"
    }
    
}
