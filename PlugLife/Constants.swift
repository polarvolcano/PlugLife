//
//  Constants.swift
//  pokedex
//
//  Created by Adam McRae on 2017-01-10.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import Foundation

let URL_BASE = "http://free.currencyconverterapi.com/api/v3/convert?q="

let baseLocale = Locale.current

var countrylist = [Country]()

typealias DownloadComplete = () -> ()

//This dictionary key is the socket type, with te value being an array of plug types which will fit the socket
let compatiblePlug: [String:[String]] = ["A" : ["A"], "B" : ["A","B"], "C" : ["C"], "D" : ["C","D","?E","?F"], "E" : ["C","E","F"], "F" : ["C","E","F"], "G" : ["G"], "H" : ["C","H", "?E","?F"], "I" : ["I"], "J" : ["C","J"], "K" : ["C","K","?E","?F"], "L" : ["C","L"], "M" : ["M"], "N" : ["C","N"], "O" : ["C","O","?E","?F"]]

//This dictionary key is the socket type, with te value being a text description of the plug type
let typeInfo: [String:String] = ["A" : "Used in: North and Central America, Japan \r\n The Type A electrical plug (or flat blade attachment plug) is an ungrounded plug with two flat parallel pins. Although the American and Japanese plugs appear identical, the neutral pin on the American plug is wider than the live pin, whereas on the Japanese plug both pins are the same size. As a result, Japanese plugs can be used in the US but often not the other way around. \r\n The pins on Type A and Type B plugs have a hole near the tip that fits into ‘bumps’ found on the contact wipers of some sockets, so that the pins are gripped more tightly allowing for better contact and also to prevent the plug from slipping out of the socket. Some sockets have spring-action blades that grip the sides of the pins, making the holes obsolete.", "B" : "Test B", "C" : "Test C"]


