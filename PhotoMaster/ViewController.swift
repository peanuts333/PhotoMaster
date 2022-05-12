//
//  ViewController.swift
//  PhotoMaster
//
//  Created by user on 2022/05/11.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    //写真表示imageView
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    //カメラとアルバムの呼び出しメソッド
    func presentPickerController(sorceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sorceType){
            let picker = UIImagePickerController()
            picker.sourceType = sorceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }
    }
    
    //写真が選択されたときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]){
        self.dismiss(animated: true, completion: nil)
        //画像を出力
        photoImageView.image = info[.originalImage]as? UIImage
    }
    //カメラボタンを押した時メソッド
    @IBAction func onTappedCameraButton(){
        presentPickerController(sorceType: .camera)
    }
    //アルバムメソッド
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sorceType: .photoLibrary)
    
    }
    
    //もとの画像にテキストを合成
    func drawText(image: UIImage) -> UIImage{
        
        let text = "LifeisTech!"
        
        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 200)!,
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]
    //}は必要？
        //グラフィックコンテキスト
        UIGraphicsBeginImageContext(image.size)
        
        //読み込んだ写真を書き出す
       image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //定義
        let margin: CGFloat = 5.0 //余白
        let textRect = CGRect(x: margin, y:margin, width: image.size.width - margin, height: image.size.height - margin)
        
        //textRectで指定した範囲に
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        //グラフィックコンテキストの画像を取得
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //グラフィックコンテキストの編集を終了
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage{
        
        let maskImage = UIImage(named: "furo_ducky")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin, y:image.size.height - maskImage.size.height - margin, width: maskImage.size.width, height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //テキスト合成ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedTextButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawText(image: photoImageView.image!)
        }else {
            print("画像がありません。")
        }
    }
    
    //イラスト合成ボタン
    @IBAction func onTappedillustButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else {
            print("画像がありません。")
        }
    }
    
    //アップロード
    @IBAction func onTappedUploadButton(){
        if photoImageView.image != nil {
            //共有するアイテムを設定
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!, "#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            print("画像がありません。")
        }
    }
    
    
    
}




