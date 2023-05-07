//
//  ViewController.swift
//  SliderAnimation
//
//  Created by Svetlana Shardakova on 07.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let roundedView = UIView()
    let slider = UISlider()
    lazy var animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
        self.roundedView.transform = self.roundedView.transform.scaledBy(x: 1.5, y: 1.5).rotated(by: .pi/2)
        self.roundedView.frame.origin.x = self.view.frame.width - self.roundedView.frame.width - self.view.layoutMargins.right
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(slider)
        view.addSubview(roundedView)
        setupUI()
    }
    
    func setupUI() {
        roundedView.backgroundColor = UIColor.systemBlue
        roundedView.layer.cornerRadius = 10
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        animator.isUserInteractionEnabled = true
        animator.pausesOnCompletion = true

    
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            roundedView.widthAnchor.constraint(equalToConstant: 100),
            roundedView.heightAnchor.constraint(equalToConstant: 100),
            roundedView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            roundedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120)
        ])
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        animator.pauseAnimation()
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        animator.fractionComplete = CGFloat(sender.value)
//        animator.startAnimation(afterDelay: 0.5)
    }
}
