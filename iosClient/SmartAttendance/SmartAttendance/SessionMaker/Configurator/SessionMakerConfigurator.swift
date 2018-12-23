//
//  SessionMakerSessionMakerConfigurator.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

class SessionMakerModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SessionMakerViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SessionMakerViewController) {

        let router = SessionMakerRouter()

        let presenter = SessionMakerPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SessionMakerInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
