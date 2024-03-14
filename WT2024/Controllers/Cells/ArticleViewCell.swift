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
    
    private let labelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 8
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chevron: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .none
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .body))
        imageView.image = UIImage(systemName: "chevron.forward", withConfiguration: config)
        return imageView
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
        
        self.addSubview(self.labelStack)
        
        NSLayoutConstraint.activate([
            self.labelStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.labelStack.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.labelStack.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        labelStack.addArrangedSubview(title)
        labelStack.addArrangedSubview(author)
        labelStack.addArrangedSubview(body)
        
        self.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            chevron.topAnchor.constraint(equalTo: labelStack.topAnchor,constant: 10),
            chevron.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 20),
            chevron.heightAnchor.constraint(equalToConstant: 20)
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
