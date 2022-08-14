//
//  PosterCell.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import UIKit

class PosterCell: UICollectionViewCell {
    static let reuseIdentifier = "PosterCell"
    
    lazy var poster: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 16)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.poster)
        self.poster.addSubview(self.title)
        NSLayoutConstraint.activate([
            self.poster.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            self.poster.topAnchor.constraint(
                equalTo: self.topAnchor),
            self.poster.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            self.poster.bottomAnchor.constraint(
                equalTo: self.bottomAnchor),
            
            self.title.bottomAnchor.constraint(
                equalTo: self.poster.bottomAnchor, constant: -16),
            self.title.centerXAnchor.constraint(
                equalTo: self.poster.centerXAnchor)
        ])
    }
    
    func setup(imageUrl: String, title: String) {
        self.poster.load(from: imageUrl, contentMode: .scaleAspectFill)
        self.title.text = title
    }
}
