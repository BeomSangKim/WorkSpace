//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/18.
//

import UIKit

enum DiaryEdiorMode {
    case new
    case edit(IndexPath, Diary)
}


protocol WriteDiaryViewDelegate : AnyObject {
    func DidSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    @IBOutlet weak var viewControllerTitle: UINavigationItem!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    private let formatter = DateFormatter()
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditorMode: DiaryEdiorMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBorderColor()
        self.configureDatePicker()
        self.configureInputField()
        self.configureEditMode()
        self.confirmButton.isEnabled = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.configureBorderColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapConfirmButton(_ sender: Any) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentsTextView.text else {return}
        guard let date = self.diaryDate else {return}
        let diary = Diary(title: title, contents: contents, date: date)
        
        switch self.diaryEditorMode {
        case .new:
            self.delegate?.DidSelectRegister(diary: diary)
        case let .edit(indexPath, _):
            NotificationCenter.default.post(
                name: NSNotification.Name("editDiary"),
                object: diary,
                userInfo: [
                    "indexPath.row":indexPath.row
                ])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapDateTextField(_ sender: Any) {
        formatter.dateFormat = "yyyy년 MM월 dd일(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        switch self.diaryEditorMode {
        case .edit(_, _):
            datePicker.date = diaryDate!
        default:
            break
        }
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
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
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: self.dateTextField.bounds.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(tapDone))
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.dateTextField.inputAccessoryView = toolBar
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
    
    private func configureEditMode() {
        switch self.diaryEditorMode {
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
            self.viewControllerTitle.title = "일기 수정"
            
        case .new:
            self.confirmButton.title = "확인"
            self.viewControllerTitle.title = "일기 작성"
        }
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc private func datePickerHandler(_ dataPicker: UIDatePicker) {
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
    
    @objc func tapCancel() {
        self.view.endEditing(true)
    }
    
    @objc func tapDone() {
        self.view.endEditing(true)
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputData()
    }
}
