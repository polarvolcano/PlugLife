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

    
    var plugType: String {
        return _plugType
    }
    
    
    init(plugType: String) {
        self._plugType = plugType
    
    }
    
}
