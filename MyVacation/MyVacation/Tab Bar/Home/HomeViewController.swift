//
//  HomeViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 10.03.22.
//

import UIKit
import Parse

class HomeViewController: MainViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var vacationCollectionView: UICollectionView!
    @IBOutlet private weak var addVacationButton: UIButton!
    @IBOutlet private weak var userMenuButton: UIButton!
    
    // properties
    private let vacationDetailSegue = "moveToVacationDetail"
    private var vacations: [Vacation] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpComponents()
        self.setUpUserMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - init
    static func load(with vacations: [Vacation]?) -> HomeViewController {
        let viewController = HomeViewController.loadFromStoryboard()
        viewController.vacations = vacations ?? []
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
    
    private func setUpUserMenu() {
        userMenuButton.showsMenuAsPrimaryAction = true
        let items = UIMenu(title: "more", options: .displayInline, children: [
            UIAction(title: "log out", handler: {_ in self.logOut()})
        ])
        let menu = UIMenu(title: "", children: [items])
        userMenuButton.menu = menu
    }
    
    @IBAction func addVacation(_ sender: UIButton) {
        let viewController = PlanViewController.load(with: "input bla bla")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == vacationDetailSegue {
            if let viewController = segue.destination as? VacationDetailsViewController {
                guard let index = sender as? IndexPath else { return }
                viewController.vacation = vacations[index.row]
            }
        }
    }

    private func logOut(){
        PFUser.logOut()
        let loginViewController = SignInUpViewController.load(with: "bla bla")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vacations.count // for testing purpose
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = vacationCollectionView.frame.width - 30
        let height = width * 0.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vacationCollectionView.dequeReusableCell(with: VacationCell.self, indexPath: indexPath)
        let vacation = vacations[indexPath.row]
        cell.setUp(with: vacation)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: vacationDetailSegue, sender: indexPath)
    }
}


