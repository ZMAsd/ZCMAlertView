//
//  ZMMessageAlertView.swift
//  ZCMAlertView
//
//  Created by admin on 2021/5/31.
//

import UIKit

class ZMMessageAlertView: ZMBaseAlertView {
    
    /// 标题
    private var titleLabel: UILabel?
    /// 消息
    private var messageLabel: UILabel?
    /// 确认
    private var comfirmButton: UIButton?
    /// 取消
    private var cancelButton: UIButton?
    // 事件处理类型
    typealias actionHandelBlock = (()->Void)
    // 确认事件
    private var comfirmBlock: actionHandelBlock?
    // 取消事件
    private var cancelBlock: actionHandelBlock?
    
    init(title: String?, message: String?, comfirmBlock: actionHandelBlock?, cancelBlock: actionHandelBlock?, parentView: UIView) {
        super.init(parentView: parentView, containerHeight: 300)
        // 标题
        if let showTitle = title {
            titleLabel = UILabel()
            titleLabel!.font = .boldSystemFont(ofSize: 18)
            titleLabel!.textColor = .black
            titleLabel!.text = showTitle
            addSubview(titleLabel!)
        }
        // 消息
        if let showMessage = message {
            messageLabel = UILabel()
            messageLabel!.font = .systemFont(ofSize: 16)
            messageLabel!.textColor = .black
            messageLabel!.text = showMessage
            addSubview(messageLabel!)
        }
        // 确认事件
        if let okBlock = comfirmBlock {
            self.comfirmBlock = okBlock
            comfirmButton = UIButton(type: .custom)
            comfirmButton!.setTitleColor(.white, for: .normal)
            comfirmButton!.titleLabel?.font = .systemFont(ofSize: 16)
            comfirmButton!.backgroundColor = .blue
            comfirmButton!.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
            addSubview(comfirmButton!)
        }
        // 取消事件
        if let cancelBlock = cancelBlock {
            self.cancelBlock = cancelBlock
            cancelButton = UIButton(type: .custom)
            cancelButton!.setTitleColor(.white, for: .normal)
            cancelButton!.titleLabel?.font = .systemFont(ofSize: 16)
            cancelButton!.backgroundColor = .red
            cancelButton!.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
            addSubview(cancelButton!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Action
    @objc func buttonClicked(sender: UIButton) {
        
    }
}
