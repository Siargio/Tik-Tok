//
//  CaptionViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 20.05.23.
//

import Appirater
import ProgressHUD
import UIKit

class CaptionViewController: UIViewController {

    let videoURL: URL

    //MARK: - UIElement

    private let captionTextView: UITextView = {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true
        return textView
    }()

    //MARK: - Init

    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Caption"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapPost))
        view.addSubview(captionTextView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        captionTextView.frame = CGRect(x: 5, y: view.safeAreaInsets.top + 5, width: view.width - 10, height: 150).integral
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captionTextView.becomeFirstResponder()
    }

    //MARK: - Setups

    @objc private func didTapPost() {
        captionTextView.resignFirstResponder()
        let caption = captionTextView.text ?? ""

        // генерация уникального названия видео на основе ид пользователя
        let newVideoName = StorageManager.shared.generateVideoName()

        ProgressHUD.show("Posting")

        // загрузка видео
        StorageManager.shared.uploadVideo(from: videoURL, fileName: newVideoName) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    // обновить базу данных
                    DatabaseManager.shared.insertPost(fileName: newVideoName, caption: caption) { datebaseUpdate in
                        if datebaseUpdate {
                            Appirater.tryToShowPrompt()
                            HapticsManager.shared.vibrate(for: .success)
                            ProgressHUD.dismiss()
                            // перезагрузка камеры и переключения на ленту новостей
                            self?.navigationController?.popToRootViewController(animated: true)
                            self?.tabBarController?.selectedIndex = 0
                            self?.tabBarController?.tabBar.isHidden = false
                        } else {
                            HapticsManager.shared.vibrate(for: .error)
                            ProgressHUD.dismiss()
                            let alert = UIAlertController(
                                title: "Woops",
                                message: "We were unable to upload your video. Please try again",
                                preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                            self?.present(alert, animated: true)
                        }
                    }
                } else {
                    HapticsManager.shared.vibrate(for: .error)
                    ProgressHUD.dismiss()
                    let alert = UIAlertController(
                        title: "Woops",
                        message: "We were unable to upload your video. Please try again",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
