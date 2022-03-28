//
//  SettingsViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import UIKit
import Parse

class SettingsViewController: MainViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var timeZonePicker: UIPickerView!
    @IBOutlet private weak var darkModeSwitch: UISwitch!
    
    //properties
    private var pickerData: [String] = [String]()
    private var pickerDataPrefix = "GMT"

    override func viewDidLoad() {
        super.viewDidLoad()
        darkModeSwitch.isOn = traitCollection.userInterfaceStyle == .dark
        
        pickerView()
        timeZonePicker.dataSource = self
        timeZonePicker.delegate = self
        if let timeZone = UDManager.getUserTimeZone(),
           let index = pickerData.firstIndex(of: timeZone) {
            timeZonePicker.selectRow(index, inComponent: 0, animated: true)
        }
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
        let mode: UIUserInterfaceStyle = darkModeSwitch.isOn ? .dark : .light
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
        //save in userDefaults
        DispatchQueue.main.async {
            UDManager.saveUserInterfaceStyle(style: mode.rawValue)
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

// MARK: - UIPickerViewDataSource
extension SettingsViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
      
}
  
// MARK: - UIPickerViewDelegate
extension SettingsViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let newTimeZone = pickerData[row]
        DispatchQueue.main.async {
            UDManager.saveUserTimeZone(timeZone: newTimeZone)
        }
    }
}

