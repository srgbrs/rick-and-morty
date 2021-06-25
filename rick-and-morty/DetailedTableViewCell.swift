import UIKit

class DetailedTableViewCell: UITableViewCell {
 
    @IBOutlet weak var secondRow: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup( hero: Hero) {
        self.secondRow.text = hero.name
    }
    
    func setup( string: String) {
        self.secondRow.text = string
    }
}
