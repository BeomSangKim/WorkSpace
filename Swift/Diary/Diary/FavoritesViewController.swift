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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadFavoritesDiaryList()
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
            guard let title =       $0["title"]         as? String else { return nil }
            guard let contents =    $0["contents"]      as? String else { return nil }
            guard let date =        $0["date"]          as? Date   else { return nil }
            guard let isFavorites = $0["isFavorites"]   as? Bool   else { return nil }
            return Diary(title: title, contents: contents, date: date, isFavorites: isFavorites)
        }.filter({
            return $0.isFavorites == true
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        print(favoritesDiaryList.count)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
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

