//
//  ViewController.swift
//  Lesson 12 - UILabel (Present app)
//
//  Created by Валентин Ремизов on 10.02.2023.
//

import UIKit

class PresentLabelVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet private weak var generalLabel: UILabel!
    @IBOutlet private weak var sizeSlider: UISlider!
    @IBOutlet private weak var colorTextTF: UITextField!
    private let colorTextPicker = UIPickerView()
    private let colorsArray = ["Black", "White", "Green", "Yellow", "Blue", "Orange", "Gray"]
    @IBOutlet private weak var numberStringTF: UITextField!
    private let numberStringsPicker = UIPickerView()
    private let numberStringsArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @IBOutlet private weak var modeShadowSwitch: UISwitch!
    @IBOutlet private weak var modeShadowView: UIView!
    @IBOutlet private weak var colorShadowTF: UITextField!
    private let colorShadowPicker = UIPickerView()
    @IBOutlet private weak var weightShadowTF: UITextField!
    @IBOutlet private weak var heightShadowTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Указываем каким способом переносить текст на новую строчку
        generalLabel.lineBreakMode = .byTruncatingMiddle
        sizeSlider.addTarget(self, action: #selector(sizeSliderValueChange), for: .valueChanged)
        colorTextPicker.dataSource = self
        colorTextPicker.delegate = self
        colorTextPicker.tag = 0
        colorTextTF.inputView = colorTextPicker
        colorTextTF.inputAccessoryView = toolBarColorText()
        numberStringsPicker.tag = 1
        numberStringsPicker.delegate = self
        numberStringsPicker.dataSource = self
        numberStringTF.inputView = numberStringsPicker
        numberStringTF.inputAccessoryView = toolBarNumberStrings()
        modeShadowView.layer.cornerRadius = 10
        modeShadowSwitch.addTarget(self, action: #selector(modeShadowSwitchChangeValue), for: .valueChanged)
        colorShadowPicker.tag = 2
        colorShadowPicker.dataSource = self
        colorShadowPicker.delegate = self
        colorShadowTF.inputView = colorShadowPicker
        colorShadowTF.inputAccessoryView = toolBarColorShadow()
        weightShadowTF.addTarget(self, action: #selector(weightShadowChangeValue), for: .editingChanged)
        heightShadowTF.addTarget(self, action: #selector(heightShadowChangeValue), for: .editingChanged)
    }

//MARK: - Functions
    @IBAction private func addPressed(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Please, write text for UILabel", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.generalLabel.text = alertController.textFields?.first?.text
        }
        alertController.addTextField()
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }

    @objc private func sizeSliderValueChange() {
        sizeSlider.minimumValue = 10
        sizeSlider.maximumValue = 50
        let sliderValue = sizeSlider.value
        generalLabel.font = UIFont.systemFont(ofSize: CGFloat(sliderValue))
    }

    @objc private func modeShadowSwitchChangeValue() {
        if modeShadowSwitch.isOn {
            generalLabel.shadowColor = .gray
            generalLabel.shadowOffset = CGSize(width: 1, height: 1)
            weightShadowTF.text = String(1)
            heightShadowTF.text = String(1)
        } else {
            generalLabel.shadowOffset = CGSize(width: 0, height: 0)
            weightShadowTF.text = nil
            heightShadowTF.text = nil
        }
    }

    @objc private func weightShadowChangeValue(sender: UITextField) {
            generalLabel.shadowOffset = CGSize(width: Int(sender.text ?? "") ?? 0, height: Int(heightShadowTF.text ?? "") ?? 0)
    }

    @objc private func heightShadowChangeValue(sender: UITextField) {
        generalLabel.shadowOffset = CGSize(width: Int(weightShadowTF.text ?? "") ?? 0, height: Int(sender.text ?? "") ?? 0)
    }

}

extension PresentLabelVC {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0,2: return colorsArray.count
        case 1: return numberStringsArray.count
        default: return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0, 2: return colorsArray[row]
        case 1: return String(numberStringsArray[row])
        default: return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0: colorTextTF.text = colorsArray[row]
        case 1: numberStringTF.text = String(numberStringsArray[row])
        case 2: colorShadowTF.text = colorsArray[row]
        default: break
        }

        if pickerView.tag == 0 {
            switch colorTextTF.text {
            case colorsArray[0]: generalLabel.textColor = .black
            case colorsArray[1]: generalLabel.textColor = .white
            case colorsArray[2]: generalLabel.textColor = .green
            case colorsArray[3]: generalLabel.textColor = .yellow
            case colorsArray[4]: generalLabel.textColor = .blue
            case colorsArray[5]: generalLabel.textColor = .orange
            case colorsArray[6]: generalLabel.textColor = .gray
            default: generalLabel.textColor = .systemPink
            }
        }

        if pickerView.tag == 1 {
            switch numberStringTF.text {
            case String(numberStringsArray[0]): generalLabel.numberOfLines = 0
            case String(numberStringsArray[1]): generalLabel.numberOfLines = 1
            case String(numberStringsArray[2]): generalLabel.numberOfLines = 2
            case String(numberStringsArray[3]): generalLabel.numberOfLines = 3
            case String(numberStringsArray[4]): generalLabel.numberOfLines = 4
            case String(numberStringsArray[5]): generalLabel.numberOfLines = 5
            case String(numberStringsArray[6]): generalLabel.numberOfLines = 6
            case String(numberStringsArray[7]): generalLabel.numberOfLines = 7
            case String(numberStringsArray[8]): generalLabel.numberOfLines = 8
            default: generalLabel.numberOfLines = 9
            }
        }

        if pickerView.tag == 2 {
            switch colorShadowTF.text {
            case colorsArray[0]: generalLabel.shadowColor = .black
            case colorsArray[1]: generalLabel.shadowColor = .white
            case colorsArray[2]: generalLabel.shadowColor = .green
            case colorsArray[3]: generalLabel.shadowColor = .yellow
            case colorsArray[4]: generalLabel.shadowColor = .blue
            case colorsArray[5]: generalLabel.shadowColor = .orange
            case colorsArray[6]: generalLabel.shadowColor = .gray
            default: generalLabel.shadowColor = .systemPink
            }
        }
    }

//MARK: - Color text - functions + doneButton here
    private func toolBarColorText() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pressedCancelColorTextTB))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressedDone))
        toolBar.setItems([cancelButton, doneButton], animated: true)
        return toolBar
    }

    @objc private func pressedCancelColorTextTB() {
        colorTextTF.text = nil
        colorTextTF.resignFirstResponder()
    }

    @objc private func pressedDone() {
        colorTextTF.resignFirstResponder()
        numberStringTF.resignFirstResponder()
        colorShadowTF.resignFirstResponder()
    }

//MARK: - Number strings - functions
    private func toolBarNumberStrings() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pressedCancelNumberStringsTB))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressedDone))
        toolBar.setItems([cancelButton, doneButton], animated: true)
        return toolBar
    }

    @objc private func pressedCancelNumberStringsTB() {
        numberStringTF.text = nil
        numberStringTF.resignFirstResponder()
    }

//MARK: - Color shadow - functions
    private func toolBarColorShadow() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pressedCancelColorShadowTB))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressedDone))
        toolBar.setItems([cancelButton, doneButton], animated: true)
        return toolBar
    }

    @objc private func pressedCancelColorShadowTB() {
        colorShadowTF.text = nil
        colorShadowTF.resignFirstResponder()
    }
}
