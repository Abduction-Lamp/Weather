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

    
    private var listOfCities = [
        WeatherViewController(city: "Москва"),
        WeatherViewController(city: "Санкт-Петербург"),
        WeatherViewController(city: "Ялта"),
        WeatherViewController(city: "Киев"),
        WeatherViewController(city: "Владивосток"),
        WeatherViewController(city: "Лондон"),
        WeatherViewController(city: "Турин")
    ]
    private var currentPageIndex = 0
    
    
    private func configureUI() {
        view.backgroundColor = .black
        
        view.addSubview(settingsButton)
        
        delegate = self
        dataSource = self

        setViewControllers([listOfCities[0]], direction: .forward, animated: true, completion: nil)
        
//        settingsButton.addTarget(self, action: #selector(pushSettingsButton(sender:)), for: .touchUpInside)
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
