//
//  AppController.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/03.
//

import Foundation
import UIKit

// MARK: 로그인 관리를 위한 AppController
class AppController {
    // sigleton pattern
    static let shared = AppController()
    private init() {
            registerAuthStateDidChangeEvent()
        }
    
    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController
        }
    }
    
    private func setHome() {
        let vc = ViewControllerFactory.viewController(for: .tabBar)
        rootViewController = vc
    }

    private func routeToLogin() {
        let vc = ViewControllerFactory.viewController(for: .login)
        rootViewController = vc
    }
    
    func show(in window: UIWindow) {
            self.window = window
            window.backgroundColor = .systemBackground
            window.makeKeyAndVisible()
            checkLoginIn()
        }
    
    private func registerAuthStateDidChangeEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkLoginIn), name: .authStateDidChange, object: nil)
    }
    
    @objc private func checkLoginIn() {
            let isSignIn = UserDefaults.standard.bool(forKey: "isSignIn") == true
            if isSignIn {
                setHome()
            } else {
                routeToLogin()
            }
        }
}
