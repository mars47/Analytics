//
//  LogItem.swift
//  Analytics
//
//  Created by Omar on 14/06/2022.
//

import Foundation

/*  It should be the apps responsibility that implements this module to provide implementation details such as 'screen opened' / 'button tapped' by providing classes, structs or enums that conform to logItem  */

public protocol LogItem {
    
    var eventDescription: String? { get set }
    
    var timeOfEvent: String { get set }
    var bundleID: String { get set }
    var systemVersion: String { get set }
    var applicationState: ApplicationState { get set }
}

public enum ApplicationState: String {
    case active
    case foreground
    case background
}

