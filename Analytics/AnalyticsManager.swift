//
//  AnalyticsManager.swift
//  Analytics
//
//  Created by Omar on 13/06/2022.
//

import Foundation

public final class AnalyticsManager {
    
    private var viewModel = AnalyticsViewModel()

    private static var manager: AnalyticsManager?
    
    public static var shared: AnalyticsManager {
        
        if manager == nil {
            manager = AnalyticsManager()
        }
        return manager!
    }
    
    init() {
        DispatchQueue.global(qos: .userInitiated).async {
            
            /* Send POST request every 10 minutes */
            Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(self.viewModel.handleHTTPRequest), userInfo: nil, repeats: true)
        }
    }
}

extension AnalyticsManager {
    
    public static func log(_ logItem: LogItem) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            AnalyticsManager.shared.viewModel.logableItems.append(logItem)
        }
    }
    
    public static func assign(_ networkLogable: NetworkLogable) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            AnalyticsManager.shared.viewModel.networkLogable = networkLogable
        }
    }
}
