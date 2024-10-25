// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

class BlurEffectView: UIVisualEffectView {
    
    private var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    private var intensity: CGFloat
    
    init(intensity: CGFloat = 0.25) {
        self.intensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Task { [weak self] in
            await self?.animator.stopAnimation(true)
        }
    }

    override func didMoveToSuperview() {
        guard let superview = superview else { return }

        backgroundColor = .clear
        frame = superview.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        clipsToBounds = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterFG(_:)),
            name:UIApplication.willEnterForegroundNotification,
            object: nil
        )

        setUpAnimation()
    }
    
    private func setUpAnimation() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .light)
        }
        animator.fractionComplete = intensity
    }
    
    @objc func appWillEnterFG(_ note: Notification) {
        setUpAnimation()
    }
}

extension UIView {
    public func reversedBlur(parentFrame: CGRect, leftPadding: CGFloat = 0, topPadding: CGFloat = 0, rightPadding: CGFloat = 0, bottomPadding: CGFloat = 0, cornerRadius: CGFloat = 0) {
        subviews.filter { $0 is BlurEffectView }.forEach { $0.removeFromSuperview() }
        let blurView = BlurEffectView(intensity: 0.15)
        blurView.frame = parentFrame
        
        addSubview(blurView)
        
        let width = bounds.width - (leftPadding + rightPadding)
        let height = bounds.height - (topPadding + bottomPadding)
        
        let rect = CGRect(x: leftPadding, y: topPadding, width: width, height: height)
        applyBlurExclusion(for: rect, cornerRadius: 20, blurView: blurView)
    }
    
    private func applyBlurExclusion(for rect: CGRect, cornerRadius: CGFloat, blurView: UIView) {
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: bounds)
        
        // 중앙 부분의 사각형 경로 생성 (코너 반경 포함)
        let clearPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).reversing()
        
        path.append(clearPath)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        
        blurView.layer.mask = maskLayer
    }
}
