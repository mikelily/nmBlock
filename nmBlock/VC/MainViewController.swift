//
//  ViewController.swift
//  nmBlock
//
//  Created by 林華淵 on 2022/3/26.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasicViews()
    }
    
    let nTextField = UITextField()
    let mTextField = UITextField()
    func setBasicViews(){
        view.addTapGestureRecognizer {
            self.view.endEditing(true)
        }
        
        let btnBackground = UIView()
        btnBackground.layer.borderWidth = 1
        btnBackground.layer.cornerRadius = 5
        view.addSubview(btnBackground)
        btnBackground.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
        
        let btnLabel = UILabel()
        btnLabel.text = "Show Blocks"
        btnLabel.font = .boldSystemFont(ofSize: 20)
        btnBackground.addSubview(btnLabel)
        btnLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let xLabel = UILabel()
        xLabel.text = "X"
        xLabel.textColor = .black
        xLabel.font = .boldSystemFont(ofSize: 30)
        view.addSubview(xLabel)
        xLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(btnBackground.snp.bottom).offset(-100)
        }
        
        nTextField.font = .boldSystemFont(ofSize: 30)
        nTextField.layer.borderWidth = 1
        nTextField.textAlignment = .center
        nTextField.keyboardType = .numberPad
        view.addSubview(nTextField)
        nTextField.snp.makeConstraints { make in
            make.centerY.equalTo(xLabel)
            make.right.equalTo(xLabel.snp.left).offset(-30)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        mTextField.font = .boldSystemFont(ofSize: 30)
        mTextField.layer.borderWidth = 1
        mTextField.textAlignment = .center
        mTextField.keyboardType = .numberPad
        view.addSubview(mTextField)
        mTextField.snp.makeConstraints { make in
            make.centerY.equalTo(xLabel)
            make.left.equalTo(xLabel.snp.right).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        let introLabel = UILabel()
        introLabel.text = "Input Two Nums :"
        introLabel.textColor = .black
        introLabel.font = .boldSystemFont(ofSize: 36)
        view.addSubview(introLabel)
        introLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(xLabel.snp.top).offset(-50)
        }
        
        
        btnBackground.addTapGestureRecognizer {
            // handle click btn
            let rowNum = Int(self.nTextField.text!)
            let columnNum = Int(self.mTextField.text!)
            
            if rowNum != nil && columnNum != nil{
                let blockVC = BlockViewController()
                blockVC.rowNum = rowNum!
                blockVC.columnNum = columnNum!
                
                blockVC.modalPresentationStyle = .fullScreen
                self.present(blockVC, animated: true, completion: nil)
            }else{
                let alertView = UIView()
                alertView.backgroundColor = .white
                alertView.layer.cornerRadius = 5
                alertView.layer.borderWidth = 2
                self.view.addSubview(alertView)
                alertView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalTo(300)
                    make.height.equalTo(50)
                }
                
                let alertLabel = UILabel()
                alertLabel.font = .boldSystemFont(ofSize: 20)
                alertLabel.text = "Check input, only numbers."
                alertView.addSubview(alertLabel)
                alertLabel.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
                
                alertView.addTapGestureRecognizer {
                    self.nTextField.text = ""
                    self.mTextField.text = ""
                    alertView.removeFromSuperview()
                }
            }
        }
    }

}

