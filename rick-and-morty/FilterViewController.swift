import UIKit

var filterParameter = (status: "Alive", gender: "Female")

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    let pickerData = ["Alive","Dead","Unknown"]
    let pickerData2 = ["Female","Male","Genderless","Unknown"]
    
    var statusPickerSelection = "Alive", genderPickerSelection = "Female"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Appearance()
        statusPicker.dataSource = self
        statusPicker.delegate = self
        genderPicker.delegate = self
        genderPicker.dataSource = self
    }
    
    @IBAction func applyButtonPressed(_ sender: UIButton) {
        filterParameter.status = statusPickerSelection
        filterParameter.gender = genderPickerSelection

        filtering = true
        filteredArray = heroRes3.filter{$0.status.contains(filterParameter.status) }
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        genderPicker.reloadAllComponents()
        statusPicker.reloadAllComponents()
        statusPicker.selectRow(0, inComponent: 0, animated: true)
        genderPicker.selectRow(0, inComponent: 0, animated: true)
        
        filtering = false

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
            
            if pickerView.tag == 1 {
                  statusPickerSelection = pickerData[row]
                    print(statusPickerSelection)
              } else {
                  genderPickerSelection = pickerData2[row]
                print(genderPickerSelection)
              }
            
           }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}
