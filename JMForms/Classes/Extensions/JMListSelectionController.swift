//
//  JMFormListSelectionController.swift
//  SecondBook
//
//  Created by Jakob Mikkelsen on 25/01/2019.
//  Copyright © 2019 AppMent. All rights reserved.
//

import UIKit

struct JMListSelection {
    let options: [Any]
    let isMultipleSelection: Bool
}
protocol JMListSelectionControllerDelegate: class {
    func didSelect(value: Any?)
}

class JMListSelectionController: UITableViewController {
    
    let hapticFeedback = UISelectionFeedbackGenerator()
    
    public weak var delegate: JMListSelectionControllerDelegate?
    public var options: [Any]?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barStyle = .default
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem!.backBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hapticFeedback.prepare()
        
        // TableView UI
        tableView.estimatedRowHeight = 25
        tableView.estimatedSectionHeaderHeight = 5
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 5
        tableView.contentInset = .init(top: 5, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor(r: 239, g: 239, b: 244)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "JMFormListSelectionControllerCell")
        tableView.register(JMFormListSelectionControllerHeaderView.self, forHeaderFooterViewReuseIdentifier: "JMFormListSelectionControllerHeaderView")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JMFormListSelectionControllerCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "AvenirNext-Regular", size: 14)!
        
        if let value = options?[indexPath.row] as? String {
            cell.textLabel?.text = " " + value
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hapticFeedback.selectionChanged()
        
        let value = options?[indexPath.row]
        delegate?.didSelect(value: value)
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JMFormListSelectionControllerHeaderView") as? JMFormListSelectionControllerHeaderView else { return UITableViewHeaderFooterView(frame: .zero) }
        header.contentView.backgroundColor = .white
        if section == 0 {
            header.titleLabel.text = "Title of the header"
            header.subtitleLabel.text = "Description of the header"
            return header
        }
        
        return UIView()
    }
}

class JMFormListSelectionControllerHeaderView: UITableViewHeaderFooterView {
    
    lazy private(set) var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.minimumScaleFactor = 0.75
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        return label
    }()
    
    lazy private(set) var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        return label
    }()
    
    override func prepareForReuse() {
        titleLabel.text = nil
        subtitleLabel.text = nil
        super.prepareForReuse()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subtitleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
