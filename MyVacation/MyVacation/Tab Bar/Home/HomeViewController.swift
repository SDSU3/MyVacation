//
//  HomeViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 10.03.22.
//

import UIKit
import Parse

protocol VacationDelegate {
    func didUpdateVacations(with message: String)
}

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
        DispatchQueue.main.async { [weak self] in
            self?.loadVacations()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vacationCollectionView.reloadData()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - init
    static func load() -> HomeViewController {
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
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == vacationDetailSegue {
            if let viewController = segue.destination as? VacationDetailsViewController {
                guard let index = sender as? IndexPath else { return }
                viewController.vacation = vacations[index.row]
                viewController.delegate = self
            }
        }
    }

    private func logOut(){
        PFUser.logOut()
        let loginViewController = SignInUpViewController.loadController()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
    }
    
    private func showAlert(with text: String, completion: @escaping ()-> Void){
        let alert = UIAlertController(title: "Update", message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            alert.dismiss(animated: true, completion: {
                completion()
            })
        })
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    private func loadVacations() {
        UserServices.loadVacations(completion: { [weak self] result in
            switch result {
            case .success(let vacations):
                guard let vacations = vacations else { return }

                self?.vacations = vacations
                DispatchQueue.main.async {
                    self?.vacationCollectionView.reloadData()
                }
            case .failure(_):
                self?.showAlert(with: "something went wrong", completion: {})
            }
        })
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

extension HomeViewController: VacationDelegate {
    func didUpdateVacations(with message: String) {
        vacations.removeAll()
        showAlert(with: message, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        })
        loadVacations()
    }
}


