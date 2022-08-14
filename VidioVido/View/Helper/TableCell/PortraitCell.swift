//
//  PortraitCell.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import UIKit

class PortraitCell: SectionCell {
    static let reuseIdentifier = "PortraitCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            self.collection.heightAnchor.constraint(equalToConstant: 200)
        ])
        self.collection.delegate = self
    }
}

extension PortraitCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
