//
//  TableViewController.swift
//  Meme2
//
//  Created by Lama Alherbish on 5/20/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController  {
    
    var memes: [meme] {
        return SingletonClass.memes
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kTableViewCellID = "MyCoolCellTableViewCell"
        let myMeme = memes[indexPath.row]
        let mycell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellID ) as! MyCoolCellTableViewCell
       
        mycell.setImage(memem: myMeme)
        
        return mycell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeView = self.storyboard?.instantiateViewController(withIdentifier: "DetailMemeViewController") as! DetailMemeViewController
        
        memeView.Meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeView, animated: true)
    }
    
    
    
  
  
}
