import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - 登录相关控件
    private var txtUser: UITextField!
    private var txtPwd: UITextField!
    
    private var imgLeftHand: UIImageView!
    private var imgRightHand: UIImageView!
    
    private var imgLeftHandGone: UIImageView!
    private var imgRightHandGone: UIImageView!
    
    private var showType: LoginShowType = .none
    private let offsetLeftHand: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        addTapToDismissKeyboard()
    }
    
    private func setupUI() {
        let mainSize = UIScreen.main.bounds.size
        
        // 猫头鹰头部
        let imgLogin = UIImageView(frame: CGRect(x: mainSize.width / 2 - 211 / 2, y: 100, width: 211, height: 109))
        imgLogin.image = UIImage(named: "owl-login")
        view.addSubview(imgLogin)
        
        // 遮眼左手
        imgLeftHand = UIImageView(frame: CGRect(x: 61 - offsetLeftHand, y: 90, width: 40, height: 65))
        imgLeftHand.image = UIImage(named: "owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        // 遮眼右手
        imgRightHand = UIImageView(frame: CGRect(x: imgLogin.frame.size.width / 2 + 60, y: 90, width: 40, height: 65))
        imgRightHand.image = UIImage(named: "owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        // 登录框背景
        let vLogin = UIView(frame: CGRect(x: 15, y: 200, width: mainSize.width - 30, height: 160))
        vLogin.backgroundColor = .white
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(vLogin)
        
        // 左手圆形
        imgLeftHandGone = UIImageView(frame: CGRect(x: mainSize.width / 2 - 100, y: vLogin.frame.origin.y - 22, width: 40, height: 40))
        imgLeftHandGone.image = UIImage(named: "icon_hand")
        view.addSubview(imgLeftHandGone)
        
        // 右手圆形
        imgRightHandGone = UIImageView(frame: CGRect(x: mainSize.width / 2 + 62, y: vLogin.frame.origin.y - 22, width: 40, height: 40))
        imgRightHandGone.image = UIImage(named: "icon_hand")
        view.addSubview(imgRightHandGone)
        
        // 用户名输入框
        txtUser = UITextField(frame: CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        txtUser.delegate = self
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtUser.leftViewMode = .always
        
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named: "iconfont-user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        // 密码输入框
        txtPwd = UITextField(frame: CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        txtPwd.delegate = self
        txtPwd.isSecureTextEntry = true
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = .always
        
        let imgPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named: "iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
    }
    
    // MARK: - 输入响应
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = .done
        
        if textField == txtUser {
            if showType != .user {
                showType = .user
                animateToShowUsername()
            }
        } else if textField == txtPwd {
            if showType != .pass {
                showType = .pass
                animateToShowPassword()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txtPwd {
            print("密码: \(txtPwd.text ?? "")")
            print("用户名: \(txtUser.text ?? "")")
        } else {
            print("用户名: \(txtUser.text ?? "")")
            print("密码: \(txtPwd.text ?? "")")
        }
        return true
    }

    // MARK: - 动画逻辑（保持原汁原味）
    private func animateToShowUsername() {
        UIView.animate(withDuration: 0.5) {
            self.imgLeftHand.frame.origin.x -= self.offsetLeftHand
            self.imgLeftHand.frame.origin.y += 30
            self.imgRightHand.frame.origin.x += 48
            self.imgRightHand.frame.origin.y += 30
            self.imgLeftHandGone.frame = CGRect(x: self.imgLeftHandGone.frame.origin.x - 70, y: self.imgLeftHandGone.frame.origin.y, width: 40, height: 40)
            self.imgRightHandGone.frame = CGRect(x: self.imgRightHandGone.frame.origin.x + 30, y: self.imgRightHandGone.frame.origin.y, width: 40, height: 40)
        }
    }
    
    private func animateToShowPassword() {
        UIView.animate(withDuration: 0.5) {
            self.imgLeftHand.frame.origin.x += self.offsetLeftHand
            self.imgLeftHand.frame.origin.y -= 30
            self.imgRightHand.frame.origin.x -= 48
            self.imgRightHand.frame.origin.y -= 30
            self.imgLeftHandGone.frame = CGRect(x: self.imgLeftHandGone.frame.origin.x + 70, y: self.imgLeftHandGone.frame.origin.y, width: 0, height: 0)
            self.imgRightHandGone.frame = CGRect(x: self.imgRightHandGone.frame.origin.x - 30, y: self.imgRightHandGone.frame.origin.y, width: 0, height: 0)
        }
    }
    
    // MARK: - 键盘关闭
    private func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - 登录框状态
private enum LoginShowType {
    case none, user, pass
}

