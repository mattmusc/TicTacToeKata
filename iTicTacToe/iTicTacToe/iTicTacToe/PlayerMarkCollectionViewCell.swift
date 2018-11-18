//
//  PlayerMarkCollectionViewCell.swift
//  iTicTacToe
//
//  Created by Matteo Muscella on 18/11/2018.
//  Copyright © 2018 Matteo Muscella. All rights reserved.
//

import UIKit

class PlayerMarkCollectionViewCell: UICollectionViewCell
{
  @IBOutlet weak var emoji: UILabel!
  
  var playerMark: String = "" {
    didSet {
      emoji.text = playerMark
    }
  }
}
