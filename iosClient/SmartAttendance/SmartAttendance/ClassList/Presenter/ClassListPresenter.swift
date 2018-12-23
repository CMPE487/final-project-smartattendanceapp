//
//  ClassListClassListPresenter.swift
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
import Foundation
class ClassListPresenter: ClassListModuleInput, ClassListViewOutput, ClassListInteractorOutput {
    var isMailed = false
    func vcMaker(path: URL) {
        view.activityViewLoader(path: path)
    }
    
    func mailandClose() {
        if isMailed{
            sessionMakerLoader()
        }else{
            interactor.csvMaker()
        }
        
    }
    
    func noResult() {
        view.showCloseAlert()
    }
    
    func sessionMakerLoader() {
        interactor.socketCloser()
        view.transitionMaker(rootController: router.sessionView(), duration: 0.3)
    }
    
    func attandees(List: [String]) {
        if List.count>0{
            view.carrier = List
            view.classesTableView.reloadData()
        }else{
            view.showCloseAlert()
        }
    }
    
    weak var view: ClassListViewInput!
    var interactor: ClassListInteractorInput!
    var router: ClassListRouterInput!

    func viewIsReady() {
    	interactor.fetchData()
    }
}
