//
//  UIView+Extension.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/8/24.
//

import UIKit

protocol ReuseIdentifying {
    static var id: String { get }
}

extension UIView: ReuseIdentifying {
    static var id: String {
          return String(describing: self)
      }
}
