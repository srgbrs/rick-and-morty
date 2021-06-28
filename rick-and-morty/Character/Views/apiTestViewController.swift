import UIKit
import Network

var heroRes3 : [Hero] = []
var filtering = false
var filteredArray = [Hero]()

class apiTestViewController: UIViewController {
    @IBOutlet weak var testingCollectionView: UICollectionView!
    @IBOutlet weak var navBarItem: UINavigationItem!
    
    var heroRes2 = [Hero]()
    var searching = false
    
    var searched = [Hero]()
    
    let searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad() {
        super.viewDidLoad()
       Appearance()
        configureSearchController()

        let _url = "https://rickandmortyapi.com/api/character/"
        
        for x in 0..<30 {
            var url2 = _url + String(x+1)
            print("urlAPI: " + url2 + " ind: " + String(x))
            getFromJson(url: URL(string: url2)!, index: x)
        }
       
        print("heroRes2: " + String(heroRes2.count))

        testingCollectionView.dataSource = self
        testingCollectionView.delegate = self
        testingCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       // print("heroRes3: " + String(heroRes3.count))

        testingCollectionView.reloadData()
    }
    
    func getFromJson(url: URL, index: Int)  {
    
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            do { // if got data:
                try self.heroRes2.append(JSONDecoder().decode(Hero.self, from: data))
                if (self.heroRes2.count == index+1) {
                    print("appended")
                }
                print("indx: " + String(index) , String(decoding: data, as: UTF8.self))

            } catch {
                print(error.localizedDescription)
                print("ERROR PARSING")
            }
        }).resume()
    }
    
    
    func Appearance() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Characters"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 188.0/255.0, green: 214.0/255.0, blue: 90.0/255.0, alpha: 1.0)]
        
        if let layout = testingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
            layout.headerReferenceSize = CGSize(width: 100, height: 40)

        }
    }
    
    
    func filterBttnTouched(sender: UIBarButtonItem) {

//        performSegue(withIdentifier: "toFilter", sender: self)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [unowned self] in
            performSegue(withIdentifier: "toFilter", sender: self)
        }
    }
    
    func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Введите имя"
    }
  
}

extension apiTestViewController: UICollectionViewDataSource , UICollectionViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UIPickerViewDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        
        if !searchText.isEmpty {
            searching = true
            searched.removeAll()
            
            for x in heroRes2 {
                if x.name.lowercased().contains(searchText.lowercased())
                {
                    searched.append(x)
                }
            }
            
        } else {
            searching = false
            searched.removeAll()
            searched = heroRes3
        }
        testingCollectionView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searched.removeAll()
        testingCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if filtering {
            return filteredArray.count
        } else {
        
        if searching {
            return searched.count
        }
        else {
            return 30
        }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test1CollectionViewCell", for: indexPath) as! test1CollectionViewCell
      
        heroRes3 = heroRes2
        
        if filtering {
            cell.setup(hero: filteredArray[indexPath.row])
            //print("filtering true, filteredArray.count:" + String(filteredArray.count))
        } else {
            if searching {
                //print("filtering false, searching true")
                cell.setup(hero: self.searched[indexPath.row])
        } else {
            //print("filtering false, searching false")
            cell.setup(hero: (heroRes3[indexPath.row]))
        }
            
        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 20
        cell.image.backgroundColor = .white
        cell.image.contentMode = .scaleAspectFill
 
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(identifier: "DetailedViewController") as! DetailedViewController

        desVC.img.downloaded(from: heroRes2[indexPath.row].image)
        desVC.name_.text = heroRes2[indexPath.row].name
        
        self.navigationController?.pushViewController(desVC, animated: true)
    }
}

extension apiTestViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 171, height: 217)
    }
}
