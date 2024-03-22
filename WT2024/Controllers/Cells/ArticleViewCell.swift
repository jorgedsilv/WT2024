//
//  ArticleViewCell.swift
//  WT2024
//
//  Created by Jorge Silva on 12/03/2024.
//

import UIKit

class ArticleViewCell: UICollectionViewCell {
    
    // MARK: - Properties -
    
    private let chevronSize: CGSize = CGSize(width: 14, height: 14)
    
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
    
    private let published: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
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
        
        self.addSubview(self.labelStack)
        
        NSLayoutConstraint.activate([
            self.labelStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.labelStack.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.labelStack.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        labelStack.addArrangedSubview(title)
        labelStack.addArrangedSubview(author)
        labelStack.addArrangedSubview(published)
        labelStack.addArrangedSubview(body)
        
        self.addSubview(chevron)
        
        NSLayoutConstraint.activate([
            chevron.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor),
            chevron.centerYAnchor.constraint(equalTo: labelStack.centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: chevronSize.width),
            chevron.heightAnchor.constraint(equalToConstant: chevronSize.height)
        ])
    }
    
    func configureCell(article: Article) {
        
        self.article = article
        
        guard let title = article.title,
              let author = article.author,
              let summary = article.summary,
              let publishedAt = article.publishedAt
        else {
            return
        }
        
        self.title.text = title
        self.author.text = author
        self.body.text = summary
        self.published.text = getDate(publishedAt: publishedAt)
        
    }
    
//    private func getDate(publishedAt: String) -> String {
//        
//        // https://sarunw.com/posts/how-to-parse-iso8601-date-in-swift/#iso-8601-with-fractional-seconds
//        let formatter = ISO8601DateFormatter()
//        formatter.formatOptions.insert(.withFractionalSeconds)
//        let date = formatter.date(from: publishedAt)
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        dateFormatter.dateFormat = "dd-MMMM-yyyy"
//        if let languageCode = Locale.current.language.languageCode {
//            dateFormatter.locale = Locale(identifier: languageCode.identifier)
//        }
//        let published = dateFormatter.string(from: date!)
//
//        return published
//        
////        let ofString: String = " "+String(localized: "of")+" "
////        let newDate = published.replacingOccurrences(of: "-", with: ofString)
////        
////        return newDate
//    }
}
