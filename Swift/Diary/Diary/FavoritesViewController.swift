//
//  FavoritesViewController.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/23.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    private var favoritesDiaryList:[Diary] = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFavoritesCollectionView()
        self.loadFavoritesDiaryList()
        
        // Add Observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("EditDiary"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesDiaryNotification(_:)),
            name: NSNotification.Name("FavoritesDiary"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_:)),
            name: NSNotification.Name("DeleteDiary"),
            object: nil
        )
    }
    
    private func configureFavoritesCollectionView() {
        self.favoritesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.favoritesCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.favoritesCollectionView.delegate = self
        self.favoritesCollectionView.dataSource = self
    }
    
    private func loadFavoritesDiaryList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.favoritesDiaryList = data.compactMap {
            guard let uuidString =  $0["uuidString"]    as? String else { return nil }
            guard let title =       $0["title"]         as? String else { return nil }
            guard let contents =    $0["contents"]      as? String else { return nil }
            guard let date =        $0["date"]          as? Date   else { return nil }
            guard let isFavorites = $0["isFavorites"]   as? Bool   else { return nil }
            return Diary(uuidString: uuidString, title: title, contents: contents, date: date, isFavorites: isFavorites)
        }.filter({
            return $0.isFavorites == true
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else {return}
        guard let index = favoritesDiaryList.firstIndex(where: {$0.uuidString == diary.uuidString}) else { return }
        self.favoritesDiaryList[index] = diary
        self.favoritesDiaryList.sort(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.favoritesCollectionView.reloadData()
    }
    
    @objc func favoritesDiaryNotification(_ notification: Notification) {
        guard let favoritesDiary    = notification.object           as? [String : Any]  else {return}
        guard let diary             = favoritesDiary["diary"]       as? Diary           else {return}
        guard let isFavorites       = favoritesDiary["isFavorites"] as? Bool            else {return}
        guard let uuidString        = favoritesDiary["uuidString"]  as? String          else {return}
        if isFavorites {
            self.favoritesDiaryList.append(diary)
            self.favoritesDiaryList.sort(by: {
                $0.date.compare($1.date) == .orderedDescending
            })
            self.favoritesCollectionView.reloadData()
        }
        else {
            guard let index = self.favoritesDiaryList.firstIndex(where: {$0.uuidString == uuidString}) else {return}
            self.favoritesDiaryList.remove(at: index)
            self.favoritesCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    @objc func deleteDiaryNotification(_ notification: Notification) {
        guard let uuidString = notification.object as? String else {return}
        guard let index = self.favoritesDiaryList.firstIndex(where: {$0.uuidString == uuidString}) else {return}
        self.favoritesDiaryList.remove(at: index)
        self.favoritesCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
}

extension FavoritesViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favoritesDiaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: "Favorites Cell", for: indexPath) as? FavoritesCell else {return UICollectionViewCell()}
        let favoriteDiary = self.favoritesDiaryList[indexPath.row]
        cell.titleLabel.text = favoriteDiary.title
        cell.dateLabel.text = dateToString(date: favoriteDiary.date)
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let diaryDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else {return}
        let diary = self.favoritesDiaryList[indexPath.row]
        diaryDetailViewController.diary = diary
        diaryDetailViewController.indexPath = indexPath
        self.navigationController?.pushViewController(diaryDetailViewController, animated: true)
    }
}
