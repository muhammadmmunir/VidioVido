//
//  SectionCell.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import UIKit

class SectionCell: UITableViewCell {
    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.showsHorizontalScrollIndicator = false
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.dataSource = self
        coll.register(
            PosterCell.self,
            forCellWithReuseIdentifier: PosterCell.reuseIdentifier)
        coll.isPagingEnabled = true
        coll.backgroundColor = .white
        return coll
    }()
    
    typealias SectionItem = (imageUrl: String, title: String)
    var items: [SectionItem]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.collection)
        NSLayoutConstraint.activate([
            self.collection.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor),
            self.collection.topAnchor.constraint(
                equalTo: self.contentView.topAnchor, constant: 16),
            self.collection.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor),
            self.collection.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setup(items: [SectionItem]) {
        self.items = items
    }
}

extension SectionCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        self.items?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PosterCell.reuseIdentifier,
            for: indexPath) as! PosterCell
        if let items = self.items {
            cell.setup(
                imageUrl: items[indexPath.row].imageUrl,
                title: items[indexPath.row].title)
        }
        return cell
    }
}
