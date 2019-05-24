//
//  ViewController.swift
//  NAsyncLoader
//
//  Created by Nour  on 5/23/19.
//  Copyright © 2019 Nour . All rights reserved.
//

import UIKit
import NAsyncLoader


class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var imageView2:UIImageView!
    private let refreshControl = UIRefreshControl()
    
    // page size and index
    private var currentPage = 1
    private var pageSize = 10
    
    var items:[Response]  = []
    var cellId = "PintrestCell"
    
    // this for solve the collection view crash when the number of items changed
    var itemsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // configure Collection View
        configureCollectionView()
        
        // prepare Data
          fetchData()
        
        
        // change Settings and cahce settings
        NAsyncSettings.settings.maximumSimultaneousDownloads = 4
        NAsyncSettings.settings.cache.memoryCapacityBytes    = 20 * 1024 * 1024
        NAsyncSettings.settings.cache.diskCapacityBytes      = 20 * 1024 * 1024
    }
    
    
    func configureCollectionView(){
        collectionView.delegate      = self
        collectionView.dataSource    = self
        let cellNib = UINib(nibName: cellId, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellId)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        // clear items array to not duplicate the data
        items.removeAll()
        itemsCount = 0
        // start again from the fist page
        currentPage = 1
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)
        fetchData()
        refreshControl.endRefreshing()
    }
    
    // fetch data from  http://pastebin.com/raw/wgkJgazE
    func fetchData(){
        let jsonLoader = NAsyncURLLoader<JSONArray<Response> > ()
        // user this url to test paginating
        //https://picsum.photos/v2/list?page=\(currentPage)&limit=\(pageSize)
        let url = "http://pastebin.com/raw/wgkJgazE"
        jsonLoader.requestResource(from: URL(string:url)!) { (result, _) in
            switch result{
            case .success(let response):
                self.items.append(contentsOf: response.value)
                self.itemsCount = self.items.count
                self.collectionView.reloadData()
                break
            case .empty:
                break
            case .error(let error):
                print("1 \(error)")
                break
            }
        }
        
    }
    
    func getNextPage(){
        // increse the page index and fetch the new data
        currentPage += 1
        fetchData()
    }
    
    
}


// MARK : UICollection view Delegates


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PintrestCell
        // attach item to cell
            let item = items[indexPath.item]
            cell.item = item
        return cell
    }
    
}


extension ViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width:CGFloat = self.view.bounds.width
        let height:CGFloat = 400.0
        
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let pintrestCell = cell as? PintrestCell{
            pintrestCell.animate()
        }
        
        if indexPath.item == itemsCount - 1{
            getNextPage()
        }
    }
}
