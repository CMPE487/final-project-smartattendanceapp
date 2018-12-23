//
//  Constants.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 7.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import Foundation

/// This struct allows us to create constant values. For example, if somebody wants to save their favorite color. We can use the following,
///
/// Constants.shared.myFavoriteColor
struct Constants {
    private init() {}
    static let shared = Constants()

    // Example
    // let myFavoriteColor = "Yellow"
}
