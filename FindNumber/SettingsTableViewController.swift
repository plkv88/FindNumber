//
//  SettingsTableViewController.swift
//  FindNumber
//
//  Created by Алексей Поляков on 06.06.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var switchTimer: UISwitch!
    @IBOutlet weak var timeForGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    func loadSettings(){
        timeForGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) sec."
        switchTimer.isOn = Settings.shared.currentSettings.timerState
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController{
                vc.data = [10,20,30,40,50,60,70,80,90,100,110,120]
            }
        default:
            break
        }
    }
    
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    @IBAction func changeTimerState(_ sender: UISwitch) {
        
        Settings.shared.currentSettings.timerState = sender.isOn
    }
    
}
