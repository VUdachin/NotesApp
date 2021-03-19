//
//  UserDefaults+Extension.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 19.03.2021.
//

import Foundation

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let launched = "launched"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: launched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: launched)
        }
        return isFirstLaunch
    }
}
