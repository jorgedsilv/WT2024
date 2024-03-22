//
//  ArticleDetailCell.swift
//  WT2024
//
//  Created by Jorge Silva on 21/03/2024.
//

import UIKit

class ArticleDetailCell: UICollectionViewCell {
    
    // MARK: - Properties -
    
    var article: Article? {
        didSet {
            if let article = article {
                DispatchQueue.main.async {
                    self.configureCell(article: article)
                }
            }
        }
    }
    
    // MARK: - UI Elements -
    
    private let contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private let published: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.preferredFont(forTextStyle: .callout)
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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
        
        self.addSubview(self.contentStack)
        
        NSLayoutConstraint.activate([
            self.contentStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentStack.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contentStack.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        contentStack.addArrangedSubview(topImageView)
        contentStack.addArrangedSubview(title)
        contentStack.addArrangedSubview(author)
        contentStack.addArrangedSubview(published)
        contentStack.addArrangedSubview(body)
    }
    
    private func configureCell(article: Article) {
        
        guard let title = article.title,
              let author = article.author,
              let body = article.body,
              let publishedAt = article.publishedAt,
              let imgUrl = article.hero
        else {
            return
        }
        
        //loadImg(urlString: imgUrl)
        loadImg(urlString: "")
        
        self.title.text = title
        self.author.text = author
        self.body.text = body
        self.published.text = getDate(publishedAt: publishedAt)
    }
    
    private func loadImg(urlString: String) {
        
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.topImageView.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.topImageView.image = UIImage(named: "Mountain - Landscape - 400x225px")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.topImageView.image = UIImage(named: "Mountain - Landscape - 400x225px")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.topImageView.image = UIImage(named: "Mountain - Landscape - 400x225px")
            }
        }
        
    }
}
