//
//  ClassListClassListExampleCostumView.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//


/// This is an example view. This view is going to be deleted, probably.
/// However, CustomView is responsible for creating reusable views for the related View Controller.
/// Hence, if you are going to use the same view, again and again, create a custom view in here and use it.
import UIKit
class ClassListCell: UITableViewCell {
    
    lazy var onlineView: UIView = {
        let pp = UIView()
        pp.backgroundColor = .green
        pp.layer.masksToBounds = false
        pp.layer.cornerRadius = 4
        pp.clipsToBounds = true
        return pp
    }()
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 16)
        return name
    }()
    lazy var DetailLabel: UILabel = {
        let name = UILabel()
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 10)
        return name
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupAnchor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(onlineView)
        addSubview(nameLabel)
        addSubview(DetailLabel)
    }
    
    func setupAnchor() {
        _ = onlineView.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: self.frame.height/2-4, leftConstant: 0, bottomConstant:0, rightConstant: 16, widthConstant: 8, heightConstant: 8)
        _ = nameLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: onlineView.leftAnchor, topConstant: 3, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: self.frame.height/2-3)
        _ = DetailLabel.anchor(nameLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: onlineView.leftAnchor, topConstant: 3, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: self.frame.height/2-3)
        

    }
    override func prepareForReuse() {
        DetailLabel.text = ""
        nameLabel.text = ""
    }
    
}
