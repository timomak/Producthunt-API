//
//  TableViewCell.swift
//  ProductHunt-API-Network-Layer
//
//  Created by timofey makhlay on 1/29/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var name: UITextView = {
        var title = UITextView()
        title.text = "name"
        title.font = UIFont(name: "AvenirNext-Bold", size: 16)
        title.textColor = #colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        return title
    }()
    
    var comments: UITextView = {
        var title = UITextView()
        title.text = "Comments: "
        title.font = UIFont(name: "AvenirNext-Bold", size: 12)
        title.textColor = #colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        return title
    }()
    
    var votes: UITextView = {
        var title = UITextView()
        title.text = "Votes: "
        title.font = UIFont(name: "AvenirNext-Bold", size: 12)
        title.textColor = #colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        return title
    }()
    
    var botLabel: UITextView = {
        var title = UITextView()
        title.text = "Label"
        title.font = UIFont(name: "AvenirNext-Bold", size: 14)
        title.textColor = #colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        return title
    }()
    
    var cellImage: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return image
    }()
    
    var post: Post? {
        didSet {
            guard let post = post else { return }
            name.text = post.name
            botLabel.text = post.tagline
            comments.text = "Comments: \(post.commentsCount)"
            votes.text = "Votes: \(post.votesCount)"
//            let data = try? Data(contentsOf: post.previewImageURL)
//            imageView?.image = UIImage(data: data!)
//            updatePreviewImage()
        }
    }
    
    func updatePreviewImage() {
        imageView?.image = UIImage(named: "placeholder")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(name)
        name.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 2, left: 15, bottom: 0, right: 0))
        
        let labelStack = UIStackView(arrangedSubviews: [comments, votes])
        labelStack.alignment = .center
        labelStack.spacing = 10
        labelStack.axis = .horizontal
        
        addSubview(labelStack)
        labelStack.anchor(top: name.topAnchor, leading: leadingAnchor, bottom: name.bottomAnchor, trailing: nil, padding: .init(top: 0, left: (bounds.width / 2) + 30, bottom: 0, right: 0))
        
        addSubview(botLabel)
        botLabel.anchor(top: nil, leading: name.leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        
        addSubview(cellImage)
//        cellImage.anchor(top: name.bottomAnchor, leading: leadingAnchor, bottom: botLabel.topAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        cellImage.centerHorizontalOfView(to: self)
        cellImage.anchor(top: name.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0), size: .init(width: 350, height: 160))
    }
    
    // Required with initilizer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
