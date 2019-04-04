//
//  GetLocationError.swift
//  Lab
//
//  Created by  on 4/1/19.
//  Copyright © 2019 lab. All rights reserved.
//

import Foundation

enum SKGetLocationError: Error {
    case permissionError
}

extension SKGetLocationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .permissionError:
            return NSLocalizedString("Permission is not allow", comment: "Permission Error")
        }
    }
}
