import UIKit

class DetailedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    var img = UIImageView()
    var name_ = UILabel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTableViewCell", for: indexPath) as! DetailedTableViewCell
        
        cell.textLabel?.text = "Name"
        cell.textLabel?.textColor = UIColor(red: 188.0/255.0, green: 214.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        cell.setup(string: name_.text ?? "nil")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance()
        
        tableView.delegate = self
        tableView.dataSource = self

        image.image = img.image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        image.image = img.image
    }
    
    func Appearance() {
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
    }

}
