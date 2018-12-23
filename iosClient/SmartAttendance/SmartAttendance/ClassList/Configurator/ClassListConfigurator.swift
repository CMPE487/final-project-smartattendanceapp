//
//  ClassListClassListConfigurator.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

class ClassListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ClassListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ClassListViewController) {

        let router = ClassListRouter()

        let presenter = ClassListPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ClassListInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
