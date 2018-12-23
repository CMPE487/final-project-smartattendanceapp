//
//  File.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 11.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

class BaseTVCell: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupView()
    }

    // Fill this function according to your requirements.
    private func setupView() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
