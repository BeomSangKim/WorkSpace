//
//  ViewController.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var diaryList = [Diary]() {
        didSet {
            self.saveDiaryList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryController = segue.destination as? WriteDiaryViewController {
            writeDiaryController.delegate = self
        }
    }

    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func saveDiaryList() {
        let data =  self.diaryList.map {
            [
                "title": $0.title,
                "contents": $0.contents,
                "date": $0.date,
                "isFavorites": $0.isFavorites
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "diaryList")
    }
    
    private func loadDiaryList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap {
            guard let title =       $0["title"]         as? String else { return nil }
            guard let contents =    $0["contents"]      as? String else { return nil }
            guard let date =        $0["date"]          as? Date   else { return nil }
            guard let isFavorites = $0["isFavorites"]   as? Bool   else { return nil }
            return Diary(title: title, contents: contents, date: date, isFavorites: isFavorites)
        }
        self.diaryList.sort(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else {return}
        guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
        self.diaryList[row] = diary
        self.diaryList.sort(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
}

extension ViewController: WriteDiaryViewDelegate {
    func DidSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Diary Cell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLable.text = dateToString(date: diary.date)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaryList.count
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let diaryDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else {return}
        diaryDetailViewController.diary = self.diaryList[indexPath.row]
        diaryDetailViewController.indexPath = indexPath
        diaryDetailViewController.delegate = self
        self.navigationController?.pushViewController(diaryDetailViewController, animated: true)
    }
}

extension ViewController: DiaryDetailViewDelegate {
    func didSelectDelete(indexPath: IndexPath) {
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
    }
    
    func didSelectFavorites(indexPath: IndexPath, isFavorites: Bool) {
        self.diaryList[indexPath.row].isFavorites = isFavorites
    }
}
