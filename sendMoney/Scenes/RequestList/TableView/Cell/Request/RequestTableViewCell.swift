//
//  RequestTableViewCell.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 21/01/2025.
//

import UIKit

class RequestTableViewCell: UITableViewCell {

    @IBOutlet private weak var showDetailsButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView! {
        didSet {
            stackView.backgroundColor = .white
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
            stackView.addCorner(8)
        }
    }
    
    var onButtonClicked: (()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureShowDetailsButton()
    }
    
    func configureCell(with request: RequestModel) {
        stackView.arrangedSubviews.forEach { view in
            guard let view = view as? UIStackView else { return }
            view.removeFromSuperview()
        }
        for (key, value) in request.details ?? [:] {
            if shouldAddLine(key: key.lowercased()) {
                addLineStackView(title: key, value: value)
            }
        }
        addLineStackView(title: RequestConstant.requestId.rawValue, value: request.id?.description)
    }
    
    @IBAction private func didShowDetailsPressed(_ sender: Any) {
        onButtonClicked?()
    }
}

private extension RequestTableViewCell {
    func configureShowDetailsButton() {
        showDetailsButton.setTitle(UIStrings.requestListActionTitle.localized, for: .normal)
        showDetailsButton.titleLabel?.font = .title
        showDetailsButton.setTitleColor(.navigationTintColor, for: .normal)
        showDetailsButton.backgroundColor = .actionColor
        showDetailsButton.addCorner(16)
    }
    
    func addLineStackView(title: String?, value: String?) {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
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
    
    func shouldAddLine(key: String)-> Bool {
        return key == RequestConstant.amount.rawValue.lowercased() || key == RequestConstant.service.rawValue.lowercased() || key == RequestConstant.providerName.rawValue.lowercased()
    }
}
