//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/18.
//

import UIKit

class WriteDiaryViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBorderColor()
        self.configureDatePicker()
        self.configureInputField()
        self.confirmButton.isEnabled = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.configureBorderColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapConfirmButton(_ sender: Any) {
    }
    
    private func configureBorderColor() {
        var borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 255/255)
        if traitCollection.userInterfaceStyle == .dark {
            borderColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 255/255)
        }
        
        self.dateTextField.layer.borderColor = borderColor.cgColor
        self.dateTextField.layer.borderWidth = 0.5
        self.dateTextField.layer.cornerRadius = 5.0
        
        self.titleTextField.layer.borderColor = borderColor.cgColor
        self.titleTextField.layer.borderWidth = 0.5
        self.titleTextField.layer.cornerRadius = 5.0
        
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
        
    }
    
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerHandler(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.dateTextField.inputView = self.datePicker
    }
    
    private func configureInputField() {
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldHandler(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldHandler(_:)), for: .editingChanged)
    }
    
    private func validateInputData() {
        self.confirmButton.isEnabled =
            !(self.titleTextField.text?.isEmpty     ?? true) &&
            !(self.dateTextField.text?.isEmpty      ?? true) &&
            !(self.contentsTextView.text?.isEmpty   ?? true)
        print(self.confirmButton.isEnabled)
    }
    
    @objc private func datePickerHandler(_ dataPicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func titleTextFieldHandler(_ textField: UITextField) {
        self.validateInputData()
    }
    
    @objc private func dateTextFieldHandler(_ textField: UITextField) {
        self.validateInputData()
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputData()
    }
}
