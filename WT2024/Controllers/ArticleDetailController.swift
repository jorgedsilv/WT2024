//
//  ArticleDetailController.swift
//  WT2024
//
//  Created by Jorge Silva on 21/03/2024.
//

import UIKit

class ArticleDetailController: UIViewController {
    
    // MARK: - Properties -
    
    enum SectionEnum {
        case main
    }
    
    // MARK: - Properties -
    
    lazy var dataSource = makeDataSource()
    
    var article: Article? {
        didSet {
            if let article = article {
                DispatchQueue.main.async {
                    self.applySnapshot(article: article)
                }
            }
        }
    }
    
    // MARK: - UI Elements -
    
    lazy var collection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    // MARK: - Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollection()
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
}

// MARK: - UICollectionViewDelegate -

extension ArticleDetailController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
}

// MARK:  - DataSource -

extension ArticleDetailController {
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<SectionEnum, Article> {
        
        let cellRegistration = UICollectionView.CellRegistration<ArticleDetailCell, Article> {
            (cell: ArticleDetailCell, indexPath: IndexPath, item: Article) in
            
            cell.article = item
        }
        
        let dataSource = UICollectionViewDiffableDataSource<SectionEnum, Article>(collectionView: collection) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Article) -> UICollectionViewCell? in
            
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        return dataSource
    }
    
    func applySnapshot(article: Article) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionEnum, Article>()
        
        snapshot.appendSections([.main])
        
        snapshot.appendItems([article], toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Layout -

extension ArticleDetailController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            self.createSection()
        }
        
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 0
//        config.scrollDirection = .vertical
//        layout.configuration = config
        
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection{
        
        let itemFractionalSize: CGFloat = CGFloat(1)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalSize),
                                             heightDimension: .fractionalHeight(itemFractionalSize))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupHeight: CGFloat = CGFloat(1820)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(groupHeight))
                                               //heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitems: [item])

        //let spacing = CGFloat(50)
        //group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}
