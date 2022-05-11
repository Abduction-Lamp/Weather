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
    
    private var currentPageIndex = 0
    var viewModel: HomeViewModelProtocol

    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛\tHomeViewController init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    //
    override func loadView() {
        super.loadView()
        configureUI()
        
        viewModel.pages.bind { [weak self] pages in
            guard let self = self else { return }
            self.currentPageIndex = 0
            if pages.isEmpty {
                self.setViewControllers([], direction: .forward, animated: false, completion: nil)
            } else {
                self.setViewControllers([pages[self.currentPageIndex]], direction: .forward, animated: false, completion: nil)
            }
        }
    }

    private func configureUI() {
        view.backgroundColor = .black
        view.addSubview(settingsButton)
        
        delegate = self
        dataSource = self

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
}


extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let current = viewController as? WeatherViewController,
            let index = viewModel.pages.value.firstIndex(of: current)
        else { return nil }
        
        currentPageIndex = index
        guard index > 0 else { return nil }
        return viewModel.pages.value[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let current = viewController as? WeatherViewController,
            let index = viewModel.pages.value.firstIndex(of: current)
        else { return nil }

        currentPageIndex = index
        guard index < (viewModel.pages.value.count - 1) else { return nil }
        return viewModel.pages.value[index + 1]
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel.pages.value.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPageIndex
    }
}


extension HomeViewController {
    
    @objc
    func tapSettingsButton(sender: UIButton) {
        if let settingsViewModel = viewModel.makeSettingsViewModel() {
            let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
            let navigationVC = UINavigationController(rootViewController: settingsViewController)
            self.present(navigationVC, animated: true, completion: nil)
        }
    }
}
