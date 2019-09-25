//
//  NewsTableCell.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 25/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {
    @IBOutlet weak var newsHeading: UILabel!
    @IBOutlet weak var newsSubHeading: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var articleObj: ArticleViewModel? {
        didSet {
            configureNewsCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configureNewsCell() {
        
        //News Title
        newsHeading.text = articleObj?.title ?? "---"
        
        //Author
        var authorDetails = ""
        if let author =  articleObj?.sourceName {
            authorDetails = author
        }

        //publisedAt
        var publisedAtString = ""
        if let publisedAt =  articleObj?.publishedAt {
            publisedAtString = Utilities.getFormattedDate(date: publisedAt, format: DATE_FORMATS.PUBLISH_AT_FORMAT)
        }
        
        newsSubHeading.attributedText = Utilities.addBoldText(fullString: authorDetails + " " + publisedAtString, boldPartOfString: authorDetails)
        
        //ImageLoading using cache
        if let imagePath = articleObj?.newsImageURL, let imageURL = URL.init(string: imagePath) {
            ImageLoader.image(for: imageURL) {[weak self] (image) in
                guard let self = self else { return }
                if let _ = image {
                    self.thumbnailImage.image = image
                }else {
                    self.thumbnailImage.image = #imageLiteral(resourceName: "newsThumbnailBG")
                }
            }
        }
    }
}
