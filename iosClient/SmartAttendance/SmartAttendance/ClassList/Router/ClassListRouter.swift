//
//  ClassListClassListRouter.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//
import UIKit
class ClassListRouter: ClassListRouterInput {
    func sessionView() -> UIViewController {
        return  SessionMakerModuleInitializer().sessionmakerViewController
    }
}
