//
//  CommentsViewController.swift
//  ProductHunt-API-Network-Layer
//
//  Created by timofey makhlay on 1/29/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    private let goBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 40)
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        button.addTarget(self, action: #selector(goBackButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var tableView = UITableView()
    
    let cellId = "CommentCell"
    
    var comments: [Comment] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var postID: Int!
    
    var networkManager = NetworkManager()
    
    func updateComments() {
        networkManager.getComments(postID) { result in
            switch result {
            case let .success(comments):
                self.comments = comments
            case let .failure(error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        // Go back button
        view.addSubview(goBackButton)
        goBackButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 20, bottom: 0, right: 0))
        
        addtableView()
        updateComments()
    }
    func addtableView() {
        // Add to Table View to View
        view.addSubview(tableView)
        
        // Table View Size
        tableView.anchor(top: goBackButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        // Register Table View Cells
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Table View
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //        tableView.separatorStyle = UItableViewCell.SeparatorStyle.none
        //        tableView.allowsSelection = false
        //        var refreshControl = UIRefreshControl()
        //        tableView.refreshControl = refreshControl
        //        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc func goBackButtonPressed() {
        self.dismiss(animated: true)
    }
    
}



extension CommentsViewController: UITableViewDataSource {
    // Table View Rows
    func tableView(_ TableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Cells one by one using this as a blueprint.
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CommentTableViewCell
        
        let comment = comments[indexPath.row]
        // Set the cell label text
        cell.name.text = comment.body
        //        cell.selectionStyle = .none
        // Push your cell to the table view
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleting: ", indexPath.row)
        }
    }
}

extension CommentsViewController: UITableViewDelegate {
    //     Table View Cell Styling
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected")
    }
}


