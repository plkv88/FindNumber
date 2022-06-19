//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Алексей Поляков on 06.06.2022.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "Your record - \(record) sec."
        } else {
            recordLabel.text = "Play at lest one game"
        }
    }
}
