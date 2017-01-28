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
    private var _info: String!
    private var _compatiblePlugs: [String] = []
    private var _plugImageList: [String] = []
    private var _plugImageNameList: [String] = []
    private var _numPins: Int!
    private var _ampRating: Float!
    private var _grounded: Bool!
    
    
    
    
    var plugType: String {
        return _plugType
    }
    
    var iecURL: String {
        return _iecURL
    }
    
    var compatiblePlugs: [String] {
        return _compatiblePlugs
        
    }
    
    var plugImageList: [String] {
        return _plugImageList
    }
    
    var plugImageNameList: [String] {
        return _plugImageNameList
    }
    
    var numPins: Int {
        return _numPins
    }
    
    var ampRating: Float {
        return _ampRating
    }
    
    var grounded: Bool {
        return _grounded
    }
    
    
    init(plugType: String) {
        self._plugType = plugType
        self._iecURL = "http://www.iec.ch/worldplugs/type\(self.plugType).htm"
        self._compatiblePlugs = compatiblePlug[plugType]!
        self._plugImageList = ["electricity-type-\(self.plugType)-plug","electricity-type-\(self.plugType)-socket"]
        self._plugImageNameList = ["Plug","Socket"]
        self._numPins = numPin[plugType]
        self._ampRating = ampRated[plugType]
        self._grounded = isGround[plugType]
        
    }
    
    
}
