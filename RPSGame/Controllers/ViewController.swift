//
//  ViewController.swift
//  RPSGame
//
//  Created by Hertz on 7/8/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

enum SRP {
    case scissors
    case rock
    case paper
    case ready
    
    /// 버튼의 타이틀을 가지고 이넘 케이스를 생성하는 함수
    static func initialize(_ btnTitle: String) -> Self {
        switch btnTitle {
        case "가위":
            return .scissors
        case "바위":
            return .rock
        case "보":
            return .paper
        default:
            return .ready
        }
    }
    
    /// 라벨 타이틀
    var labelTitle: String {
        switch self {
        case .scissors:
            return "✅가위✅"
        case .rock:
            return "✅바위✅"
        case .paper:
            return "✅보✅"
        case .ready:
            return "✅준비✅"
        }
    }
    
    /// 초기 이미지
    var initialImage: UIImage {
        switch self {
        case .scissors:
            return UIImage(named: "scissors")!
        case .rock:
            return UIImage(named: "rock")!
        case .paper:
            return UIImage(named: "paper")!
        case .ready:
            return UIImage(named: "ready")!
        }
    }
    
}

private extension Reactive where Base: ViewController {
    
    var userSRPState: Binder<SRP> {
        return Binder(base) { vc, srpStatus in
            vc.myImage.image = srpStatus.initialImage
            vc.myChoiceLabel.text = srpStatus.labelTitle
        }
    }
    
    var computerSRPState: Binder<SRP> {
        return Binder(base) { vc, srpStatus in
            vc.computerImage.image = srpStatus.initialImage
            vc.computerChoiceLabel.text = srpStatus.labelTitle
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var computerImage: UIImageView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var computerChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    var viewModel = SRPGameVM()
    var disposeBag = DisposeBag()
    
    var myName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {
        
        viewModel.userSRP
            .bind(to: self.rx.userSRPState)
            .disposed(by: disposeBag)
        
        viewModel.computerSRP
            .bind(to: self.rx.computerSRPState)
            .disposed(by: disposeBag)
        
//        viewModel
//            .userSRP
//            .map{ $0.initialImage }
//            .bind(to: myImage.rx.image)
//            .disposed(by: disposeBag)
//
//        viewModel
//            .userSRP
//            .map{ $0.labelTitle }
//            .bind(to: myChoiceLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel
//            .computerSRP
//            .map{ $0.initialImage }
//            .bind(to: computerImage.rx.image)
//            .disposed(by: disposeBag)
//
//        viewModel
//            .computerSRP
//            .map{ $0.labelTitle }
//            .bind(to: computerChoiceLabel.rx.text)
//            .disposed(by: disposeBag)
        
//        viewModel.inputMySRPImage /// String
//            .map{UIImage(named: "\($0)")} /// UIImage
//            .bind(to: myImage.rx.image)
//            .disposed(by: disposeBag)
//
//        viewModel.inputMyChoiceLabel
//            .map{"✅\($0)✅"}
//            .bind(to: myChoiceLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.inputComputerSRPImage
//            .map{UIImage(named: "\($0)")}
//            .bind(to: computerImage.rx.image)
//            .disposed(by: disposeBag)
//
//        viewModel.inputComputerChoiceLabel
//            .map{"✅\($0)✅"}
//            .bind(to: computerChoiceLabel.rx.text)
//            .disposed(by: disposeBag)
        
        viewModel.inputMainLabel
            .bind(to: mainLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func srpButtonTapped(_ sender: UIButton) {
        let mySrp = SRP.initialize(sender.currentTitle ?? "")
        print(#fileID, #function, #line, "🫀\(mySrp)")
        viewModel.myChoice(mySrp)
        
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        /// 컴퓨터 가 가위바위보 선택
        // MARK: - ❗️❗️❗️문제 발생❗️❗️❗️
        /// ❗️❗️❗️셀렉 버튼을 눌르면 컴퓨터가 가위 바위 보 중에 랜덤으로 선택해야함❗️❗️❗️
        
//        print(#fileID, #function, #line, "🤖\(comSrp)")
        
         
        /// 컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 이겼는지/졌는지 판단/표시
        viewModel.calcaulateSrp()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        viewModel.allReset()
    }
    
}

