//
//  ClassListViewController.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit
import PopupDialog
class ClassListViewController: BaseController, ClassListViewInput, UITableViewDelegate, UITableViewDataSource{

    var carrier:[String] = []
    var output: ClassListViewOutput!
    lazy var classesTableView: UITableView = {
        let view = UITableView()
        view.register(ClassListCell.self, forCellReuseIdentifier: "cell")
        view.separatorColor = .clear
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var listLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Class Attendee List"
        label.textAlignment = .center
        return label
    }()
    lazy var finishButton: BaseButton = {
        let b = BaseButton()
        b.setTitle("Mail It", for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 20
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor.clear
        b.addTarget(self, action: #selector(Mailit), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    override func setupView() {
        self.view.addSubview(classesTableView)
        self.view.addSubview(listLabel)
        self.view.addSubview(finishButton)
    }

    override func setupAnchor() {
        let leftConstantVal: CGFloat = 36
        let height = self.view.frame.height
        _ = listLabel.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 48)
        _ = finishButton.anchor(nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: leftConstantVal, bottomConstant: height*0.075, rightConstant: leftConstantVal, widthConstant: 0, heightConstant: height*0.075)
        _ = classesTableView.anchor(listLabel.bottomAnchor, left: self.view.leftAnchor  , bottom: finishButton.topAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: leftConstant, bottomConstant: 16, rightConstant: rightConstant, widthConstant: 0, heightConstant: 0)
    }

    override func setupEvent() {

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrier.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell") as? ClassListCell)!
        cell.nameLabel.text = carrier[indexPath.row]
        cell.DetailLabel.text = "\((indexPath.row+1))"
        cell.backgroundColor = .clear
        return cell
    }
    func showCloseAlert(){
        showCoolAlert(title: "Sorry", message: "No one attended to course", actions: [CancelButton(title: "Okey", action: {
            self.output.sessionMakerLoader()
        })])
    }
    @objc func Mailit(){
        output.mailandClose()
    }
    func activityViewLoader(path:URL){
        let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
        vc.excludedActivityTypes = [
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo,
            UIActivityType.postToTwitter,
            UIActivityType.postToFacebook,
            UIActivityType.openInIBooks,
            UIActivityType.airDrop
        ]
        present(vc, animated: true, completion: nil)
        vc.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
            
            // Return if cancelled
            if (completed) {
               self.output.isMailed = true
                self.finishButton.setTitle("Close", for: .normal)
            }
            
        }
    }
}
