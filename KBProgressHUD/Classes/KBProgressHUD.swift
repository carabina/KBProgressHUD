//
//  KBProgressHUD.swift
//  KBProgressHUD
//
//  Created by Kamlesh Bokdia on 10/2/18.
//

import UIKit

public class KBProgressHUD: UIViewController {
    
    static let shared = KBProgressHUD()
    var isActive = false
    
    let activityView: UIView = {
        let activityView = UIView()
        activityView.backgroundColor = UIColor.white
        activityView.layer.cornerRadius = 10
        activityView.clipsToBounds = true
        activityView.layer.shadowColor = UIColor.lightGray.cgColor
        activityView.layer.shadowOffset = CGSize(width: 2, height: 2)
        activityView.layer.shadowRadius = 4
        activityView.layer.shadowOpacity = 1
        activityView.layer.masksToBounds = false
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.color = UIColor.gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        activityView.addSubview(activityIndicator)
        view.addSubview(activityView)
        
        setupConstraints()
        
        activityIndicator.startAnimating()
    }
    
    func setupConstraints() {
        let constraints = [
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: activityView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: activityView.centerYAnchor),
            activityView.widthAnchor.constraint(equalToConstant: 64),
            activityView.heightAnchor.constraint(equalToConstant: 64)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    static public func show() {
        KBProgressHUD.shared.activityIndicator.startAnimating()
        
        if KBProgressHUD.shared.isActive {
            return
        }
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.makeKeyAndVisible()
        
        KBProgressHUD.shared.modalPresentationStyle = .overCurrentContext
        window.rootViewController?.present(KBProgressHUD.shared, animated: false, completion: nil)
        
        KBProgressHUD.shared.isActive = true
    }
    
    static public func dismiss() {
        if !KBProgressHUD.shared.isActive {
            return
        }
        
        KBProgressHUD.shared.activityIndicator.stopAnimating()
        KBProgressHUD.shared.dismiss(animated: false, completion: nil)
        KBProgressHUD.shared.isActive = false
    }
    
}
