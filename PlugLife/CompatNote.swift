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
        
        if socket.isoCode == "AA" {
            compatType.append("plugWarn")
            infoText.append("You are currently viewing all plug types available worldwide. For compatibility recommendations, return to the previous screen and select a destination country")
            self._plugTypes = plug.plugType.components(separatedBy: "/")
            self._socketTypes = socket.plugType.components(separatedBy: "/")
        } else if plug.isoCode == socket.isoCode {
            compatType.append("plugCheck")
            infoText.append("You are viewing the plugs available in your base region")
            self._plugTypes = plug.plugType.components(separatedBy: "/")
            self._socketTypes = socket.plugType.components(separatedBy: "/")
        }
        
        
        else {
        
        self._plugTypes = plug.plugType.components(separatedBy: "/")
        self._socketTypes = socket.plugType.components(separatedBy: "/")
        
        let voltcompare1 = Float(String(socket.voltage.characters.prefix(3)))!
        let voltcompare2 = Float(String(plug.voltage.characters.prefix(3)))!
        
        if socket.voltage.characters.count > 4 {
            compatType.append("voltWarn")
            infoText.append("\(socket.name) uses multiple voltages which vary from region to region. Please confirm the socket voltage before use")
            
        }
        
        
        if String(socket.voltage.characters.prefix(3)) == String(plug.voltage.characters.prefix(3)) {
            compatType.append("voltCheck")
            infoText.append("The voltage in \(socket.name) is the same as voltage provided in \(plug.name)")
            print("voltage within range")
        } else if voltcompare1/voltcompare2 > 0.9 && voltcompare1/voltcompare2 < 1.1 {
            compatType.append("voltCheck")
            infoText.append("The voltage in \(socket.name) is within 10% of the voltage provided in \(plug.name). Your devices should function properly")
            print("voltage within range")
            
        } else {
            compatType.append("voltWarn")
            infoText.append("Please check your devices can be used with the \(socket.voltage) Volts provided in \(socket.name). A voltage converter may be required")
            
        }
        
        if plug.plugType == socket.plugType {
            compatType.append("plugCheck")
            infoText.append("Your plugs should be completely compatible with the sockets in \(socket.name)")
            if String(plug.plugType.characters.prefix(1)) == "A" && String(socket.plugType.characters.prefix(1)) == "A" {
                compatType.append("plugWarn")
                infoText.append("Newer Type A plugs have a slightly wider pin and may be difficult to fit in any older Type A sockets in \(socket.name)")
                
            }
        } else {
            
        
        for plugs in _plugTypes {
            for sockets in _socketTypes {
                var compat = false
                for compatibleplug in compatiblePlug[sockets]! {
                    if plugs == compatibleplug {
                        
                        compatType.append("plugCheck")
                        infoText.append("Your Type \(plugs) plugs are compatible with the Type \(sockets) sockets in \(socket.name)")
                        compat = true
                        
                    }
                    if plugs == "A" && compatibleplug == "A" {
                        compatType.append("plugWarn")
                        infoText.append("Newer Type A plugs have a slightly wider pin and may be difficult to fit in any older Type A sockets in \(socket.name)")
                        compat = true
                    }
                }
                if compat == false {
                    compatType.append("plugX")
                    infoText.append("Your Type \(plugs) plugs are not compatible with the Type \(sockets) sockets in \(socket.name). An adapter is required.")
                }
                
            }
            
        }
        }
    
        if compatType.count == 1 {
            compatType.append("xmark")
            infoText.append("Your will need an adapter to use your Type \(plug.plugType) plugs in \(socket.name)")
        }
        
        }
        
    }
    
    
}
