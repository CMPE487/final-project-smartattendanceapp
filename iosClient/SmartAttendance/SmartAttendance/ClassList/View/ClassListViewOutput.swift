//
//  ClassListClassListViewOutput.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

protocol ClassListViewOutput:BaseViewOutput {
	/* declare methods that carry the information related to changes or updates on view to presenter*/
		// Variables
    var isMailed:Bool{get set}
		// Functions
    func sessionMakerLoader()
    func mailandClose()
}
