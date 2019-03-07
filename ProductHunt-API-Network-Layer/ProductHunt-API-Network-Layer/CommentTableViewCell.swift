
//
//  CommentTableViewCell.swift
//  ProductHunt-API-Network-Layer
//
//  Created by timofey makhlay on 1/29/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var name: UITextView = {
        var title = UITextView()
        title.text = "name"
        title.font = UIFont(name: "AvenirNext-Regular", size: 12)
        title.textColor = #colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(name)
        name.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    
    // Required with initilizer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
