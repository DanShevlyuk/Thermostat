//
//  Switch.swift
//  Thermostat
//
//  Created by Dan Shevlyuk on 13/08/15.
//  Copyright (c) 2015 Team #19. All rights reserved.
//

import UIKit

enum SwitchType: Int {
    case Day
    case Night
}

@objc class Switch: NSObject, NSCoding, NSCopying {

    var time: Int
    var type: SwitchType

    override init() {
        self.time = 0
        self.type = .Night
        super.init()
    }

    init(hours: Int, minutes: Int, type: SwitchType) {
        self.time = hours * 60 + minutes
        self.type = type
        super.init()
    }

    func getDate() -> NSDate {
        return getDateByAddingMinutes(0)
    }

    func getDateByAddingMinutes(minutes: Int) -> NSDate {
        let dateComponents = NSDateComponents()
        let timeComp = getHoursMinutesFromTime(time + minutes)
        dateComponents.hour = timeComp.hours
        dateComponents.minute = timeComp.minutes

        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
    }

    func getHoursMinutes() -> (hours: Int, minutes: Int) {
        return getHoursMinutesFromTime(time)
    }

    private func getHoursMinutesFromTime(time: Int) -> (hours: Int, minutes: Int) {
        var hours: Int = time / 60
        var minutes: Int = time - hours * 60

        return (hours, minutes)
    }

    //MARK: - NSCoding stuff

    required init(coder aDecoder: NSCoder) {
        time = aDecoder.decodeIntegerForKey("time")
        type = SwitchType(rawValue: aDecoder.decodeIntegerForKey("type"))!
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(time, forKey: "time")
        aCoder.encodeInteger(type.rawValue, forKey: "type")
    }

    //MARK: - NSCopying

    func copyWithZone(zone: NSZone) -> AnyObject {
        let time = self.getHoursMinutes()
        let switchCopy = Switch(hours: time.hours, minutes: time.minutes, type: self.type)

        return switchCopy
    }
}

