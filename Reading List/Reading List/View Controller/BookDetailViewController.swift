//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Stephanie Ballard on 8/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle = bookTitleTextField.text else { return }
        
        if let unwrappedBook = book {
            bookController?.update(book: unwrappedBook, title: bookTitle, reasonToRead: reasonToReadTextView.text)
        } else {
            bookController?.createBook(title: bookTitle, reasonToRead: reasonToReadTextView.text, hasBeenRead: false)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    private func updateViews() {
        if book != nil {
            bookTitleTextField.text = book?.title
            reasonToReadTextView.text = book?.reasonToRead
            self.title = book?.title
        } else {
            self.title = "Add a new book"
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
