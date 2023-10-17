//
//  StringExtension.swift
//  WeatherApp
//
//  Created by Dipak Sonara on 16/10/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
