//
//  SessionMakerSessionMakerRouter.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//
import UIKit
class SessionMakerRouter: SessionMakerRouterInput {
    func nextView() -> UIViewController {
        return  ClassListModuleInitializer().classlistViewController
    }
    

}
