//
//  SettingsViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import UIKit
import Parse

class SettingsViewController: MainViewController {
    @IBOutlet weak var timeZonePicker: UIPickerView!
    var pickerData: [String] = [String]()
    var pickerDataPrefix = "GMT"
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView()
        
        timeZonePicker.dataSource = self
        timeZonePicker.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    // MARK: - init
    static func load() -> SettingsViewController {
       let viewController = SettingsViewController.loadFromStoryboard()
       return viewController
    }
    
    func pickerView() {
        for i in -11...12 {
            if i < 0 {
                pickerData.append("\(pickerDataPrefix)\(i)")
            } else {
                pickerData.append("\(pickerDataPrefix)+\(i)")
            }
        }
    }
    

    @IBAction func switchDarkMode(_ sender: Any) {
        if darkModeSwitch.isOn {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
        
    }
    
    
    @IBAction func enableNotifications(_ sender: Any) {
    }
    
    
    @IBAction func LogOut(_ sender: Any) {
        PFUser.logOut()
        let loginViewController = SignInUpViewController.loadController()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
    }
    
}


extension SettingsViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
      
}
  
  
extension SettingsViewController : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}

