//
//  ArticleViewCell.swift
//  WT2024
//
//  Created by Jorge Silva on 12/03/2024.
//

import UIKit

class ArticleViewCell: UICollectionViewCell {
    
    // MARK: - Properties -
    
    var article: Article?
    
    // MARK: - UI Elements -
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(title)
        self.addSubview(author)
        self.addSubview(body)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.rightAnchor.constraint(equalTo: self.rightAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            author.rightAnchor.constraint(equalTo: title.rightAnchor),
            author.leftAnchor.constraint(equalTo: title.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 12),
            body.rightAnchor.constraint(equalTo: author.rightAnchor),
            body.leftAnchor.constraint(equalTo: author.leftAnchor)
        ])
    }
    
    func configureCell(article: Article) {
        
        self.article = article
        
        guard let title = article.title,
              let author = article.author,
              let summary = article.summary
        else {
            return
        }
        
        self.title.text = title
        self.author.text = author
        self.body.text = summary
    }
}
