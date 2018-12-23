//
//  ClassListClassListInteractorInput.swift
//  SmartAttendance
//
//  Declare the methods carry the information from presenter to the interactor
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import Foundation

/// This is the definition of the interactor class. Hence, this protocol must be filled first by the programmer.
protocol ClassListInteractorInput: BaseInteractorInput {
	// Variables

	// Functions
	func fetchData()
    func socketCloser()
    func csvMaker()
}
