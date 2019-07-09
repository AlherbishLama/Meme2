//
//  DetailMemeViewController.swift
//  Meme2
//
//  Created by Lama Alherbish on 5/20/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class DetailMemeViewController: UIViewController {


    @IBOutlet weak var deImage: UIImageView!
    
    var Meme: meme!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        deImage.image = Meme.MemeImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
