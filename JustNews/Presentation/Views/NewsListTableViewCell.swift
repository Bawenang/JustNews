//
//  NewsListTableViewCell.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

import UIKit
import Kingfisher

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    public func setup(news: NewsItem) {
        thumbnailImageView.kf.setImage(with: news.thumbnail)
        titleLabel.text = news.title
        descriptionLabel.text = news.content
        dateLabel.text = news.publishDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
