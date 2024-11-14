//
//  NewsStoryViewController.swift
//  JustNews
//
//  Created by Bawenang RPP on 14/11/24.
//

import UIKit
import Kingfisher

class NewsStoryViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var news: NewsItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let news {
            newsImageView.kf.setImage(with: news.image)
            title = news.title
            headlineLabel.text = news.headline
            contentTextView.text = news.content
            dateLabel.text = news.publishDate
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
