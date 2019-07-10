//
//  MyCoolCellTableViewCell.swift
//  Meme2
//
//  Created by Lama Alherbish on 5/20/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class MyCoolCellTableViewCell: UITableViewCell {

    @IBOutlet weak var MyCoolCell: UIImageView!
   
    func setImage(memem: meme){
        MyCoolCell.image = memem.MemeImage
    }

}
