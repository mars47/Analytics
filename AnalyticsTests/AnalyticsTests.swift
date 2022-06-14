//
//  AnalyticsTests.swift
//  AnalyticsTests
//
//  Created by Omar on 13/06/2022.
//

import XCTest
@testable import Analytics
import SwiftUI

class AnalyticsTests: XCTestCase {

    let viewModel = AnalyticsViewModel()
    
    func test_get10UnsentItems() throws {
        
        XCTAssert(viewModel.unsentLogableItems.count == 0)
        _loadItems()
        XCTAssert(viewModel.unsentLogableItems.count == 30)
        
        let items = viewModel.get10UnsentItems()
        XCTAssert(items.count == 10 )
        XCTAssert(items[0].bundleID == "0" )

        XCTAssert(viewModel.unsentLogableItems.count == 20)
        XCTAssert(viewModel.unsentLogableItems[0].bundleID == "10")

        func _loadItems() {
            
            for index in 0...29 {
                let buttonTapped = ButtonTapped(timeOfEvent: DateFormatter().string(from: Date()), bundleID: "\(index)", systemVersion: "", applicationState: .active)
                viewModel.unsentLogableItems.append(buttonTapped)
            }
        }
    }
}
