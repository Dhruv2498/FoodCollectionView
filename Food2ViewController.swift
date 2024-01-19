//
//  Food2ViewController.swift
//  FoodCollectionView
//
//  Created by Mac on 05/12/23.
//

import UIKit

class Food2ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var NameCollectionView: UICollectionView!
  var imageUrls: [String] = []
  override func viewDidLoad() {
    super.viewDidLoad()

    NameCollectionView.dataSource = self
      NameCollectionView.delegate = self

          // Populate imageUrls with random Unsplash URLs
          for _ in 0..<20 { // You can adjust the number of items as needed
              let randomInt = Int.random(in: 0..<15)
              let imageUrl = "https://source.unsplash.com/random/800x600?pizza&\(randomInt)"
              imageUrls.append(imageUrl)
          }

          NameCollectionView.reloadData()
      self.NameCollectionView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
      self.registerNib()
  }
    private func registerNib() {
            let tblNib = UINib(nibName: "CollectionViewCell", bundle: nil)
            self.NameCollectionView.register(tblNib, forCellWithReuseIdentifier: "CollectionViewCell")
        }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return imageUrls.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
          cell.layer.cornerRadius = 20
                 // Configure the cell with the image URL
                 let imageUrl = imageUrls[indexPath.item]
                 if let url = URL(string: imageUrl) {
                     cell.ImageView.load(url: url)
                 }

                 return cell
             }
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             // Calculate the height for the item at the specified indexPath
          let cellWidth: CGFloat = 250 // You can adjust this based on your layout requirements
          let cellHeight: CGFloat = 150
          // Set the default height or calculate dynamically

             return CGSize(width: cellWidth, height: cellHeight)
         }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 10
      }
      }
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
