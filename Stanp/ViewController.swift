//
//  ViewController.swift
//  Stanp
//
//  Created by 今泉　孝陽 on 2019/11/01.
//  Copyright © 2019 com.litech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //スタンプ画像の名前が入った配列
    var imageNameAllay: [String] = ["hana", "hoshi", "onpu", "shitumon"]
    
    //選択しているスタンプの画像
    var  imageIndex: Int = 0
    
    //背景画像を表示させるImageView
    @IBOutlet var haikeiImageView: UIImageView!
    
    //スタンプ画像が入るImageView
    var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,tipecally from a nib.
        
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        // タッチされた位置を取得
        let touch : UITouch = touches.first!
        let location : CGPoint = touch.location(in: self.view)
            
        // もしimageIndexが0でない(押すスタンプが選ばれている）とき
        if imageIndex != 0 {
               
            // スタンプサイズを40pxの正方形に指定
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            
            // 押されたスタンプの画像を設定
            let image: UIImage = UIImage(named: imageNameAllay[imageIndex - 1])!
            imageView.image = image
            
            //タッチされた位置に画像を置く
            imageView.center = CGPoint(x: location.x, y: location.y)
            
            //画像を表示する
            self.view.addSubview(imageView)
        }
        
    }
    
    @IBAction func selectedFirst() {
        imageIndex = 1
    }
    
    @IBAction func selectedSecond() {
        imageIndex = 2
    }
    
    @IBAction func selectedThird() {
        imageIndex = 3
    }
    
    @IBAction func selectedFourth() {
        imageIndex = 4
    }
    
    @IBAction func back() {
        self.imageView.removeFromSuperview()
    }
    


    @IBAction func selectBackground() {
        // UIImagePickerControllerのインスタンスをつくる
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        //フォトライブラリを使う設定をする
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        //フォトライブラリを呼び出す
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
            
        // imageに選んだ画像を設定する
        let image = info[.originalImage] as? UIImage
        
        // imageを背景に設定する
        haikeiImageView.image = image
        
        // フォトライブラリを閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        //画面上のスクリーンショットを取得
        let rect:CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!,nil, nil, nil)
    }
    
}
       
   
