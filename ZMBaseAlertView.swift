//
//  ZMBaseAlertView.swift
//  nalu
//
//  Created by admin on 2021/5/29.
//  Copyright © 2021 zm. All rights reserved.
//

import UIKit

class ZMBaseAlertView: UIView {
    
    /// 背景视图
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // 弹窗显示视图
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    /// 屏幕高度
    private let screen_height = UIScreen.main.bounds.height
    /// 父类视图
    private var parentView: UIView? = nil
    /// 显示的高度
    private var containerHeight: CGFloat = 0
    /// 动画时长
    private let animation_time: CGFloat = 0.3
    
    private var containerTopLayout: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 创建item
    /// - Parameters:
    ///   - parentView: 父类视图
    ///   - containerHeight: 内容高度
    init(parentView: UIView = UIApplication.shared.keyWindow!, containerHeight: CGFloat = 300) {
        self.init()
        self.parentView = parentView
        self.containerHeight = containerHeight
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化控制器
    private func setupSubViews() {
        self.addSubview(backgroundView)
        self.addSubview(containerView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerTopLayout = containerView.topAnchor.constraint(equalTo: topAnchor, constant: screen_height)
        containerTopLayout?.isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
    }
    
    /// 显示
    func show() {
        guard let topView = parentView else {
            return
        }
        for (_, obj) in topView.subviews.enumerated() {
            let className = String(describing: obj.self.classForCoder)
            if className == "ZMBaseAlertView" {
                return
            }
        }
        
        frame = topView.frame
        topView.addSubview(self)
        let toTopPadding: CGFloat = (screen_height - containerHeight) / 2.0
        layoutIfNeeded()
        UIView.animate(withDuration: TimeInterval(animation_time)) {[unowned self] in
            containerTopLayout?.constant = toTopPadding
            layoutIfNeeded()
        }
    }
    
    /// 隐藏
    @objc func hide() {
        layoutIfNeeded()
        UIView.animate(withDuration: TimeInterval(animation_time)) {[unowned self] in
            containerTopLayout?.constant = screen_height
            layoutIfNeeded()
        } completion: {[weak self] state in
            guard let weakSelf = self else {
                return
            }
            weakSelf.isHidden = true
            weakSelf.removeFromSuperview()
        }
    }
}
