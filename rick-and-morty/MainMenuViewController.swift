import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var locationsButton: UIButton!
    @IBOutlet weak var episodesButton: UIButton!
    @IBOutlet weak var charactersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    @IBAction func didTappedCharactersButton(_ sender: UIButton) {
       // navigationController?.pushViewController(CharactersViewController(), animated: true)
    }
    
    @IBAction func didTappedLocationsButton(_ sender: UIButton) {
    }
    
    @IBAction func didTappedEpisodessButton(_ sender: UIButton) {
    }
    
    func Appearance() {
        navigationController?.navigationBar.tintColor = UIColor(red: 188.0/255.0, green: 214.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        
        let menuButtons = [locationsButton, episodesButton, charactersButton]
        for button in menuButtons {
            button!.layer.cornerRadius = 30
            button!.layer.borderWidth = 1
            button!.clipsToBounds = true
        }
        navigationController?.isNavigationBarHidden = true
    }

}
