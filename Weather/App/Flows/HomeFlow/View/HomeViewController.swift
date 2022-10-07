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
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        page.view.translatesAutoresizingMaskIntoConstraints = false
        page.view.backgroundColor = .clear
        return page
    }()
    
    private var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.allowsContinuousInteraction = true
        control.isUserInteractionEnabled = false
        control.backgroundStyle = .automatic
        control.tintColor = .white
        return control
    }()
    
    private var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .highlighted)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()
    
    private var statusDay: TimeOfDay? {
        didSet {
            DispatchQueue.main.async {
                self.gradientLayer.colors = self.const.gradient.fetch(status: self.statusDay)
                self.view.setNeedsLayout()
            }
        }
    }
    
    private var viewModel: HomeViewModelProtocol


    // MARK: Initialization
    //
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛 HomeViewController init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    //
    override func loadView() {
        super.loadView()
        configureUI()
        
        viewModel.pages.bind { [weak self] pages in
            guard let self = self else { return }
            if pages.isEmpty {
                self.pageViewController.setViewControllers([UIViewController()], direction: .forward, animated: false, completion: nil)
                self.gradientLayer.colors = self.const.gradient.indefinite
            } else {
                self.pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
                pages[0].viewModel?.statusDay.bind({ status in
                    self.statusDay = status
                    self.gradientLayer.colors = self.const.gradient.indefinite
                })
            }
            self.pageControl.numberOfPages = self.viewModel.pages.value.count
            self.pageControl.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0)
            self.pageControl.currentPage = 0
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
        view.addSubview(pageControl)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        settingsButton.addTarget(self, action: #selector(tapSettingsButton(sender:)), for: .touchUpInside)
                
        placementUI()
    }
    
    private func placementUI() {
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            pageControl.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 250),

            settingsButton.topAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: const.size.icon.width)
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
        
        guard index > 0 else { return nil }
        return viewModel.pages.value[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let current = viewController as? WeatherViewController,
            let index = viewModel.pages.value.firstIndex(of: current)
        else { return nil }

        guard index < (viewModel.pages.value.count - 1) else { return nil }
        return viewModel.pages.value[index + 1]
    }
    
    // TODO:    - pageControl:
    /// Индикатор текущей страницы определяеться не оптимальным образом
    /// путем поиска индекса в массиве
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed,
              let current = pageViewController.viewControllers?.first as? WeatherViewController,
              let index = viewModel.pages.value.firstIndex(where: { $0 == current })
        else { return }
        
        current.viewModel?.statusDay.bind({ self.statusDay = $0 })
        pageControl.currentPage = index
    }
}
