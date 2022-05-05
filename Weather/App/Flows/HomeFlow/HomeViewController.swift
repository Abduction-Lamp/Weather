//
//  ViewController.swift
//  Weather
//
//  Created by Владимир on 12.04.2022.
//

import UIKit

final class HomeViewController: UIPageViewController {

    private var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
        return button
    }()
    
    
    override func loadView() {
        super.loadView()
        configureUI()
    }

    var storage = Storage()
    var network = Network()
    
    
    var settings = Settings()

    
    
    // MARK: - Lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage.featch { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.settings = result
//                print(self.settings.cities)
                self.makeList()
            case .failure(let error):
                print(error)
                self.settings = self.storage.reset()
                let city = CityData(eng: "Moscow", rus: "Москва", latitude: 55.7504461, longitude: 37.6174943)
                self.makeList()
                self.settings.cities.append(city)
                self.storage.save(self.settings)
            }
        }
    }
    
    private var listOfCities: [WeatherViewController] = []
//        WeatherViewController(city: "Москва"),
//        WeatherViewController(city: "Санкт-Петербург"),
//        WeatherViewController(city: "Ялта"),
//        WeatherViewController(city: "Киев"),
//        WeatherViewController(city: "Владивосток"),
//        WeatherViewController(city: "Лондон"),
//        WeatherViewController(city: "Турин")
//    ]
    private var currentPageIndex = 0
    
    
    private func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(settingsButton)
        
        delegate = self
        dataSource = self

//        setViewControllers([listOfCities[0]], direction: .forward, animated: true, completion: nil)
        
        settingsButton.addTarget(self, action: #selector(tapSettingsButton(sender:)), for: .touchUpInside)
        placementUI()
    }
    
    private func placementUI() {
        let padding = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        let size = CGSize(width: 25, height: 25)

        let safeArea = self.view.safeAreaLayoutGuide
        
        settingsButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -padding.right).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    private func makeList() {
        for city in settings.cities {
            let viewModel = WeatherViewModel(city: city)
            listOfCities.append(WeatherViewController(viewModel: viewModel))
        }
        if !settings.cities.isEmpty {
            DispatchQueue.main.async {
                self.setViewControllers([self.listOfCities[0]], direction: .forward, animated: true, completion: nil)
            }
        }
    }
}



extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let current = viewController as? WeatherViewController,
            let index = listOfCities.firstIndex(of: current)
        else { return nil }
        
        currentPageIndex = index
        guard index > 0 else { return nil }
        return listOfCities[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let current = viewController as? WeatherViewController,
            let index = listOfCities.firstIndex(of: current)
        else { return nil }

        currentPageIndex = index
        guard index < (listOfCities.count - 1) else { return nil }
        return listOfCities[index + 1]
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return listOfCities.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPageIndex
    }
}


extension HomeViewController {
    
    @objc
    func tapSettingsButton(sender: UIButton) {
        let settingsViewModel = SettingsViewModel(settings: settings, storage: storage, network: network)
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        let navigationVC = UINavigationController(rootViewController: settingsViewController)
        self.present(navigationVC, animated: true, completion: nil)
    }
}


