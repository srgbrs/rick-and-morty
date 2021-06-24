import UIKit
import Network



class apiTestViewController: UIViewController {
    @IBOutlet weak var testingCollectionView: UICollectionView!
    @IBOutlet weak var navBarItem: UINavigationItem!
    @IBOutlet weak var alterSearchBar: UISearchBar!
    
    var heroRes2 = [Hero]()
    var heroRes3 : [Hero] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       Appearance()

        
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
        print("heroRes3: " + String(heroRes3.count))
        let fil = heroRes3.filter { $0.name.hasPrefix("Albert") }
        print(fil.count)
        
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
            
            print(self.heroRes2.count)
        }).resume()
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.heroRes2.removeAll()
        for item in self.heroRes3 {
            if (item.name.lowercased().contains((alterSearchBar.text?.lowercased())!)) {
                self.heroRes2.append(item)
            }
        }
        
        if (alterSearchBar.text!.isEmpty) {
            self.heroRes2 = heroRes3
        }
        self.testingCollectionView.reloadData()
    }
    
    
    
    func Appearance() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Characters"
        
        let filterButton : UINavigationItem = UINavigationItem()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 188.0/255.0, green: 214.0/255.0, blue: 90.0/255.0, alpha: 1.0)]

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filterNavigationBarItem"), style: .plain, target: self, action: .none)
        
        if let layout = testingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
            layout.headerReferenceSize = CGSize(width: 100, height: 40)

        }
        
    }
}



extension apiTestViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
//        return searchView
//    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchBar", for: indexPath) as! SearchBarView
        headerView.searchBar.barTintColor = .white
        headerView.searchBar.tintColor = .white
        return headerView
    default:
        assert(false, "Unexpected element kind")
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test1CollectionViewCell", for: indexPath) as! test1CollectionViewCell
        //cell.setup(hero: (heroRes!) )
      cell.setup(hero: (self.heroRes2[indexPath.row]) )
        heroRes3 = heroRes2
        
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
     
}

extension apiTestViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 171, height: 217)
    }
}
