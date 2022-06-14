//
//  NetworkLogable.swift
//  Analytics
//
//  Created by Omar on 14/06/2022.
//

import Foundation

public protocol NetworkLogable {
    /* This module was designed in mind to have no dependancies. An interface is provided for an external networking module to conform to */
     func postData(body: Array<[String:String]>) async throws -> String
}
