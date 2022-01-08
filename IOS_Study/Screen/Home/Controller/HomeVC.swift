//
//  HomeVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/18.
//

import UIKit
import FSCalendar
import SideMenu

class HomeVC: UIViewController {
    // 임시 Subject 데이터
    let subjects = [
        Subjects("수학", "윤경T", ["쎈 수학 p110~120", "곱셈공식 암기"]),
        Subjects("영어", "호준T", ["단어 Day 7 암기", "영어 문법(초록책) p20~24", "수능특강 p11~14"]),
        Subjects("과학", "은희T", ["p51~60", "주기율표 암기"])
    ]
    // 임시 숙제 있는 날 데이터
    let homeworkDay = ["20220101","20220112","20220121","20220125"]
    let homeworkDay_Done = ["20220112","20220124","20220117","20220127"]
    
    @IBOutlet weak var customNaviBar: CustomNB!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var weekMonthChangeBtn: UIButton!
    @IBOutlet weak var subjectCV: UICollectionView!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    
    var currentPage: Date?
    private lazy var today: Date = { return Date() }()
    private lazy var monthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM, yyyy"
        return df
    }()
    private lazy var dayDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        setUpHomeViewGesture()
        setUpCalendarBackground()
        setUpCalendar()
        setUpSubjectCV()
        setUpNotification()
    }
    
    //MARK: IBAction
    // 월-주 Change Btn
    @IBAction func changeWeekMonth(_ sender: Any) {
        if calendarView.scope == .week {
            setCalendarToMonth()
        } else {
            setCalendarToWeek()
        }
    }
    // 다음주, 다음달 Btn
    @IBAction func goNextMonthWeek(_ sender: Any) {
        if calendarView.scope == .week {
            scrollWeekPage(isPrev: false)
        } else {
            scrollCurrentPage(isPrev: false)
        }
    }
    // 이전주, 이전달 Btn
    @IBAction func goPrevMonthWeek(_ sender: Any) {
        if calendarView.scope == .week {
            scrollWeekPage(isPrev: true)
        } else {
            scrollCurrentPage(isPrev: true)
        }
    }
    
    // 키보드 나올때
    @objc func KeyBoardwillShow(_ notificatoin : Notification ){
        let keyboardSize = (notificatoin.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardSize.height - view.safeAreaInsets.bottom
        
        var contentInset = subjectCV.contentInset
        contentInset.bottom = height + 14
        subjectCV.contentInset = contentInset
    }
    
    // 키보드 사라질 때
    @objc func KeyBoardwillHide(_ notificatoin : Notification ){
        let contentInset = UIEdgeInsets.zero
        subjectCV.contentInset = contentInset
    }
    
    // 키보드 hide
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
            for textView in self.view.subviews where textView is UITextView {
                textView.resignFirstResponder()
            }
        }
        sender.cancelsTouchesInView = false
    }
    
    @objc func calendarViewVerticalScroll(sender: UIPanGestureRecognizer) {
        let dragPosition = sender.translation(in: self.view)
        
        //week
        if dragPosition.y < 0 {
            setCalendarToWeek()
        } else {
            setCalendarToMonth()
        }
    }
    
    // menu Btn
    @objc func openSideMenu(_ sender: Any) {
        guard let sideMenuVC = UIStoryboard(name: Identifiers.sideMenuSB, bundle: nil).instantiateViewController(withIdentifier: Identifiers.sideMenuNC) as? SideMenuNavigationController else {return}
        sideMenuVC.presentationStyle.onTopShadowColor = .black
        sideMenuVC.presentationStyle.onTopShadowOpacity = 0.5
        sideMenuVC.presentationStyle.onTopShadowOffset = CGSize(width: 0, height: 0)
        sideMenuVC.presentationStyle.onTopShadowRadius = 10
        
        present(sideMenuVC, animated: true, completion: nil)
    }
    
}

//MARK: Custom Function
extension HomeVC {
    // NavigationBar Setting
    func setUpNaviBar() {
//        customNaviBar.
        customNaviBar.title = "TODAY'S HOMEWORK"
        
        customNaviBar.firstBtn.setImage(UIImage(named: "Alarm"), for: .normal)
        customNaviBar.secondBtn.setImage(UIImage(named: "ETC"), for: .normal)
        customNaviBar.secondBtn.addTarget(self, action: #selector(openSideMenu(_:)), for: .touchUpInside)
    }

    // View Gesture Setting
    func setUpHomeViewGesture() {
        // panGesture - 캘린더 상하 스크롤
        let calendarVerticalScrollGesture = UIPanGestureRecognizer(target: self, action: #selector(calendarViewVerticalScroll))
        calendarView.addGestureRecognizer(calendarVerticalScrollGesture)
        
        // tabGesture - 화면 탭하면 키보드 dismiss
        let dismissKeyboardTabGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(dismissKeyboardTabGesture)
    }
    
    // 캘린더 기본 Setting
    func setUpCalendar() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.layer.cornerRadius = 40
        calendarView.backgroundColor = .clear
        calendarView.headerHeight = 0
        currentDate.text = self.monthDateFormatter.string(from: calendarView.currentPage)
        
        // S M T W T F S Setting
        calendarView.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        calendarView.appearance.weekdayTextColor = .label
        calendarView.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        
        calendarView.appearance.titleFont = UIFont.systemFont(ofSize: 16)
        
        // 선택된 날 appearance
        calendarView.appearance.selectionColor = #colorLiteral(red: 0.4664905667, green: 0.5537653565, blue: 0.8611391187, alpha: 1)
        calendarView.appearance.titleDefaultColor = .label
        
        // 이번달 아닌 날
        calendarView.appearance.titlePlaceholderColor = .lightGray
        
        // today appearance
        calendarView.appearance.todayColor = .systemGray3
    }
    
    // upside ScrollView_ bottom sheet같은(?)
    func setUpCalendarBackground() {
        backgroundView.backgroundColor = .systemGray6
        backgroundView.layer.cornerRadius = 40
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    // subjectCV Setting
    func setUpSubjectCV() {
        subjectCV.dataSource = self
        subjectCV.delegate = self
        
        subjectCV.alwaysBounceVertical = true
        subjectCV.allowsSelection = false
        subjectCV.showsVerticalScrollIndicator = false
    }
    
    // keyboard Notification Setting
    func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyBoardwillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyBoardwillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // calendar가 month일 때 Next, Prev Month 이동
    func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        currentPage = cal.date(byAdding: dateComponents, to: currentPage ?? today)
        calendarView.select(currentPage)
        calendarView.setCurrentPage(currentPage!, animated: true)
    }

    // calendar가 week일 때 Next, Prev Week 이동
    func scrollWeekPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.weekOfMonth = isPrev ? -1 : 1
        currentPage = cal.date(byAdding: dateComponents, to: currentPage ?? today)
        calendarView.select(currentPage)
        calendarView.setCurrentPage(currentPage!, animated: true)
    }
    
    // calendar을 week로 바꾸는 함수
    func setCalendarToWeek() {
        calendarView.setScope(.week, animated: true)
        weekMonthChangeBtn.setTitle("월", for: .normal)
        self.view.endEditing(true)
    }
    
    // calendar을 month로 바꾸는 함수
    func setCalendarToMonth() {
        calendarView.setScope(.month, animated: true)
        weekMonthChangeBtn.setTitle("주", for: .normal)
        self.view.endEditing(true)
    }
}

//MARK: FSCalendarDataSource
extension HomeVC: FSCalendarDataSource {
    // 이벤트 밑에 Dot 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.homeworkDay.contains(dayDateFormatter.string(from: date)){
            return 1
        }
        if self.homeworkDay_Done.contains(dayDateFormatter.string(from: date)){
            return 1
        }
        return 0
    }
}
//MARK: FSCalendarDelegate
extension HomeVC: FSCalendarDelegate {
    // Title Month-Year Setting
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currentDate.text = self.monthDateFormatter.string(from: calendar.currentPage)
    }
    // Week-Month Calendar Height Setting
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    // 선택된 날에 맞춰 숙제 목록 & 메모 Setting
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}
//MARK: FSCalendarDelegateAppearance
extension HomeVC: FSCalendarDelegateAppearance {
    // Default Event Dot 색상 분기처리
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]?{
        if homeworkDay.contains(dayDateFormatter.string(from: date)){
            return [UIColor.red]
        }
        if homeworkDay_Done.contains(dayDateFormatter.string(from: date)){
            return [UIColor.systemGray2]
        }
        return nil
    }
    // Selected Event Dot 색상 분기처리
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        if homeworkDay.contains(dayDateFormatter.string(from: date)){
            return [UIColor.red]
        }
        if homeworkDay_Done.contains(dayDateFormatter.string(from: date)){
            return [UIColor.systemGray2]
        }
        return nil
    }
}

//MARK: UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 과목 + memo
        return subjects.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == subjects.count {
            let cell = subjectCV.dequeueReusableCell(withReuseIdentifier: Identifiers.memoCVC, for: indexPath) as! MemoCVC
            
            // 메모 textView Size
            cell.widthAnchor.constraint(equalToConstant: subjectCV.frame.width).isActive = true
            return cell
        } else {
            let cell = subjectCV.dequeueReusableCell(withReuseIdentifier: Identifiers.subjectListCVC, for: indexPath) as! SubjectListCVC
            
            cell.subjectName.text = subjects[indexPath.row].subjectName
            cell.teacher.text = subjects[indexPath.row].teacher
            cell.homeworkContents = subjects[indexPath.row].homework
            
            // 숙제 목록 tableView Size
            cell.homeworkListHeight.constant = CGFloat(cell.homeworkContents.count * 45)
            cell.widthAnchor.constraint(equalToConstant: subjectCV.frame.width).isActive = true
            
            return cell
        }
    }
}

//MARK: UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        // 맨위에서 스크롤하거나 세게 스크롤하면 월로 바뀜
        // 그냥 아래로 스크롤하면 주로 바뀜
        // 주인 상태에서 스크롤 가능
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            setCalendarToWeek()
        } else if scrollView.contentOffset.y < 0 || scrollView.panGestureRecognizer.translation(in: scrollView).y > 200 {
            setCalendarToMonth()
        }
    }
}
