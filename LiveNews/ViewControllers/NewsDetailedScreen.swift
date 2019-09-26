//
//  NewsDetailedScreen.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class NewsDetailedScreen: UIViewController {
    var articalViewModel: ArticleViewModel?
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var graidentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = self.graidentView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        self.graidentView.layer.addSublayer(gradient)
        configureUI()
    }
    
    
    
    func configureUI() {
        guard let articalVM = articalViewModel else { return }
        
        headlineLabel.text       =   articalVM.title
        sourceLabel.text         =   articalVM.sourceName
        publishedAtLabel.text    =   Utilities.getFormattedDate(date: articalVM.publishedAt, format: DATE_FORMATS.PUBLISH_AT_FORMAT)
        newsContentLabel.text    =   articalVM.newsContent
        
        //ImageLoading using cache
        let imagePath = articalVM.newsImageURL
        if let imageURL = URL.init(string: imagePath) {
            ImageLoader.image(for: imageURL) {[weak self] (image) in
                guard let self = self else { return }
                if let _ = image {
                    self.newsImageView.image = image
                }else {
                    self.newsImageView.image = #imageLiteral(resourceName: "newsThumbnailBG")
                }
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
