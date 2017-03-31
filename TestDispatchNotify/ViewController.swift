//
//  ViewController.swift
//  TestDispatchNotify
//
//  Created by Martin Angers on 2017-03-30.
//  Copyright © 2017 Harfang Apps inc. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  private var x: Int = 0

  @IBAction func buttonClicked(_ sender: Any) {
    incrementAsync()
  }

  private func incrementAsync() {
    let item = DispatchWorkItem { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.x += 1
      // Uncomment following line and there's no race, probably because print introduces a barrier
      //print("> DispatchWorkItem done")
    }
    item.notify(queue: .main) { [weak self] in
      guard let strongSelf = self else { return }
      print("> \(strongSelf.x)")
    }
    
    DispatchQueue.global(qos: .background).async(execute: item)
  }
}
