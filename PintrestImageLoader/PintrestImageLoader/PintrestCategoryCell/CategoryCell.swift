//
//  CategoryCell.swift
//  PintrestImageLoader
//
//  Created by Nour  on 5/24/19.
//  Copyright © 2019 Nour . All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel:UILabel!
    
    var title:String?{
        didSet{
            guard let title = title else {return}
            titleLabel.text = title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = AppFonts.xSmallSemiBold
    }
}
