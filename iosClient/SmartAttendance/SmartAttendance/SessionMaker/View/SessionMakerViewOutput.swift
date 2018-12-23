//
//  SessionMakerSessionMakerViewOutput.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import Foundation
@objc protocol SessionMakerViewOutput:BaseViewOutput {
	/* declare methods that carry the information related to changes or updates on view to presenter*/
		// Variables
    // Functions
    @objc func backButtonTriggered()
    @objc func signUpButtonTriggered()
		// Functions
}
