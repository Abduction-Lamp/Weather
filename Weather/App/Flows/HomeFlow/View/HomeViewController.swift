//
//  ViewController.swift
//  Weather
//
//  Created by Владимир on 12.04.2022.
//

import UIKit

final class HomeViewController: UIViewController {

    private let const = DesignConstants.shared
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.locations = [0 as NSNumber, 1 as NSNumber]
        layer.startPoint = CGPoint.zero
        layer.endPoint = CGPoint(x: 0, y: 1)
        return layer
    }()
    
    private let pageViewController: UIPageViewController = {
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        page.view.translatesAutoresizingMaskIntoConstraints = false
        page.view.backgroundColor = .clear
        return page
    }()
    
    private var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
        return button
    }()
    
    private var statusDay: TimeOfDay? {
        didSet {
            if oldValue != statusDay {
                DispatchQueue.main.async {
                    self.gradientLayer.colors = self.const.gradient.fetch(status: self.statusDay)
                    self.view.setNeedsLayout()
                }
            }
        }
    }
    
    private var currentIndexPage = 0
    var viewModel: HomeViewModelProtocol

    
    // MARK: Initialization
    ///
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛\tHomeViewController init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    ///
    override func loadView() {
        super.loadView()
        configureUI()
        
        viewModel.pages.bind { [weak self] pages in
            guard let self = self else { return }
            self.currentIndexPage = 0
            if pages.isEmpty {
                self.pageViewController.setViewControllers([UIViewController()], direction: .forward, animated: false, completion: nil)
                self.gradientLayer.colors = self.const.gradient.indefinite
                self.view.setNeedsLayout()
            } else {
                self.pageViewController.setViewControllers([pages[self.currentIndexPage]], direction: .forward, animated: false, completion: nil)
                pages[self.currentIndexPage].viewModel?.statusDay.bind({ status in
                    self.statusDay = status
                    self.gradientLayer.colors = self.const.gradient.indefinite
                })
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
}


// MARK: - Support methods
//
extension HomeViewController {
    
    private func configureUI() {
        view.layer.addSublayer(gradientLayer)

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(settingsButton)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self

        settingsButton.addTarget(self, action: #selector(tapSettingsButton(sender:)), for: .touchUpInside)
    
        placementUI()
    }
    
    private func placementUI() {
        let size = CGSize(width: 25, height: 25)
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -const.padding.medium.right),
            settingsButton.widthAnchor.constraint(equalToConstant: size.width),
            settingsButton.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
}


// MARK: - Actions
//
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


// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
//
extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let current = viewController as? WeatherViewController,
            let index = viewModel.pages.value.firstIndex(of: current)
        else { return nil }
        
        currentIndexPage = index
        guard index > 0 else { return nil }
        return viewModel.pages.value[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let current = viewController as? WeatherViewController,
            let index = viewModel.pages.value.firstIndex(of: current)
        else { return nil }

        currentIndexPage = index
        guard index < (viewModel.pages.value.count - 1) else { return nil }
        return viewModel.pages.value[index + 1]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard
            completed,
            let current = pageViewController.viewControllers?.first as? WeatherViewController
        else { return }
        current.viewModel?.statusDay.bind({ status in
            self.statusDay = status
        })
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel.pages.value.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndexPage
    }
}
