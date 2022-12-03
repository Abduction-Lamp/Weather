//
//  SettingsViewController.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private enum DisplayType: Int {
        case cities, settings, search
    }
    
    private var settingsView: SettingsView {
        guard let view = self.view as? SettingsView else {
            return SettingsView(frame: self.view.frame)
        }
        return view
    }
    
    private var display: DisplayType = .cities {
        didSet {
            DispatchQueue.main.async {
                if oldValue == .search {
                    self.view.endEditing(true)
                    self.viewModel?.searchCity(city: "")
                }
                
                switch self.display {
                case .cities:   self.switchToCityMode()
                case .search:   self.switchToSearchMode()
                case .settings: self.switchToSettingMode()
                }
                
                self.settingsView.table.reloadData()
            }
        }
    }
    
    private var isTableEditing: Bool = false {
        didSet {
            if oldValue != isTableEditing {
                switchTableEditMode(isEditing: isTableEditing)
            }
        }
    }
    
    private var viewModel: SettingsViewModelProtocol?


    // MARK: Initialization
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛 SettingsViewController init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    override func loadView() {
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.searchResult.bind { _ in
            DispatchQueue.main.async {
                self.settingsView.table.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.save()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel = nil
    }
}


// MARK: - Support methods
//
extension SettingsViewController {

    // MARK: Configure UI Content
    //
    private func configureUI() {
        view = SettingsView()
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = .systemBlue
        navigationController?.toolbar.backgroundColor = .clear
        
        let orderIcon = UIImage(systemName: "line.horizontal.3")
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapSearchButton(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let orderButton = UIBarButtonItem(image: orderIcon, style: .plain, target: self, action: #selector(tapEditButton(sender:)))
        setToolbarItems([searchButton, spaceButton, orderButton], animated: true)
        
        settingsView.segment.addTarget(self, action: #selector(changedDisplayType(sender:)), for: .valueChanged)
        
        settingsView.table.delegate = self
        settingsView.table.dataSource = self
    }
    
    private func switchToCityMode() {
        hideNavigationToolbar(isHidden: false)
        settingsView.table.allowsSelection = false
        settingsView.table.isScrollEnabled = true
    }
    
    private func switchToSearchMode() {
        hideNavigationToolbar(isHidden: true)
        settingsView.table.allowsSelection = true
        settingsView.table.isScrollEnabled = true
    }
    
    private func switchToSettingMode() {
        hideNavigationToolbar(isHidden: true)
        settingsView.table.allowsSelection = false
        settingsView.table.isScrollEnabled = false
    }

    private func hideNavigationToolbar(isHidden: Bool, animated: Bool = true) {
        isTableEditing = false
        navigationController?.setToolbarHidden(isHidden, animated: animated)
    }
    
    private func switchTableEditMode(isEditing: Bool, animated: Bool = true) {
        guard
            let items = navigationController?.toolbar.items,
            let searchButton = items.first,
            let orderButton = items.last
        else { return }
            
        settingsView.table.setEditing(isEditing, animated: animated)
        switch settingsView.table.isEditing {
        case true:
            searchButton.isEnabled = false
            orderButton.tintColor = .systemRed
        case false:
            searchButton.isEnabled = true
            orderButton.tintColor = .systemBlue
            viewModel?.save()
        }
    }
}


// MARK: - Actions extension
//
extension SettingsViewController {
    
    @objc
    func changedDisplayType(sender: UISegmentedControl) {
        guard
            let type = DisplayType.init(rawValue: sender.selectedSegmentIndex),
            display != type
        else { return }
        display = type
    }

    @objc
    func tapEditButton(sender: UIBarButtonItem) {
        isTableEditing = !isTableEditing
    }

    @objc
    func tapSearchButton(sender: UIBarButtonItem) {
        display = .search
    }
}


// MARK: -  UITableViewDelegate & UITableViewDataSource
//
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        var numberOfRows: Int = 0
        switch display {
        case .cities:
            numberOfRows = viewModel.numberOfRows()
        case .settings:
            numberOfRows = 3
        case .search:
            numberOfRows = viewModel.numberOfRowsSearchResult()
        }
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if display == .search {
            return SearchBarHeader.height
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if display == .search {
            guard
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchBarHeader.reuseIdentifier) as? SearchBarHeader
            else { return nil }
            header.searchBar.delegate = self
            header.backButton.addTarget(self, action: #selector(tapBackButton(sender:)), for: .touchUpInside)
            header.setup()
            return header
        }
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch display {
        case .cities:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseIdentifier) as? CityCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel?.makeCityCellViewModel(for: indexPath)
            return cell
            
        case .settings:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier) as? SettingsCell else {
                return UITableViewCell()
            }
            switch indexPath.row {
            case 0:
                cell.viewModel = viewModel?.makeSettingsCellViewModel(TemperatureUnits.self)
            case 1:
                cell.viewModel = viewModel?.makeSettingsCellViewModel(WindSpeedUnits.self)
            case 2:
                cell.viewModel = viewModel?.makeSettingsCellViewModel(PressureUnits.self)
            default:
                return UITableViewCell()
            }
            return cell
            
        case .search:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCityCell.reuseIdentifier) as? SearchCityCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel?.makeSearchCityCellViewModel(for: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch display {
        case .search:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchCityCell.reuseIdentifier) as? SearchCityCell,
                let cellViewModel = viewModel?.makeSearchCityCellViewModel(for: indexPath),
                let viewModel = self.viewModel
            else { return }
            cell.viewModel = cellViewModel
            
            if cellViewModel.isSaved {
                if viewModel.cancelSelection(for: indexPath) {
                    cell.viewModel?.isSaved = false
                    DispatchQueue.main.async { tableView.reloadRows(at: [indexPath], with: .fade) }
                }
            } else  {
                if viewModel.addCity(for: indexPath) {
                    cell.viewModel?.isSaved = true
                    DispatchQueue.main.async { tableView.reloadRows(at: [indexPath], with: .fade) }
                }
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        isTableEditing ? .delete : .none
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return display == .cities
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return display == .cities
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return display == .cities
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if display == .cities {
            viewModel?.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else { return }
        if editingStyle == .delete, viewModel.removeCity(for: indexPath) {
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
}


// MARK: - UISearchBarDelegate
//
extension SettingsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchCity(city: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        display = .cities
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
    }
}

extension SettingsViewController {
    
    @objc
    func tapBackButton(sender: UIButton) {
        display = .cities
    }
}
