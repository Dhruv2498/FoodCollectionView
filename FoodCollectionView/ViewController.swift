
import UIKit

class ViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
   
    @IBOutlet weak var FoodCollectionView: UICollectionView!
    
    var food = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return food.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodcell", for: indexPath) as! FoodCollectionViewCell
        
        if let imageUrl = URL(string : JsonField.MAIN_URL)
            
        {
            print(imageUrl)
            DispatchQueue.global().async
            {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async{
                        cell.imageview.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth : CGFloat = 150
        let cellheight  : CGFloat = 150
        return CGSize(width: cellwidth, height: cellheight)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Food()
        FoodCollectionView.dataSource = self
        FoodCollectionView.delegate = self
    }
    func Food ()
    {
        let url = URL(string:JsonField.MAIN_URL)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["category_list"] as? NSArray
            {
                for index in 0...20
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let pizza = (object["pizza"]as! String)
                    JsonField.MAIN_URL.append(pizza)
                    
                   
                }
            }
            
        }
        catch
        {print("error=\(error)")
        }
    }
}



