//
//  AttendClassAttendClassConfigurator.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

class AttendClassModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AttendClassViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AttendClassViewController) {

        let router = AttendClassRouter()

        let presenter = AttendClassPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AttendClassInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
