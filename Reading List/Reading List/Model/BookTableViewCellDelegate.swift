//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Stephanie Ballard on 8/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
