//
//  MarkSelectorCollectionViewController
//  iTicTacToe
//
//  Created by Matteo Muscella on 18/11/2018.
//  Copyright © 2018 Matteo Muscella. All rights reserved.
//

import UIKit

class MarkSelectorCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  var emojis = [String]()
  var reuseIdentifier = "PlayerMark"
  var mark = ""
  
  // MARK: - Collection View Data Source Implementation
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! PlayerMarkCollectionViewCell
    cell.playerMark = emojis[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return emojis.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    if let emojiCell = cell as? PlayerMarkCollectionViewCell {
      mark = emojiCell.playerMark
    }
  }
}
