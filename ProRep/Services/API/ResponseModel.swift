//
//  ResponseModel.swift
//  ProRep
//
//  Created by Qiang Loozen on 11/06/2023.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    let statusCode: Int
    let data: T
}
