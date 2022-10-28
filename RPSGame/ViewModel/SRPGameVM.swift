import UIKit
import RxSwift
import RxCocoa
import RxRelay



class SRPGameVM {
    
    // 컴퓨터 가위 바위 보 상태
    var computerSRP: BehaviorRelay<SRP> = BehaviorRelay<SRP>(value: .ready)
    
    // 유저 가위 바위 보 상태
    var userSRP: BehaviorRelay<SRP> = BehaviorRelay<SRP>(value: .ready)
    
    /// 메인라벨 상태
    var inputMainLabel: BehaviorRelay<String> = BehaviorRelay<String>(value: "선택하세요")
    
    /// "가위" "바위" "보" Button Tapped시 이미지 상태
    func myChoice(_ mySrp: SRP) {
        self.userSRP.accept(mySrp)
    }
    
    /// 컴퓨터가 가위 바위 보 선택
    func comChoice(_ comSrpp: SRP) {
        self.computerSRP.accept(comSrpp)
    }
    
    ///  컴퓨터와 내가 가위바위보한 정보 결과를 처리
    func calcaulateSrp() {
        let sss = ["가위","바위","보"]
        let comSrp = sss.randomElement() ?? ""
        let comSrpp: SRP = SRP.initialize(comSrp)
        self.comChoice(comSrpp)
        
        /// 가위 바위 보 계산
        let myChoice = self.userSRP.value
        let comChoice = self.computerSRP.value
        
        // 3. 컴퓨터와 내가 낸 가위바위보 정보 비교하기
        switch myChoice {
        case .scissors:
            if comChoice == .paper {
                return self.inputMainLabel.accept("이겼습니다")
            } else if comChoice == .rock {
                return self.inputMainLabel.accept("젔습니다")
            } else {
                return self.inputMainLabel.accept("비겼습니다")
            }
        case .rock:
            if comChoice == .paper {
                return self.inputMainLabel.accept("젔습니다")
            } else if comChoice == .rock {
                return self.inputMainLabel.accept("비겼습니다")
            } else {
                return self.inputMainLabel.accept("이겼습니다")
            }
        case .paper:
            if comChoice == .paper {
                return self.inputMainLabel.accept("비겼습니다")
            } else if comChoice == .rock {
                return self.inputMainLabel.accept("이겼습니다")
            } else {
                return self.inputMainLabel.accept("졌습니다")
            }
        case .ready:
            return  self.inputMainLabel.accept("이김")
        }
    }
    
    /// 리셋 버튼 탭시 정보 처리
    func allReset() {
        /// 모든 정보 초기화
        self.userSRP.accept(.ready)
        self.computerSRP.accept(.ready)
        self.inputMainLabel.accept("선택하세요")
        
    }
}
