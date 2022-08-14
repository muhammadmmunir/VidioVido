//
//  LandscapeCell.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import UIKit

class LandscapeCell: SectionCell {
    static let reuseIdentifier = "LandscapeCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            self.collection.heightAnchor.constraint(equalToConstant: 150)
        ])
        self.collection.delegate = self
    }
}

extension LandscapeCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
}
