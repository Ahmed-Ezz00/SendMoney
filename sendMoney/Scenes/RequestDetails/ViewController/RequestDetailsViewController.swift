//
//  RequestDetailsViewController.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 21/01/2025.
//

import UIKit

class RequestDetailsViewController: BaseViewController {

    @IBOutlet private weak var stackView: UIStackView!
    
    private let viewModel: RequestDetailsViewModel
    
    init(viewModel: RequestDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = UIStrings.requestDetailsTitle.localized
        reloadData()
    }
}

private extension RequestDetailsViewController {
    
    func reloadData() {
        for (key, value) in viewModel.request.details ?? [:] {
            addLineStackView(title: key, value: value)
        }
        addLineStackView(title: RequestConstant.requestId.rawValue, value: viewModel.request.id?.description)
    }

    func addLineStackView(title: String?, value: String?) {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .primaryTextColor
        titleLabel.font = .title
        titleLabel.numberOfLines = .zero
        let valueLabel = UILabel()
        valueLabel.numberOfLines = .zero
        valueLabel.text = value
        valueLabel.textColor = .secondaryTextColor
        valueLabel.font = .title
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(valueLabel)
        stackView.insertArrangedSubview(horizontalStackView, at: .zero)
    }
}
