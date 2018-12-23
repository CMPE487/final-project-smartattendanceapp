//
//  ClassListClassListInitializer.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

/**
  This class connects the view, presenter, and way numerous classes with each other.
*/
class ClassListModuleInitializer: NSObject {

    /// **Usage:**
    /// let vc = classlistViewController.ClassListViewController()
    /// myAwesomePresentFunction(vc)
    public lazy var classlistViewController = ClassListViewController()
    override init() {
    	super.init()
    	let configurator = ClassListModuleConfigurator()
      configurator.configureModuleForViewInput(viewInput: classlistViewController)
    }

}
