//
//  PintrestCell.swift
//  PintrestImageLoader
//
//  Created by Nour  on 5/23/19.
//  Copyright © 2019 Nour . All rights reserved.
//

import UIKit

class PintrestCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var BGView:UIView!
    
    private var categories:[Categories] = []
    var categoryCellId = "CategoryCell"
    
    // in the cellforitem method only set the cell type to PintrestCell
    // and set the cell.item = items[indexPath.item]
    var item:Response?{
        didSet{
            guard let item = item else {return}
            if let imageUrl = item.urls?.regular{
                imageView.loadFrom(url: imageUrl, placeHolder: nil)
            }
            
            if let username = item.user?.name {
                userNameLabel.text = username
            }
            
            if let imageUrl = item.download_url {
                imageView.loadFrom(url: imageUrl, placeHolder: nil)
            }
            
            if let username = item.author {
                userNameLabel.text = username
            }
            if let userImageUrl = item.user?.profile_image?.medium{
                userImageView.loadFrom(url: userImageUrl, placeHolder: nil)
            }
            
            if let likes = item.likes{
                numberOfLikesLabel.text = "\(likes) Likes"
            } else{
                numberOfLikesLabel.text = "1234 Likes"
            }
            
            if let categories = item.categories{
                self.categories = categories
                categoryCollectionView.reloadData()
            }
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // setup fonts and colors
        setupView()
    }
    
    func setupView(){
        
        // make user image rounded
        self.userImageView.layer.cornerRadius = 25
        self.userImageView.layer.masksToBounds = true
        
        // fonts
        userNameLabel.font = AppFonts.bigBold
        numberOfLikesLabel.font = AppFonts.smallBold
        
        // collection View
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        let nib = UINib(nibName: categoryCellId, bundle: nil)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: categoryCellId)
    }
    
    
    // smooth animate
    func animate(){
        self.BGView.animateIn(mode: .animateInFromLeft, delay: 0.3)
    }


}


// MARK: UICollectioview Delegates

extension PintrestCell:UICollectionViewDelegate , UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryCell
        cell.title = categories[indexPath.item].title
        return cell
    }
    
}



extension PintrestCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = categories[indexPath.item]
        let width:CGFloat = (category.title?.getLabelWidth(font: AppFonts.xSmallBold) ?? 0) + 32
        let height:CGFloat = 40.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
