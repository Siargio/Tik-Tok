//
//  CommentsViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 16.05.23.
//

import UIKit
protocol CommentsViewControllerDelegate: AnyObject {
    func didTapCloseForComments(with viewController: CommentsViewController)
}

class CommentsViewController: UIViewController {

    //MARK: - Properties

    weak var delegate: CommentsViewControllerDelegate?
    private let post : PostModel

    private var comments = [PostComment]()
    
    //MARK: - UIElements

    private let tableView: UITableView = {
        let tableView = UITableView()
        //tableView.backgroundColor = .b
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        return tableView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()

    //MARK: - Init

    init(post: PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(closeButton)
        view.addSubview(tableView)
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        view.backgroundColor = .white
        fetchPostComments()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.width - 45, y: 10, width: 35, height: 35)
        tableView.frame = CGRect(
            x: 0,
            y: closeButton.bottom,
            width: view.width,
            height: view.width - closeButton.bottom)
    }

    //MARK: - Setups

    @objc private func didTapClose() {
        delegate?.didTapCloseForComments(with: self)
    }

    func fetchPostComments() {
        self.comments = PostComment.mockComments()
    }

}

//MARK: - UITableViewDelegate

extension CommentsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentTableViewCell.identifier,
            for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: comment)
        cell.backgroundColor = .gray
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
