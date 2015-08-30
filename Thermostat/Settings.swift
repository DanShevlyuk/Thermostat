//
//  Settings.swift
//  Thermostat
//
//  Created by Dan Shevlyuk on 13/08/15.
//  Copyright (c) 2015 Team #19. All rights reserved.
//

import UIKit

@objc class Settings: NSObject, NSCoding {

    var dayTemperature: Double
    var nighTemperature: Double
    var date: NSDate {
        didSet {
            TimeManager.sharedManager.setStartDate(date)
        }
    }

    //alerts
    var showEditFirstSwitchTypeAlert: Bool
    var showDeleteSwitchAlert: Bool

    override init() {
        dayTemperature = 21
        nighTemperature = 15
        date = NSDate()
        showEditFirstSwitchTypeAlert = true
        showDeleteSwitchAlert = true
        super.init()
    }

    internal required init(coder aDecoder: NSCoder) {
        dayTemperature = aDecoder.decodeDoubleForKey("day")
        nighTemperature = aDecoder.decodeDoubleForKey("night")
        date = aDecoder.decodeObjectForKey("date") as! NSDate
        showEditFirstSwitchTypeAlert = aDecoder.decodeBoolForKey("showEditFirstSwitchTypeAlert")
        showDeleteSwitchAlert = aDecoder.decodeBoolForKey("showEditFirstSwitchTypeAlert")
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(dayTemperature, forKey: "day")
        aCoder.encodeDouble(nighTemperature, forKey: "night")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeBool(showDeleteSwitchAlert, forKey: "showDeleteSwitchAlert")
        aCoder.encodeBool(showEditFirstSwitchTypeAlert, forKey: "showEditFirstSwitchTypeAlert")
    }
}
