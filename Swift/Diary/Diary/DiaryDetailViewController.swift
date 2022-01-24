//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/18.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
}

class DiaryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var favoritesButton:UIBarButtonItem?
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesDiaryNotiofication(_:)),
            name: NSNotification.Name("FavoritesDiary"),
            object: nil
        )
    }

    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let editDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        editDiaryViewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("EditDiary"),
            object: nil
        )
        self.navigationController?.pushViewController(editDiaryViewController, animated: true)
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let uuidString = self.diary?.uuidString else {return}
        NotificationCenter.default.post(
            name: NSNotification.Name("DeleteDiary"),
            object: uuidString,
            userInfo: nil
        )
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
        
        NotificationCenter.default.post(
            name: NSNotification.Name("FavoritesDiary"),
            object: [
                "diary" : self.diary,
                "isFavorites": self.diary?.isFavorites ?? false,
                "uuidString": self.diary?.uuidString
            ],
            userInfo: nil
        )
    }
    
    @objc func favoritesDiaryNotiofication(_ notification: Notification) {
        guard let favoritesDiary = notification.object as? [String : Any] else {return}
        guard let diary         = favoritesDiary["diary"]       as? Diary   else {return}
        guard let isFavorites   = favoritesDiary["isFavorites"] as? Bool    else {return}
        guard let uuidString    = favoritesDiary["uuidString"]  as? String  else {return}
        
        if diary.uuidString == uuidString {
            self.diary?.isFavorites = isFavorites
            self.configureView()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
