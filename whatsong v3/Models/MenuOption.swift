//
//  MenuOption.swift
//  whatsong v3
//
//  Created by Tom Andrew on 2/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

enum MenuOption: Int, CustomStringConvertible    {
    
    case About
    case ReportBug
    case ReportListing
    case RequestMovie
    case RequestShow
    case RequestFeature
    case VisitWebsite
    case Version
    
    var description: String {
        switch self {
        case .About: return "About WhatSong"
        case .ReportBug: return "Report Bug"
        case .ReportListing: return "Report Listing"
        case .RequestMovie: return "Request Movie"
        case .RequestShow: return "Request Show"
        case .RequestFeature: return "Request Feature"
        case .VisitWebsite: return "Visit Website"
        case .Version: return "Version"
        }
    }
    
    var rightDescription: String?   {
        switch self {
        case .Version:
            return "1.01"
        default:
            return nil
        }
    }
    
}
