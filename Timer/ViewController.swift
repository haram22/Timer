//
//  ViewController.swift
//  Timer
//
//  Created by 김하람 on 2023/04/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    weak var timer: Timer?
    var number: Int = 0 // 처음 설정한 값을 담을 예정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        mainLabel.text = "SET YOUR TIME"
        slider.setValue(0.5, animated: true)
        let normal = UIImage(named: "bear.png")
        slider.setThumbImage(normal, for: .normal)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        // 슬라이더의 벨류값을 메인 레이블에 보여줘야 함. 시간이 지날때마다 바껴야 함.
        // slider.value를 1-60단위로 변환, int, string으로 변환
        let seconds = Int(slider.value * 60)
        print(seconds)
        mainLabel.text = "\(seconds) 초"
        number = seconds
    }
    @objc func doSomething(){
        if number > 0 {
            number -= 1
            slider.value = Float(number) / Float(60)
            mainLabel.text = "\(number) 초"
        } else {
            number = 0
            mainLabel.text = "SET YOUR TIME"
            // 타이머를 비활성화 해줘야 함.
            timer?.invalidate()
            // 소리가 나게 해야 한다.
            AudioServicesPlayAlertSound(SystemSoundID(1322))

        }
    }
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초씩 지나갈 때마다 무언가를 실행
        // 검색어 : how to run a function after some time in swift
        timer?.invalidate() // timer가 이미 존재한다면 비활성화 할 수 있음.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 셋팅 필요 - 메인라벨 초기화
        mainLabel.text = "SET YOUR TIME"
        slider.value = 0.5
        number = 0
        timer?.invalidate()
        // timer = nil 로 해도 된다.
    }
}

