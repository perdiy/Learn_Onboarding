//
//  SwipeViewController.swift
//  Learn
//
//  Created by Perdi Yansyah on 25/07/23.
//

import UIKit

class SwipeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // Array swipeItems berisi data dari kelas SwipeItem, yang menyimpan informasi tentang setiap halaman swipe.
    let swipeItems = [
        // SwipeItem 1
        SwipeItem(image: "page1", headline: "Let's Get Started", subheadline: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        
        // SwipeItem 2
        SwipeItem(image: "page2", headline: "Your Onboarding Journey Begins!", subheadline: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        
        // SwipeItem 3
        SwipeItem(image: "page3", headline: "Your First Steps to Success", subheadline: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact.")
    ]
    
    // Deklarasi tombol "Skip", "Next", dan UIPageControl untuk navigasi dan indikator halaman.
    let previousButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let pageControl = UIPageControl()
    let bottomStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    // Mengembalikan jumlah item (halaman swipe) dalam koleksi.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swipeItems.count
    }
    
    // Mengonfigurasi sel (cell) untuk item tertentu dalam koleksi.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwipeCell.reuseIdentifier, for: indexPath) as! SwipeCell
        let swipeItem = swipeItems[indexPath.item]
        cell.update(image: swipeItem.image, headline: swipeItem.headline, subheadline: swipeItem.subheadline)
        return cell
    }
    
    // Mengembalikan ukuran sel (cell) untuk item tertentu dalam koleksi.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // Mengembalikan jarak minimum antara dua baris item dalam koleksi (jaraknya diatur ke 0).
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Metode ini dipanggil saat pengguna berhenti menggeser layar (scroll view).
    // Menghitung halaman saat ini berdasarkan offset dan memperbarui pageControl.
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    // Metode yang dipanggil saat tombol "Skip" ditekan.
    // Navigasi ke halaman sebelumnya dan memperbarui pageControl.
    @objc func previousButtonDidTap() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // Metode yang dipanggil saat tombol "Next" ditekan.
    // Navigasi ke halaman berikutnya dan memperbarui pageControl.
    @objc func nextButtonDidTap() {
        let nextIndex = min(pageControl.currentPage + 1, swipeItems.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // Mengatur tampilan bawah yang berisi tombol "Skip", UIPageControl, dan tombol "Next".
    func configureBottomStackView() {
        previousButton.setTitle("Skip", for: .normal)
        previousButton.setTitleColor(.systemGray, for: .normal)
        previousButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        previousButton.addTarget(self, action: #selector(previousButtonDidTap), for: .touchUpInside)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = swipeItems.count
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        
        if let arrowImage = UIImage(systemName: "arrow.right") {
            nextButton.setImage(arrowImage, for: .normal)
            nextButton.semanticContentAttribute = .forceRightToLeft
            nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
            nextButton.imageView?.contentMode = .scaleAspectFit
            nextButton.tintColor = .white
            nextButton.layer.cornerRadius = 15.0
        }
        
        bottomStackView.addArrangedSubview(previousButton)
        bottomStackView.addArrangedSubview(pageControl)
        bottomStackView.addArrangedSubview(nextButton)
        
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
    }
    
    // Mengatur tampilan koleksi dan memanggil fungsi configureBottomStackView() untuk mengatur tampilan bawah.
    func configureViewController() {
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SwipeCell.self, forCellWithReuseIdentifier: SwipeCell.reuseIdentifier)
        
        configureBottomStackView()
        
        NSLayoutConstraint.activate([
            bottomStackView.heightAnchor.constraint(equalToConstant: 40),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
}
