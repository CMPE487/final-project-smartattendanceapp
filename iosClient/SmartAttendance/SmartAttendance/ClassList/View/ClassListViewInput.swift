//
//  ClassListClassListViewInput.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//
import UIKit

protocol ClassListViewInput: BaseViewInput {
    // Variables
    var listLabel:UILabel{ get set }
    var classesTableView: UITableView{ get set }
    var carrier:[String]{ get set }
    // Functions
    func showCloseAlert()
    func activityViewLoader(path:URL)
}
