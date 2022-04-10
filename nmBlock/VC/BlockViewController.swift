//
//  BlockViewController.swift
//  nmBlock
//
//  Created by 林華淵 on 2022/3/27.
//

import UIKit

class BlockViewController: UIViewController {
    
    var rowNum: Int = 1
    var columnNum: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasicViews()
        setOuterLine()
        setBlocks()
        setSpecialBlock()
        setTimer()
    }
    
    let boardView = UIView()
    func setBasicViews(){
        view.backgroundColor = .white
        
        view.addSubview(boardView)
        boardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight+20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-bottomSafeAreaHeight-20)
        }
    }
    
    func setOuterLine(){
        let topLine = UIView()
        topLine.backgroundColor = .lightGray
        view.addSubview(topLine)
        topLine.snp.makeConstraints { make in
            make.width.centerX.equalTo(boardView)
            make.centerY.equalTo(boardView.snp.top)
            make.height.equalTo(5)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        view.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.width.centerX.equalTo(boardView)
            make.centerY.equalTo(boardView.snp.bottom)
            make.height.equalTo(5)
        }
        
        let leftLine = UIView()
        leftLine.backgroundColor = .lightGray
        view.addSubview(leftLine)
        leftLine.snp.makeConstraints { make in
            make.height.centerY.equalTo(boardView)
            make.centerX.equalTo(boardView.snp.left)
            make.width.equalTo(5)
        }
        
        let rightLine = UIView()
        rightLine.backgroundColor = .lightGray
        view.addSubview(rightLine)
        rightLine.snp.makeConstraints { make in
            make.height.centerY.equalTo(boardView)
            make.centerX.equalTo(boardView.snp.right)
            make.width.equalTo(5)
        }
    }
    
    func setBlocks(){
        for sv in boardView.subviews{
            sv.removeFromSuperview()
        }
        
        guard rowNum > 1 || columnNum > 1 else{
            print("end")
            stopTimer()
            setAgainBtn()
            return
        }
        
        let blockWidth: CGFloat = (fullScreenSize.width - 40)/CGFloat(columnNum)
        let blockHeight: CGFloat = (fullScreenSize.height - 40 - statusBarHeight - bottomSafeAreaHeight)/CGFloat(rowNum)
        
//        print(blockWidth,blockHeight,rowNum,columnNum)
        
        for index in 0..<rowNum*columnNum{
            let block = UIView()
            block.layer.borderWidth = 1
            block.layer.borderColor = UIColor.lightGray.cgColor
            block.tag = index
            boardView.addSubview(block)
            block.snp.makeConstraints { make in
                make.width.equalTo(blockWidth)
                make.height.equalTo(blockHeight)
                make.left.equalToSuperview().offset(blockWidth * CGFloat(index % columnNum) )
                make.top.equalToSuperview().offset(blockHeight * CGFloat(index / columnNum) )
            }
        }
    }
    
    func setSpecialBlock(){
        let index = Int.random(in: 0..<rowNum*columnNum)
        for sv in boardView.subviews{
            if sv.tag == index{
                sv.layer.borderColor = UIColor.blue.cgColor
                sv.layer.borderWidth = 3
                sv.addTapGestureRecognizer {
                    self.setAlert(index: index)
                }
            }else{
                sv.layer.borderWidth = 1
                sv.layer.borderColor = UIColor.lightGray.cgColor
                sv.addTapGestureRecognizer {
                    // init (clean, do notning)
                }
            }
        }
    }
    
    var timer1: Timer?  /// 減少格子
    var timer2: Timer?  /// 上色
    func setTimer(){
        timer1 = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            self.columnNum = self.columnNum == 1 ? 1 : self.columnNum - 1
            self.rowNum = self.rowNum == 1 ? 1 : self.rowNum - 1
            self.setBlocks()
        })
        
        timer2 = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
            self.setSpecialBlock()
        })
    }
    
    func stopTimer(){
        timer1?.invalidate()
        timer2?.invalidate()
    }
    
    func setAgainBtn(){
        let againBKView = UIView()
        againBKView.layer.cornerRadius = 5
        againBKView.layer.borderWidth = 2
        view.addSubview(againBKView)
        againBKView.snp.makeConstraints { make in
            make.center.equalTo(boardView)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        let againLabel = UILabel()
        againLabel.font = .boldSystemFont(ofSize: 20)
        againLabel.text = "Again"
        againBKView.addSubview(againLabel)
        againLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        againBKView.addTapGestureRecognizer {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func setAlert(index: Int){
        let row = index/columnNum + 1
        let column = index%columnNum + 1
        
        stopTimer()
        
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 5
        alertView.layer.borderWidth = 2
        view.addSubview(alertView)
        alertView.snp.makeConstraints { make in
            make.center.equalTo(boardView)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        let alertLabel = UILabel()
        alertLabel.font = .boldSystemFont(ofSize: 50)
        alertLabel.text = "(\(row),\(column))"
        alertView.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        alertView.addTapGestureRecognizer {
            self.setTimer()
            alertView.removeFromSuperview()
        }
    }
}
