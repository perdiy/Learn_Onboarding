//
//  SwipeCell.swift
//  Learn
//
//  Created by Perdi Yansyah on 25/07/23.
//


import UIKit

class SwipeCell: UICollectionViewCell {
    
    // Mendefinisikan nilai konstanta reuseIdentifier untuk sel kustom ini.
    static let reuseIdentifier = "SwipeCell"
    
    // Deklarasi imageView untuk menampilkan gambar dari item swipe.
    // Deklarasi headlineLabel dan subheadlineLabel untuk menampilkan judul dan subjudul item swipe.
    // Deklarasi descriptionStackView untuk mengelola tata letak vertikal judul dan subjudul.
    let peopleImageView = UIImageView()
    let headlineLabel = UILabel()
    let subheadlineLabel = UILabel()
    let descriptionStackView = UIStackView()
    
    // Metode inisialisasi kelas, dipanggil saat sel kustom ini dibuat.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    // Metode inisialisasi kelas untuk pembuatan dari storyboard (IB).
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Metode untuk memperbarui konten dari sel kustom ini dengan informasi item swipe.
    func update(image: String, headline: String, subheadline: String) {
        peopleImageView.image = UIImage(named: image)
        headlineLabel.text = headline
        subheadlineLabel.text = subheadline
    }
    
    // Metode untuk mengatur tampilan dan tata letak dari sel kustom ini.
    func configure() {
        backgroundColor = .systemBackground
        
        // Konfigurasi imageView.
        peopleImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(peopleImageView)
        
        // Konfigurasi headlineLabel.
        headlineLabel.textAlignment = .left
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headlineLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        headlineLabel.textColor = .label
        headlineLabel.numberOfLines = 0
        
        
        // Konfigurasi subheadlineLabel.
        subheadlineLabel.textAlignment = .left
        subheadlineLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subheadlineLabel.textColor = .secondaryLabel
        subheadlineLabel.numberOfLines = 0
        
        // Menambahkan headlineLabel dan subheadlineLabel ke dalam descriptionStackView.
        descriptionStackView.addArrangedSubview(headlineLabel)
        descriptionStackView.addArrangedSubview(subheadlineLabel)
        
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 10
        descriptionStackView.alignment = .leading
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(descriptionStackView)
        
        // Konfigurasi tata letak menggunakan Auto Layout.
        NSLayoutConstraint.activate([
            peopleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            peopleImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            peopleImageView.widthAnchor.constraint(equalToConstant: 450),
            peopleImageView.heightAnchor.constraint(equalToConstant: 450),
            
            descriptionStackView.topAnchor.constraint(equalTo: peopleImageView.bottomAnchor, constant: 90),
            descriptionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
}
