//
//  AnalyticsViewModel.swift
//  Analytics
//
//  Created by Omar on 14/06/2022.
//

import Foundation

class AnalyticsViewModel {
    
    var logableItems = [LogItem]()
    var unsentLogableItems = [LogItem]()
    
    var networkLogable: NetworkLogable?
   
    var isInternetConnectionConnected : Bool {
        ConnectionManager.shared.hasConnectivity()
    }
    
    @objc func handleHTTPRequest() async {
        
        if !isInternetConnectionConnected {
            storeUnsentItems()
            return
        }
        
        let items = getLogableOrUnsentItems()
        if items.isEmpty {
            return
        }
        
        do {
            let httpBody = convertLogItemsToHTTPBody(items)
            _ = try await networkLogable?.postData(body: httpBody)
            logableItems = []
        } catch {
            print("caught: \(error)")
        }
    }
}
    
extension AnalyticsViewModel {
    
    /* Events queued and later sent in batches */
    func storeUnsentItems() {
            unsentLogableItems += logableItems
            logableItems = []
    }
    
    func getLogableOrUnsentItems() -> [LogItem] {
       
        if !logableItems.isEmpty {
            return logableItems
        }
        
        else if !unsentLogableItems.isEmpty {
            return get10UnsentItems()
        }
        
        else {
            return []
        }
    }
    
    func convertLogItemsToHTTPBody(_ logItems: [LogItem]) -> Array<[String:String]> {
       
        var httpBody = Array<[String:String]>()
        
        for item in logItems {
            
            let bodyObject = [
                "TimeOfEvent": "\(item.timeOfEvent)",
                "bundleID": "\(item.bundleID)",
                "systemVersion": "\(item.systemVersion)",
                "applicationState": "\(item.applicationState.rawValue)"
            ]
            
            httpBody.append(bodyObject)
        }
        
        print(httpBody)
        return httpBody
   }
    
    func get10UnsentItems() -> [LogItem] {
    
        let count = unsentLogableItems.count < 9 ? unsentLogableItems.count : 9
        let itemsToSend = Array(unsentLogableItems[0...count])
        unsentLogableItems.removeSubrange(0...count)
        return itemsToSend
    }
}
