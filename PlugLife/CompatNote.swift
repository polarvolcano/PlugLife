//
//  CompatNote.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-21.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import Foundation

class CompatNote {
    var compatType: [String?] = []
    var infoText: [String?] = []
    
    private var _plugTypes: [String]
    private var _socketTypes: [String]
    
    
    
    
    init(plug: Country, socket: Country) {
        
        self._plugTypes = plug.plugType.components(separatedBy: "/")
        self._socketTypes = socket.plugType.components(separatedBy: "/")
        
        let voltcompare1 = Float(String(socket.voltage.characters.prefix(3)))!
        let voltcompare2 = Float(String(plug.voltage.characters.prefix(3)))!
        
        if voltcompare1/voltcompare2 > 0.9 && voltcompare1/voltcompare2 < 1.1 {
            compatType.append("voltCompat")
            infoText.append("The voltage in \(socket.name) is within 10% of the voltage provided in \(plug.name)")
            print("voltage within range")
            
        } else {
            compatType.append("voltNonCompat")
            infoText.append("Please check your devices can be used with \(String(socket.voltage.characters.prefix(3))) Volts provided in \(socket.name). A voltage adapter may be required")
            
        }
        
        for plugs in _plugTypes {
            for sockets in _socketTypes {
                for compatibleplug in compatiblePlug[sockets]! {
                    if plugs == compatibleplug {
                        compatType.append("plugCompat")
                        infoText.append("Your Type \(plugs) plugs are compatible with the Type \(sockets) sockets in \(socket.name)")
                    }
                }
            }
        }
        
        if compatType.count == 1 {
            compatType.append("plugNonCompat")
            infoText.append("Your will need an adapter to use your Type \(plug.plugType) plugs in \(socket.name)")
        }
        
        
        
    }
    
    
}
