//
//  Comment.swift
//  ProductHunt-API-Network-Layer
//
//  Created by timofey makhlay on 1/29/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

struct Comment: Decodable {
    let id: Int
    let body: String
}

struct CommentApiResponse: Decodable {
    let comments: [Comment]
}
