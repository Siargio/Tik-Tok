//
//  SingUpViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import SafariServices
import UIKit

class SingUpViewController: UIViewController {

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

    private let usernameField = AuthField.init(type: .username)
    private let emailField = AuthField.init(type: .email)
    private let passwordField = AuthField.init(type: .password)

    private let singUpButton = AuthButton(type: .singIng, title: nil)
    private let termsButton = AuthButton(type: .plain, title: "Terms of Service")

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Create account"
        setupHierarchy()
        configureField()
        configureButtons()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 100
        logoImageView.frame = CGRect(x: (view.width - imageSize)/2, y: view.safeAreaInsets.top + 15, width: imageSize, height: imageSize)

        usernameField.frame = CGRect(x: 20, y: logoImageView.bottom + 30, width: view.width - 40, height: 55)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 15, width: view.width - 40, height: 55)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 15, width: view.width - 40, height: 55)

        singUpButton.frame = CGRect(x: 20, y: passwordField.bottom + 20, width: view.width - 40, height: 55)
        termsButton.frame = CGRect(x: 20, y: singUpButton.bottom + 40, width: view.width - 40, height: 55)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameField.becomeFirstResponder()
    }

    //MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(logoImageView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(singUpButton)
        view.addSubview(termsButton)
    }

    private func configureField() {
        emailField.delegate = self
        passwordField.delegate = self
        usernameField.delegate = self

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDone))
        ]
        toolBar.sizeToFit()
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
        usernameField.inputAccessoryView = toolBar
    }

    private func configureButtons() {
        singUpButton.addTarget(self, action: #selector(didTapSingUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
    }

    //Actions

    @objc func didTapKeyboardDone() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }

    @objc func didTapSingUp() {
        didTapKeyboardDone()

        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
              !username.contains(" "),
              !username.contains(".") else {

            let alert = UIAlertController(
                title: "Woops",
                message: "Please make sure to enter a valid username, email and password. Your password must be at least 6 characters long.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }

        AuthManager.shared.singUp(with: username, email: email, password: password) { [weak self] success  in
            DispatchQueue.main.async {
                if success {
                    self?.dismiss(animated: true)
                } else {
                    let alert = UIAlertController(
                        title: "Sign Up Failed",
                        message: "Something went wrong when trying to register. Pleas try again.",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self?.present(alert, animated: true)
                }
            }
        }
    }

    @objc func didTapTerms() {
        didTapKeyboardDone()
        guard let url = URL(string: "https://www.tiktok.com/terms") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension SingUpViewController: UITextFieldDelegate {

}
