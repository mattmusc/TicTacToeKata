//
//  GameConfigUIViewController.swift
//  iTicTacToe
//
//  Created by Matteo Muscella on 18/11/2018.
//  Copyright © 2018 Matteo Muscella. All rights reserved.
//

import UIKit

class GameConfigUIViewController: UIViewController
{
  let player1MarksVC = MarkSelectorCollectionViewController()
  let player2MarksVC = MarkSelectorCollectionViewController()
  
  @IBOutlet weak var player1Marks: UICollectionView!
  @IBOutlet weak var player2Marks: UICollectionView!
  
  let emojis = [ "🎃", "👻", "👹", "😺", "💀", "🤖", "🤡", "🦇", "🕷" ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    player1MarksVC.emojis = emojis
    player2MarksVC.emojis = emojis
    
    player1Marks.dataSource = player1MarksVC
    player1Marks.delegate = player1MarksVC
    
    player2Marks.dataSource = player2MarksVC
    player2Marks.delegate = player2MarksVC
  }
  
  @IBAction func startPushed(_ sender: UIButton) {
    print("Player 1: \(player1MarksVC.mark), Player 2: \(player2MarksVC.mark)")
  }
  
  // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  // Get the new view controller using segue.destination.
  // Pass the selected object to the new view controller.
 }
}
