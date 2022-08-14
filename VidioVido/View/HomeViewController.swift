//
//  HomeViewController.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    static func create() -> HomeViewController {
        let view = HomeViewController()
        view.viewModel = HomeViewModel(view: view)
        return view
    }
    
    var viewModel: HomeViewModelInput!
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.dataSource = self
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.viewModel.viewDidLoad()
    }
}

// MARK: - HomeViewModelOutput
extension HomeViewController: HomeViewModelOutput {
    func updateContent() {
        self.tableView.reloadData()
    }
}

// MARK: - Setup
extension HomeViewController {
    private func setupView() {
        self.view.backgroundColor = .white
        self.tableView.register(
            LandscapeCell.self,
            forCellReuseIdentifier: LandscapeCell.reuseIdentifier)
        self.tableView.register(
            PortraitCell.self,
            forCellReuseIdentifier: PortraitCell.reuseIdentifier)
    }
    
    private func setupConstraint() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor),
            self.tableView.topAnchor.constraint(
                equalTo: self.view.topAnchor),
            self.tableView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.viewModel.contentSize()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: SectionCell
        let index = indexPath.row
        if self.viewModel.isPortrait(at: index) {
            cell = tableView.dequeueReusableCell(
                withIdentifier: PortraitCell.reuseIdentifier,
                for: indexPath) as! PortraitCell
        } else {
            cell = tableView.dequeueReusableCell(
                withIdentifier: LandscapeCell.reuseIdentifier,
                for: indexPath) as! LandscapeCell
        }
        cell.setup(items: self.viewModel.getSectionItems(at: index))
        return cell
    }
}
