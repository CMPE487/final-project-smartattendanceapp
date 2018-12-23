//
//  AttendClassAttendClassInitializer.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

/**
  This class connects the view, presenter, and way numerous classes with each other.
*/
class AttendClassModuleInitializer: NSObject {

    /// **Usage:**
    /// let vc = attendclassViewController.AttendClassViewController()
    /// myAwesomePresentFunction(vc)
    public lazy var attendclassViewController = AttendClassViewController()
    override init() {
    	super.init()
    	let configurator = AttendClassModuleConfigurator()
      configurator.configureModuleForViewInput(viewInput: attendclassViewController)
    }

}
