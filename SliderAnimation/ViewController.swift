//
//  ViewController.swift
//  SliderAnimation
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
        setupPositions()
    }
    
    private func setupUI() {
        roundedView.backgroundColor = UIColor.systemBlue
        roundedView.layer.cornerRadius = 10
        
        animator.isUserInteractionEnabled = true
        animator.pausesOnCompletion = true
        
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDidEndDragging(_:)), for: .touchUpInside)
    }
    
    private func setupPositions() {
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
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

    @objc func sliderValueDidChange(_ slider: UISlider) {
        animator.pauseAnimation()
        animator.fractionComplete = CGFloat(slider.value)
    }

    @objc func sliderDidEndDragging(_ slider: UISlider) {
        animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        animateSlider()
    }
    
    private func animateSlider() {
        slider.setValue(1, animated: true)
    }

}
