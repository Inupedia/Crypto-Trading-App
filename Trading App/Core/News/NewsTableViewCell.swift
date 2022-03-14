//
//  NewsTableViewCell.swift
//  Trading App
//
//  Created by Pengju Zhang on 3/13/22.
//

import UIKit
import SwiftUI

class NewsTableViewCellModel {
    let title: String
    init(title: String) {
        self.title = title
        // print(self.title)
    }
}

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 3
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitle)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTitle.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 120, height: contentView.frame.size.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewsTableViewCellModel) {
        newsTitle.text = viewModel.title
    }
}
