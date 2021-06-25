import UIKit

class test1CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setup( hero: Hero) {
        self.image.downloaded(from: hero.image)
        self.label.text = hero.name
        
    }
}
