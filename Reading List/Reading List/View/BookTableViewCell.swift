//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Stephanie Ballard on 8/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleTextLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
        updateViews()
    }
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleTextLabel.text = book.title
        let checkMarkImage = book.hasBeenRead ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
        hasBeenReadButton.setImage(checkMarkImage, for: .normal)
    }

}
