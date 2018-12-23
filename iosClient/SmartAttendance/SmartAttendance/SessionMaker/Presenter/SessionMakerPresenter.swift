//
//  SessionMakerSessionMakerPresenter.swift
//  SmartAttendance
//
//	Present the responses of the interactor
//  Operate the view logic
//  Route the neccessary flows
// 	Pass the data collected from the view
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

/// This class is the connection of View, Interactor.
class SessionMakerPresenter: SessionMakerModuleInput, SessionMakerViewOutput, SessionMakerInteractorOutput {
    func wifiCheck() {
        view.showResultAlert()
    }
    
    func nextView(list: [String]) {
        let x = router.nextView() as! ClassListViewController
        x.carrier = list
        view.transitionMaker(rootController: x, duration: 0.3)
    }
    
    func sessionStartPopUp(isStarted: Bool) {
        if isStarted{
            view.sessionStartedViewAdded()
        }
    }
    
    func backButtonTriggered() {
        
        view.startButton.isEnabled = true
        view.finishButton.isEnabled = false
        interactor.finishSession()
    }
    
    func signUpButtonTriggered() {
        interactor.setupSession()
        view.startButton.isEnabled = false
        view.finishButton.isEnabled = true
    }

    weak var view: SessionMakerViewInput!
    var interactor: SessionMakerInteractorInput!
    var router: SessionMakerRouterInput!

    func viewIsReady() {
    	interactor.fetchData()
    }
}
