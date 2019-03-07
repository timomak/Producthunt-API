//
//  FeedViewController.swift
//  ProductHunt-API-Network-Layer
//
//  Created by timofey makhlay on 1/29/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // Creating Navbar
    private let navbar: UIView = {
        let navigationBar = UIView()
        navigationBar.alpha = 0
        return navigationBar
    }()
    
    // Addting title to Navbar
    let viewNavbarTitle: UITextView = {
        var title = UITextView()
        title.text = "Product Hunt"
        title.font = UIFont(name: "AvenirNext-Bold", size: 30)
        title.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isSelectable = false
        title.isScrollEnabled = false
        return title
    }()
    
    // Cell ID
    private let cellId = "cellId"
    
    
    // Creating table view
    var tableView = UITableView()
    
    
//    var mockData: [Post] = {
////        var meTube = Post(id: 0, name: "MeTube", tagline: "Stream videos for free!", votesCount: 25, commentsCount: 4)
////        var boogle = Post(id: 1, name: "Boogle", tagline: "Search anything!", votesCount: 1000, commentsCount: 50)
////        var meTunes = Post(id: 2, name: "meTunes", tagline: "Listen to any song!", votesCount: 25000, commentsCount: 590)
////
////        return [meTube, boogle, meTunes]
//    }()
    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupNavbar()
        addTableView()
        updateFeed()
    }
    
    func updateFeed() {
        networkManager.getPosts() { result in
            switch result {
            case let .success(posts):
                self.posts = posts
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func setupNavbar() {
        // Adding Navbar View
        view.addSubview(navbar)
        
        // Navbar Size
        navbar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.bounds.width, height: 100))
        
        // Adding Title to Navbar
        view.addSubview(viewNavbarTitle)
        
        // Title Size
        viewNavbarTitle.anchor(top: navbar.topAnchor, leading: navbar.leadingAnchor, bottom: navbar.bottomAnchor, trailing: nil, padding: .init(top: 45, left: 20, bottom: 5, right: 0))
        
    }

    
    func addTableView() {
        // Add to Table View to View
        view.addSubview(tableView)

        // Table View Size
        tableView.anchor(top: navbar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        // Register Table View Cells
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self

        // Table View
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        tableView.allowsSelection = false
        //        var refreshControl = UIRefreshControl()
        //        tableView.refreshControl = refreshControl
        //        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    

}



extension FeedViewController: UITableViewDataSource {
    // Table View Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Cells one by one using this as a blueprint.
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell

        let post = posts[indexPath.row]
        // Set the cell label text
        cell.post = post
//        cell.selectionStyle = .none
        // Push your cell to the table view
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        let post = posts[indexPath.row]
//    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleting: ", indexPath.row)
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    //     Table View Cell Styling
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("Deselected")
//        let post = posts[indexPath.row]
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        print(indexPath.row)
        
        var commentsView = CommentsViewController()
        commentsView.postID = post.id
        self.present(commentsView, animated: true)
    }
}
