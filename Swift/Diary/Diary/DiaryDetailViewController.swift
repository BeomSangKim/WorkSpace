//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/18.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
    func didSelectFavorites(indexPath: IndexPath, isFavorites: Bool)
}

class DiaryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var favoritesButton:UIBarButtonItem?
    
    weak var delegate: DiaryDetailViewDelegate?
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let editDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        editDiaryViewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil)
        self.navigationController?.pushViewController(editDiaryViewController, animated: true)
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {return}
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
        
        self.favoritesButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapFavoritesButton))
        self.favoritesButton?.image = diary.isFavorites ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.favoritesButton?.tintColor = diary.isFavorites ? .systemYellow : .systemGray3
        self.navigationItem.rightBarButtonItem = self.favoritesButton
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else {return}
        self.diary = diary
        self.configureView()
    }
    
    @objc func tapFavoritesButton() {
        guard let isFavorites = self.diary?.isFavorites else {return}
        self.favoritesButton?.image = isFavorites ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
        self.favoritesButton?.tintColor = isFavorites ? .systemGray3 : .systemYellow
        
        self.diary?.isFavorites = !isFavorites
        guard let indexPath = self.indexPath else {return}
        self.delegate?.didSelectFavorites(indexPath: indexPath, isFavorites: self.diary?.isFavorites ?? false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
