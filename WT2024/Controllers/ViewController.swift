//
//  ViewController.swift
//  WT2024
//
//  Created by Jorge Silva on 12/03/2024.
//

import UIKit

// Main – no storyboard
// Also the article
class ViewController: UIViewController {

    enum SectionEnum {
        case main
    }
    
    // MARK: - Properties -
    
    lazy var dataSource = makeDataSource()
    
    var article: [Article] = []
    
    // MARK: - UI Elements -
    
    lazy var collection: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        //let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        //collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    // MARK: - Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
        getData()
    }

    func setupCollection() {
        self.view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            self.collection.topAnchor.constraint(equalTo: view.topAnchor),
            self.collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.collection.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        self.collection.delegate = self
    }
    
    func getData() {
        Datasource.shared.getArticles1_1() {
            //DispatchQueue.main.async {
                NSLog("getArticles1_1 :: \(Datasource.shared.articles.count) :: \(Datasource.shared.articlesError)")
                self.article = Datasource.shared.articles
            //}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.applySnapshot()
            }
        }
        
//        Datasource.shared.getArticles1_0() {
//            //DispatchQueue.main.async {
//                NSLog("getArticles1_0 :: \(Datasource.shared.articles.count) :: \(Datasource.shared.articlesError)")
//                self.article = Datasource.shared.articles
//            //}
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
//                self.applySnapshot()
//            }
//        }
    }
}

// MARK: - UICollectionViewDelegate -

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let itemIdentifier = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        
        NSLog("Selected \(itemIdentifier.title)")
    }
    
}


// MARK:  - DataSource -

extension ViewController {
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<SectionEnum, Article> {
        
        let cellRegistration = UICollectionView.CellRegistration<ArticleViewCell, Article> {
            (cell, indexPath, item) in
            
            cell.configureCell(article: item)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<SectionEnum, Article>(collectionView: collection) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Article) -> UICollectionViewCell? in
            
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        return dataSource
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionEnum, Article>()
        
        snapshot.appendSections([.main])
        
        snapshot.appendItems(self.article, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Layout -

extension ViewController {
    
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            self.createSection()
        }
        
        /*let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        config.scrollDirection = .vertical
        layout.configuration = config*/
        
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection{
        
        let itemFractionalSize: CGFloat = CGFloat(1)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalSize),
                                             heightDimension: .fractionalHeight(itemFractionalSize))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupHeight: CGFloat = CGFloat(120)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(groupHeight))
                                               //heightDimension: .fractionalHeight(0.1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        //let spacing = CGFloat(50)
        //group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
