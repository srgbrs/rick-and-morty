import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var spinningImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
//        UIView.animate(withDuration: 3, animations: {self.animate()} )
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [unowned self] in
            performSegue(withIdentifier: "toMain", sender: self)
        }
        
    }

    func animate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
               rotation.toValue = NSNumber(value: Double.pi * 2)
               rotation.duration = 1
               rotation.isCumulative = true
               rotation.repeatCount = Float.greatestFiniteMagnitude
               spinningImage.layer.add(rotation, forKey: "rotationAnimation")
        
       
    }

}

