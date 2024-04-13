//
//  ItemModel.swift
//  Hungry2Grow
//
//  Created by Vedant Patil on 12/04/24.
//

import SwiftUI

struct Item: Codable,Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
