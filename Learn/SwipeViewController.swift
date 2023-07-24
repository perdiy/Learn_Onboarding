//
//  SwipeViewController.swift
//  Learn
//
//  Created by Perdi Yansyah on 25/07/23.
//

import UIKit

class SwipeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let swipeItems = [
        SwipeItem(image: "page1", headline: " Let's Get Started", subheadline: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        SwipeItem(image: "page2", headline: "Your Onboarding Journey Begins!", subheadline: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        SwipeItem(image: "page3", headline: "Your First Steps to Success", subheadline: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact.")
    ]
    
    let previousButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let pageControl = UIPageControl()
    let bottomStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swipeItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwipeCell.reuseIdentifier, for: indexPath) as! SwipeCell
        let swipeItem = swipeItems[indexPath.item]
        cell.update(image: swipeItem.image, headline: swipeItem.headline, subheadline: swipeItem.subheadline)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    @objc func previousButtonDidTap() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func nextButtonDidTap() {
        let nextIndex = min(pageControl.currentPage + 1, swipeItems.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func configureBottomStackView() {
        previousButton.setTitle("Skip", for: .normal)
        previousButton.setTitleColor(.systemGray, for: .normal)
        previousButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        previousButton.addTarget(self, action: #selector(previousButtonDidTap), for: .touchUpInside)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = swipeItems.count
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
                
        bottomStackView.addArrangedSubview(previousButton)
        bottomStackView.addArrangedSubview(pageControl)
        bottomStackView.addArrangedSubview(nextButton)
        
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
    }
    
    func configureViewController() {
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SwipeCell.self, forCellWithReuseIdentifier: SwipeCell.reuseIdentifier)
        
        configureBottomStackView()
        
        NSLayoutConstraint.activate([
            bottomStackView.heightAnchor.constraint(equalToConstant: 100),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
