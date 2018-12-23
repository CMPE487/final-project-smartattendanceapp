//
//  SessionMakerSessionMakerInitializer.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

/**
  This class connects the view, presenter, and way numerous classes with each other.
*/
class SessionMakerModuleInitializer: NSObject {

    /// **Usage:**
    /// let vc = sessionmakerViewController.SessionMakerViewController()
    /// myAwesomePresentFunction(vc)
    public lazy var sessionmakerViewController = SessionMakerViewController()
    override init() {
    	super.init()
    	let configurator = SessionMakerModuleConfigurator()
      configurator.configureModuleForViewInput(viewInput: sessionmakerViewController)
    }

}
