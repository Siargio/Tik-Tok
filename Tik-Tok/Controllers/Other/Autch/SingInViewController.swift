//
//  SingInViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import SafariServices
import UIKit

class SingInViewController: UIViewController {

    //MARK: - Properties

    public var completion: (() -> Void)?

    //MARK: - UIElements

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "logo")
        return imageView
    }()

    private let emailField = AuthField.init(type: .email)

    private let passwordField = AuthField.init(type: .password)

    private let singInButton = AuthButton(type: .singIng, title: nil)
    private let forgotPassword = AuthButton(type: .plain, title: "Forgot Password")
    private let singUpButton = AuthButton(type: .plain, title: "New User? Create Account")

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Sing In"
        setupHierarchy()
        configureField()
        configureButtons()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 100
        logoImageView.frame = CGRect(x: (view.width - imageSize)/2, y: view.safeAreaInsets.top + 15, width: imageSize, height: imageSize)

        emailField.frame = CGRect(x: 20, y: logoImageView.bottom + 30, width: view.width - 40, height: 55)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 15, width: view.width - 40, height: 55)

        singInButton.frame = CGRect(x: 20, y: passwordField.bottom + 20, width: view.width - 40, height: 55)
        forgotPassword.frame = CGRect(x: 20, y: singInButton.bottom + 40, width: view.width - 40, height: 55)
        singUpButton.frame = CGRect(x: 20, y: forgotPassword.bottom + 20, width: view.width - 40, height: 55)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
    }

    //MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(singInButton)
        view.addSubview(singUpButton)
        view.addSubview(forgotPassword)
    }

    private func configureField() {
        emailField.delegate = self
        passwordField.delegate = self

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        toolBar.sizeToFit()
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
    }

    private func configureButtons() {
        singInButton.addTarget(self, action: #selector(didTapSingIn), for: .touchUpInside)
        singUpButton.addTarget(self, action: #selector(didTapSingUp), for: .touchUpInside)
        forgotPassword.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }

    //Actions

    @objc func didTapKeyboardDone() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }

    @objc func didTapSingIn() {
        didTapKeyboardDone()

        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
        password.count >= 6 else {

            let alert = UIAlertController(title: "Woops", message: "Please enter a valid mail and password to sing in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }

        AuthManager.shared.singIn(with: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.dismiss(animated: true)
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(
                        title: "Sign in Failed",
                        message: "Please check your email and password to try again.",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self?.present(alert, animated: true)
                    self?.passwordField.text = nil
                }
            }
        }
    }

    @objc func didTapSingUp() {
        didTapKeyboardDone()
        let vc = SingUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func didTapForgotPassword() {
        didTapKeyboardDone()
        guard let url = URL(string: "https://www.tiktok.com/forgot-password") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension SingInViewController: UITextFieldDelegate {
    
}
