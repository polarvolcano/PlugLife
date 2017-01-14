//
//  Country.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Country {
    private var _name: String!
    private var _isoCode: String!
    private var _plugType: String!
    private var _currencyURL: String!
    private var _basecurrencyURL: String!
    private var _currencyCode: String!
    private var _currencyName: String!
    private var _xchangeRate: Double!
    private var _basexchangeRate: Double!
    private var _locale: Locale!
    private var _language: String!
    
    var name: String {
        return _name
    }
    
    var isoCode: String {
        return _isoCode
    }
    
    var plugType: String {
        return _plugType
    }
    
    var currencyCode: String {
        return _currencyCode
    }
    
    var currencyName: String {
        return _currencyName
    }
    
    init(name: String, isoCode: String, plugType: String, currencyCode: String, currencyName: String) {
        self._name = name
        self._isoCode = isoCode
        self._plugType = plugType
        self._currencyCode = currencyCode
        self._currencyName = currencyName
        self._currencyURL = "\(URL_BASE)USD_\(self._currencyCode!)&compact=y"
        self._basecurrencyURL = "\(URL_BASE)\(baseLocale.currencyCode!)_\(self._currencyCode!)&compact=y"
        
        //self._language = language
    //    let langCode = self._language.components(separatedBy: "/")
    //    self._locale = Locale(identifier: langCode[0])
        
    }
    
    var locale: Locale {
        return _locale
    }
    
    
    func currencyConvert(completed: @escaping DownloadComplete) {

        Alamofire.request(self._currencyURL).responseJSON { (response) in
            print(self._currencyURL)
            print(response.result.value!)
            let json = JSON(response.result.value)
            print(json)
            if let xchangeRate = json["USD_\(self._currencyCode!)"]["val"].double {
                self._xchangeRate = xchangeRate
            } else {
                
            }
                print(self._xchangeRate)
            
                completed()
        }
    }
    
    func basecurrencyConvert(completed: @escaping DownloadComplete) {
        Alamofire.request(self._basecurrencyURL).responseJSON { (response) in
            print(self._basecurrencyURL)
            print(response.result.value!)
            let json = JSON(response.result.value)
            print(json)
            print("\(baseLocale.currencyCode)_\(self._currencyCode!)")
            if let basexchangeRate = json["\(baseLocale.currencyCode!)_\(self._currencyCode!)"]["val"].double {
                self._basexchangeRate = basexchangeRate
            } else {
                
            }
            print(self._basexchangeRate)
            
            completed()
        }
    }
        
    
}
