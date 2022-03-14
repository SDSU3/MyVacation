//
//  HomeViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 10.03.22.
//

import UIKit

class HomeViewController: MainViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var vacationCollectionView: UICollectionView!
    @IBOutlet private weak var addVacationButton: UIButton!
    
    // properties
    private let vacationDetailSegue = "moveToVacationDetail"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpComponents()
    }
    
    // MARK: - init
    static func load(with input: String) -> HomeViewController {
       let viewController = HomeViewController.loadFromStoryboard()
       return viewController
    }
    
    private func setUpComponents() {
        // colleciton view
        vacationCollectionView.registerCell(with: VacationCell.self)
        vacationCollectionView.delegate = self
        vacationCollectionView.dataSource = self
        
        addVacationButton.roundCorners(with: 15)
        addVacationButton.layer.masksToBounds = false
        addVacationButton.addShadow(of: .gray, radius: 3, offset: CGSize(width: 3, height: 3))
    }
    
    @IBAction func userProfileClicked(_ sender: UIButton) {
    }
    
    @IBAction func addVacation(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == vacationDetailSegue {
            if let viewController = segue.destination as? VacationDetailsViewController {
                
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 // for testing purpose
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = vacationCollectionView.frame.width - 30
        let height = width * 0.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vacationCollectionView.dequeReusableCell(with: VacationCell.self, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: vacationDetailSegue, sender: indexPath)
    }
    
    
}
