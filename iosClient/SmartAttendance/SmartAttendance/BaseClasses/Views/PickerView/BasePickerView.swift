//
//  BasePickerView.swift
//  RhExtranet
//
//  Created by Korhan Çağın Geboloğlu on 15.02.2018.
//  Copyright © 2018 AnadoluRH. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol RowChangedDelegate: class {
    func rowChanged(_ pickerView: BasePickerView, withRows rows: [Int], _ tag: Int)
}

/**
 
 **Usage:** Here is the one way to use this class.
 
 lazy var pickerView: BasePickerView = {
 
  &nbsp;&nbsp;&nbsp;let pView = BasePickerView()
 
  &nbsp;&nbsp;&nbsp;pView.components = [["Section-1/Value-1", "Section-1/Value-2"], ["Section-2/Value-1", "Section-2/Value-2"], ["Section-3/Value-1"]]
 
  &nbsp;&nbsp;&nbsp;pView.rowChangedDelegateVar = self
 
  &nbsp;&nbsp;&nbsp;pView.givenTag = 0
 
  &nbsp;&nbsp;&nbsp;pView.leftImageInfo = ("LeftImageName", 10)
 
  &nbsp;&nbsp;&nbsp;pView.rightImageInfo = ("RightImageName", 10)
 
  &nbsp;&nbsp;&nbsp;pView.pickerViewPlaceHolder = "Select Something"
 
  &nbsp;&nbsp;&nbsp;pView.rowHeight = 50
 
  &nbsp;&nbsp;&nbsp;return pView
 }()
 
 // Delegate function
 
 func rowChanged(_ pickerView: BasePickerView, withRows rows: [Int], _ tag: Int) {
 
  &nbsp;&nbsp;&nbsp;print(rows)
 
  &nbsp;&nbsp;&nbsp;print(tag)
 
  &nbsp;&nbsp;&nbsp;print(pickerView.components.count)
 
 }
 
 **Note:** Do not forget to add RowChangedDelegate to your class.
 */

class BasePickerView: BaseUITextField, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    public var pickerViewPlaceHolder = ""{ didSet { setupPickerViewPlaceHolder() } }
    public var components: [[String]] = [[]] { didSet { componentSetter() } }
    private var componentNumber = 1

    public var givenTag = 0 { didSet { reloadInputViews() } }
    public var rowHeight: CGFloat = 48 { didSet { reloadInputViews() } }

    public var rightImageInfo : (imageName: String, xLocation: Int) = ("", 0) { didSet { setRightImage() } }
    public var leftImageInfo : (imageName: String, xLocation: Int) = ("", 0) { didSet { setLeftImage() } }

    private let pickerView = UIPickerView()

    weak var rowChangedDelegateVar: RowChangedDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeTextFieldPickerView()
        setupPickerView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeTextFieldPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white

        inputView = pickerView
    }

    // Fill this function according to your requirements.
    private func setupPickerView() {
    // An example

        // Left Padding
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//
////        self.font = UIFont(name: Constants().baseFontName, size: 16.0)
//        self.textColor = UIColor.black
//        self.tintColor = .clear
//        self.textAlignment = .left
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.borderWidth = 0.2
//        self.backgroundColor = UIColor.white
//        self.layer.cornerRadius = 24
//        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
//        self.addShadow()
    }

    private func setupPickerViewPlaceHolder() {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .left
        let attributedPlaceholder = NSAttributedString(string: "\(pickerViewPlaceHolder)", attributes: [NSAttributedStringKey.paragraphStyle: centeredParagraphStyle, NSAttributedStringKey.foregroundColor: UIColor.black])
        self.attributedPlaceholder = attributedPlaceholder
    }

    private func setRightImage() {
        self.rightViewMode = .always
        let oView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 12) )
        let iView  = UIImageView(frame: CGRect(x: rightImageInfo.xLocation, y: 0, width: 12, height: 12))

        let origImage = UIImage(named: rightImageInfo.imageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        iView.image = tintedImage

        oView.addSubview(iView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGesture.delegate = self
        oView.addGestureRecognizer(tapGesture)
        oView.isUserInteractionEnabled = true
        self.rightView = oView
        self.rightViewMode = .always
    }

    private func setLeftImage() {
        self.leftViewMode = .always
        let oView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24) )
        let iView  = UIImageView(frame: CGRect(x: leftImageInfo.xLocation, y: 0, width: 24, height: 24))
        iView.image = UIImage(named: leftImageInfo.imageName)
        oView.addSubview(iView)
        self.leftView = oView
    }

    private func componentSetter() {
        componentNumber = components.count
    }

    private func selectRow() {
        var selectedValues: [String] = []
        var selectedRows: [Int] = []

        for compNum in 0..<componentNumber {
            let selectedRow = (self.inputView as? UIPickerView)?.selectedRow(inComponent: compNum)
            let selectedVal = components[compNum][selectedRow ?? 0]

            selectedValues.append(selectedVal)
            selectedRows.append(selectedRow ?? 0)
        }

        rowChangedDelegateVar?.rowChanged(self, withRows: selectedRows, givenTag)
    }

    @objc private func imageTapped() { self.becomeFirstResponder() }

    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.isHidden = false
        return componentNumber
    }

    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].count
    }

    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return components[component][row]
    }

    internal func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRow()
    }

    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: rowHeight))
        pickerLabel.text = components[component][row]
        pickerLabel.numberOfLines = 0
        pickerLabel.adjustsFontSizeToFitWidth = true
        pickerLabel.sizeToFit()
        pickerLabel.textAlignment = .center
        return pickerLabel
    }

    override internal func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
