//
//  MemeCollectionViewController.swift
//  Meme2
//
//  Created by Lama Alherbish on 5/19/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    
    var memes: [meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memes = SingletonClass.memes
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellViewController", for: indexPath) as! CustomCellViewController
        
        let imageMeme = memes[indexPath.item]

        // Set the image
        cell.memeImageViiew.image = imageMeme.MemeImage
        
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailMemeViewController") as! DetailMemeViewController
        
        //Populate view controller with data from the selected item
        detailController.Meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
    }

   

}
