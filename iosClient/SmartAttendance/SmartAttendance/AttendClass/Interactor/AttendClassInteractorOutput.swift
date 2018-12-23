//
//  AttendClassAttendClassInteractorOutput.swift
//  SmartAttendance
//
//  Declare the methods carry the information from interactor to the presenter
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import Foundation

/// This protocol takes functions that take a parameter that is fetched in interactor.
/// This protocol allows you to communicate with the presenter.
protocol AttendClassInteractorOutput: class {
  // Variables
    func result(message:String)
  // Functions
}
