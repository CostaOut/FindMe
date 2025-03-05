//
//  Tab.swift
//  FindMe
//
//  Created by Andrea Costantin on 04/03/25.
//

import SwiftUI

enum TabModel: String, CaseIterable {
    case maps = "map"
    case search = "magnifyingglass"
    case settings = "gear"
    
    var title: String {
        switch self {
        case .maps:
            return "Maps"
        case .search:
            return "Search"
        case .settings:
            return "Settings"
        }
    }
}
