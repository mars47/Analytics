//
//  File.swift
//  DemoApp
//
//  Created by Omar on 14/06/2022.
//

import Foundation
import Analytics

class ExampleClass {
    
    init() {
        AnalyticsManager.assign(NetworkManager() )
    }
    
    func logButtonTapped() {
        
        let buttonTapped = ButtonTapped(timeOfEvent: "", bundleID: "", systemVersion: "", applicationState: .active)
        
        AnalyticsManager.log(buttonTapped)
    }
}

struct ButtonTapped: LogItem {
    
    var eventDescription: String?
    var timeOfEvent: String
    var bundleID: String
    var systemVersion: String
    var applicationState: ApplicationState
}

class NetworkManager: NetworkLogable {
    
    func postData(body: Array<[String : String]>) async throws -> String {
        /// NETWORK REQUEST CODE HERE
        return "successfully posted to server"
    }
}
