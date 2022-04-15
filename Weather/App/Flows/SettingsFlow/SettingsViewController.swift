//
//  SettingsViewController.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private var settingsView: SettingsView {
        guard let view = self.view as? SettingsView else {
            return SettingsView(frame: self.view.frame)
        }
        return view
    }
    
    
    private var display: SettingsDisplayType = .cities {
        didSet {
            DispatchQueue.main.async {
                self.settingsView.table.reloadData()
            }
        }
    }
    
    private var viewModel: SettingsViewModelProtocol

    private var isTableEditing: Bool = false {
        didSet {
            if oldValue != isTableEditing {
                switchTableEditMode(isEditing: isTableEditing)
            }
        }
    }
    
    
    
    // MARK: - Initiation
    //
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("♻️\tDeinit SettingsViewController")
    }
    
    
    
    // MARK: - Lifecycle
    //
    override func loadView() {
        super.loadView()
        
        configureUI()
        viewModel.display.bind { [weak self] type in
            self?.display = type
        }
    }
    

    // MARK: - Configure UI Content
    //
    private func configureUI() {
        self.view = SettingsView(frame: self.view.frame)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.tintColor = .systemBlue
        self.navigationController?.toolbar.backgroundColor = .white
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapSearchButton(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let orderButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(tapEditButton(sender:)))
        self.setToolbarItems([searchButton, spaceButton, orderButton], animated: true)

        settingsView.segment.addTarget(self, action: #selector(changedDisplayType(sender:)), for: .valueChanged)
        
        settingsView.table.delegate = self
        settingsView.table.dataSource = self
    }
}



extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return page == .search ? 50 : 0
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch page {
//        case .search:
//            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsCitiesHeader.reuseIdentifier) as? SettingsCitiesHeader else {
//                return nil
//            }
//            header.searchBar.delegate = self
//            return header
//        case .settings, .cities:
//            return nil
//        }
        
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch display {
//        case .cities:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCityCell.reuseIdentifier) as? SettingsCityCell else {
//                return UITableViewCell()
//            }
//            cell.setData(city: cities.list[indexPath.row])
//            return cell
//
//        case .settings:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSegmentCell.reuseIdentifier) as? SettingsSegmentCell else {
//                return UITableViewCell()
//            }
//            switch indexPath.row {
//            case 0:
//                let index = UserDefaults.standard.integer(forKey: key.temperature)
//                cell.setData(label: "Температура", items: ["\u{00B0}C", "\u{00B0}F", "\u{00B0}K"], selected: index)
//                cell.segmentControl.addTarget(self, action: #selector(temperatureUnitsOfMeasurementChanged(sender:)), for: .valueChanged)
//                return cell
//
//            case 1:
//                let index = UserDefaults.standard.integer(forKey: key.wind)
//                cell.setData(label: "Скорость ветра", items: ["м/с", "км/ч"], selected: index)
//                cell.segmentControl.addTarget(self, action: #selector(windSpeedUnitsOfMeasurementChanged(sender:)), for: .valueChanged)
//                return cell
//
//            case 2:
//                let index = UserDefaults.standard.integer(forKey: key.pressure)
//                cell.setData(label: "Давление", items: ["мм рт. ст.", "гПа"], selected: index)
//                cell.segmentControl.addTarget(self, action: #selector(pressureUnitsOfMeasurementChanged(sender:)), for: .valueChanged)
//                return cell
//
//            default:
//                return UITableViewCell()
//            }
//        default:
        
        
//            return UITableViewCell()
//        }
        
        switch display {
        case .cities:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCityCell.reuseIdentifier) as? SettingsCityCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.cityCellViewModel(for: indexPath)
            return cell
        case .settings:
            return UITableViewCell()
        case .search:
            return UITableViewCell()
        }
    }

    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
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
            viewModel.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
        }
    }
}




// MARK: - Actions extension
//
extension SettingsViewController {
    
    @objc
    func changedDisplayType(sender: UISegmentedControl) {
        guard let type = SettingsDisplayType.init(rawValue: sender.selectedSegmentIndex) else { return }
        type == .cities ? hideNavigationToolbar(isHidden: false) : hideNavigationToolbar(isHidden: true)
        viewModel.changeDisplayType(type)
    }

    @objc
    func tapEditButton(sender: UIBarButtonItem) {
        isTableEditing = !isTableEditing
    }

    @objc
    func tapSearchButton(sender: UIBarButtonItem) {
        hideNavigationToolbar(isHidden: true)
        viewModel.changeDisplayType(.search)
    }

    
    private func hideNavigationToolbar(isHidden: Bool, animated: Bool = true) {
        isTableEditing = false
        navigationController?.setToolbarHidden(isHidden, animated: animated)
    }
    
    private func switchTableEditMode(isEditing: Bool, animated: Bool = true) {
        guard
            let items = self.navigationController?.toolbar.items,
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
            viewModel.save()
        }
    }
    

    @objc
    func changedTemperatureUnit(sender: UISegmentedControl) {
//        DispatchQueue.main.async {
//            UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: self.key.temperature)
//        }
//        // TODO: - Обновить данные
    }

    @objc
    func changedWindSpeedUnit(sender: UISegmentedControl) {
//        DispatchQueue.main.async {
//            UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: self.key.wind)
//        }
//        // TODO: - Обновить данные
    }

    @objc
    func changedPressureUnit(sender: UISegmentedControl) {
//        DispatchQueue.main.async {
//            UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: self.key.pressure)
//        }
//        // TODO: - Обновить данные
    }
}
