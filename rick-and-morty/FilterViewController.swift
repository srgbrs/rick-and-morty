import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    let pickerData = ["Alive","Dead","Unknown"]
    let pickerData2 = ["Female","Male","Genderless","Unknown"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance()
        statusPicker.dataSource = self
        statusPicker.delegate = self
        genderPicker.delegate = self
        genderPicker.dataSource = self
    }
    

    func Appearance(){
        applyButton.layer.cornerRadius = 10
        applyButton.layer.borderWidth = 1
        
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 1
        
        applyButton.layer.borderColor = CGColor(red: 188.0/255.0, green: 214.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        
        resetButton.layer.borderColor = CGColor(red: 220.0/255.0, green: 47.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        applyButton.clipsToBounds = true
        resetButton.clipsToBounds = true
        
        statusPicker.tintColor = .white
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
              return pickerData.count
          } else {
              return pickerData2.count
          }
           }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString : NSAttributedString
        if pickerView.tag == 1 {
            attributedString = NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            
           } else {
            attributedString = NSAttributedString(string: pickerData2[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
           }
        return attributedString
    }
    
    
           func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
              let selectedText = pickerData[row]
           }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}

class StatusPickerView : UIPickerView, UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "status1"
    }
}

class GenderPickerView : UIPickerView, UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "status2"
    }
}
