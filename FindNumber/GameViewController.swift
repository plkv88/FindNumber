//
//  GameViewController.swift
//  FindNumber
//
//  Created by Алексей Поляков on 03.06.2022.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    lazy var game = Game(countItems: buttons.count){ [weak self] (status, time) in
        guard let self = self else {return}
        if Settings.shared.currentSettings.timerState{
            self.timerLabel.text = time.secondsToString()
        }
        else{
            self.timerLabel.text = ""
        }
        self.updateInfoGame(with: status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen() 
    }

    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.alpha = 0
        sender.isEnabled = false
        setupScreen()
    }
    
    private func setupScreen(){
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI(){
        for index in game.items.indices{
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError{
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch status {
        case .start:
            statusLabel.text = "Game begin!"
            statusLabel.textColor = .black
            newGameButton.alpha = 0
            newGameButton.isEnabled = false
        case .win:
            statusLabel.text = "You win!"
            statusLabel.textColor = .green
            newGameButton.alpha = 1
            newGameButton.isEnabled = true
            if game.isNewRecord{
                showAlert()
            }
        case .lose:
            statusLabel.text = "You lose..."
            statusLabel.textColor = .red
            newGameButton.alpha = 1
            newGameButton.isEnabled = true
        }
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Congratulations!", message: "New record!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
