//
//  SettingsViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import SafariServices
import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sections = [SettingsSection]()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return tableView
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [
            SettingsSection(
                title: "Preferences",
                options: [
                    SettingsOption(title: "Save Videos", handler: { })
                ]
            ),
        SettingsSection(
            title: "Information",
            options:
                    [SettingsOption(title: "Terms of Service", handler: { [weak self] in
                        DispatchQueue.main.async {
                            guard let url = URL(string: "https://www.tiktok.com/legal/terms-of-usa") else {
                                return
                            }
                            let vc = SFSafariViewController(url: url)
                            self?.present(vc, animated: true)
                        }
                    }),
                     SettingsOption(title: "Privacy Policy", handler: { [weak self] in
                         DispatchQueue.main.async {
                             guard let url = URL(string: "https://www.tiktok.com/legal/terms-of-policy") else {
                                 return
                             }
                             let vc = SFSafariViewController(url: url)
                             self?.present(vc, animated: true)
                         }
                     })
                ]
            )
        ]

        view.backgroundColor = .systemBackground
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createFooter()
    }

    //MARK: - Setups

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func createFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 100))
        let button = UIButton(frame: CGRect(x: (view.width-200)/2, y: 25, width: 200, height: 50))
        button.setTitle("Sing Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTapSingOut), for: .touchUpInside)
        footer.addSubview(button)
        tableView.tableFooterView = footer
    }

    ///Выход из ака
    @objc func didTapSingOut() {
        let actionSheet = UIAlertController(title: "Sing Out",
                                            message: "Would you like to sing out?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Sing Out", style: .destructive, handler: { [weak self ] _ in
            DispatchQueue.main.async {
                AuthManager.shared.singOut { success in
                    if success {
                        UserDefaults.standard.setValue(nil, forKey: "username")
                        UserDefaults.standard.setValue(nil, forKey: "profile_picture_url")
                        let vc = SingInViewController()
                        let navVC = UINavigationController(rootViewController: vc)
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true)
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.tabBarController?.selectedIndex = 0
                    } else {
                        //failed
                        let alert = UIAlertController(title: "Woops",
                                                      message: "Something went wrong when signing out. Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }))
        present(actionSheet, animated: true)
    }

    //MARK: - TableView

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)   -> Int {
        sections[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]

        if model.title == "Save Videos" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(with: SwitchCellViewModel(title: model.title, isOn: UserDefaults.standard.bool(forKey: "save_video")))
            return cell
        }

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = model.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}

//MARK: - SwitchTableViewCellDelegate
extension SettingsViewController: SwitchTableViewCellDelegate {
    func switchTableViewCell(_ cell: SwitchTableViewCell, didUpdateSwitchTO isOn: Bool) {
        HapticsManager.shared.vibrateForSelection()
        UserDefaults.standard.set(isOn, forKey: "save_video")
    }
}
