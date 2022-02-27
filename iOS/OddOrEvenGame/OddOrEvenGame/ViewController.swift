//
//  ViewController.swift
//  OddOrEvenGame
//
//  Created by 윤수빈 on 2022/02/23.
//
/*
 1. 컴퓨터가 1에서 10까지의 랜덤으로 순자를 선택한다.
 2. 사용자는 가진 구슬 개수를 걸고 홀짝 중의 하나를 선택한다.
 3. 결과값이 화면에 보여진다.
 */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var computerBallCountLbl: UILabel!
    @IBOutlet weak var userBallCountLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    
    var comBallCount: Int = 20
    var userBallCount: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        computerBallCountLbl.text = String(comBallCount)
        userBallCountLbl.text = String(userBallCount)
    }

    @IBAction func gameStartPressed(_ sender: Any) {
        print("게임 시작 ~~!")
        //print(self.getRandom())
        
        let alert = UIAlertController.init(title: "GAME START", message: "홀 짝을 선택해주세요.", preferredStyle: .alert) // actionSheet : 하단에서 나오는거
        
        let oddBtn = UIAlertAction.init(title: "홀", style: .default) { _ in
            print("홀 버튼을 클릭했습니다.")
            
            // guard문에 value 변환 합쳐서 적기 ㅎㅎ
            guard let input = alert.textFields?.first?.text, let value = Int(input) else {
                return
            }
            
            self.getWinner(count: value, select: "홀")
        }
        
        let evenBtn = UIAlertAction.init(title: "짝", style: .default) { _ in
            print("짝 버튼을 클릭했습니다.")
            
            // guard문에 value 변환 따로 적기 ㅎㅎ
            guard let input = alert.textFields?.first?.text else {
                return
            }
            
            guard let value = Int(input) else {
                return
            }
            
            self.getWinner(count: value, select: "짝")
        }
        
        alert.addTextField { textField in
            textField.placeholder = "베팅할 구슬의 개수를 입력해주세요."
        }
        
        alert.addAction(oddBtn)
        alert.addAction(evenBtn)
        
        self.present(alert, animated: true) {
            print("화면이 띄워졌습니다.")
        }
    }
    
    func getWinner(count: Int, select: String){
        
        let com = self.getRandom()
        let comType = com % 2 == 0 ? "짝" : "홀"
        
        var result = comType
        if comType == select {
            print("User Win")
            result = result + "(User Win)"
            self.calculateBalls(winner: "user", count: count)
        }else{
            print("Computer Win")
            result = result + "(Computer Win)"
            self.calculateBalls(winner: "com", count: count)
        }
        
        self.resultLbl.text = result
    }
    
    func calculateBalls(winner: String, count: Int){ // count: 사용자가 입력한 개수
        if winner == "user" {
            self.userBallCount = self.userBallCount + count
            self.comBallCount = self.comBallCount - count
        }else{
            self.userBallCount = self.userBallCount - count
            self.comBallCount = self.comBallCount + count
        }
        
        self.userBallCountLbl.text = "\(self.userBallCount)"
        self.computerBallCountLbl.text = "\(self.comBallCount)"
    }
    
    func getRandom() -> Int {
        return Int(arc4random_uniform(10) + 1)
    }
}
