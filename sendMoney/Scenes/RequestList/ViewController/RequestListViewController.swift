//
//  RequestListViewController.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 21/01/2025.
//

import UIKit

class RequestListViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: [RequestModel] = []
    private let viewModel: RequestListViewModel
    
    init(viewModel: RequestListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = UIStrings.requestListTitle.localized
        configureTableView()
        retrieveData()
    }

}

private extension RequestListViewController {
    func configureTableView() {
        tableView.register(UINib(nibName: "\(RequestTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(RequestTableViewCell.self)")
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func retrieveData() {
        viewModel.retrieveRequests(onComplete: {[weak self] data in
            self?.dataSource = data
            self?.tableView.reloadData()
        })
    }
    
    func navigateToDetails(request: RequestModel) {
        let viewModel = RequestDetailsViewModel(request: request)
        let viewController = RequestDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RequestListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RequestTableViewCell.self)") as? RequestTableViewCell
        cell?.selectionStyle = .none
        let model = dataSource[indexPath.row]
        cell?.configureCell(with: model)
        cell?.onButtonClicked = {[weak self] in
            self?.navigateToDetails(request: model)
        }
        return cell ?? .init()
    }
}
