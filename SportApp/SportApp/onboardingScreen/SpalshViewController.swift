//
//  SpalshViewController.swift
//  SportApp
//
//  Created by Ayatullah Salah on 11/05/2025.
//
import UIKit
import Lottie

class SplashViewController: UIViewController {

    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        animationView = LottieAnimationView(name: "splash")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.play()

        if let animationView = animationView {
            view.addSubview(animationView)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigateToPageViewController()

        }
    }
    private func navigateToPageViewController() {
        if let pageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageVC") as? UIPageViViewController {
            pageVC.modalTransitionStyle = .crossDissolve
            pageVC.modalPresentationStyle = .fullScreen
            self.present(pageVC, animated: true, completion: nil)
        } else {
            print("Failed to instantiate PageVC")
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationView?.frame = view.bounds
    }
}


//    private func navigateToMainScreen() {
//        let mainVC = MainViewController() // Replace with your main VC
//        mainVC.modalTransitionStyle = .crossDissolve
//        mainVC.modalPresentationStyle = .fullScreen
//        self.present(mainVC, animated: true, completion: nil)
//    }

