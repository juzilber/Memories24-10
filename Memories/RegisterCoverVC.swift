//
//  RegisterCoverVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class RegisterCoverVC:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBAction func tutorialButton(sender: AnyObject) {
        
        var controller: TutorialVC = TutorialVC(nibName:"TutorialVC", bundle:NSBundle.mainBundle())
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    //botao da imagem de capa
    @IBOutlet var buttonTeste2: UIButton!
    @IBOutlet var buttonCancel: UIButton!
    
    //vai pertimir acessar a camera para escolher imagem para a capa
    let imageCoverEdit = UIImagePickerController()
    
    //imageView é a foto de perfil da pessoa. myImage permite acessar a camera.
    @IBOutlet var imageView: UIImageView!
    let myImage = UIImagePickerController()
    
    @IBOutlet var textFieldTitle: UITextField!
    
    @IBOutlet var textFieldName: UITextField!
    
    var backImage : UIImage?
    
    var chamada:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImage.delegate = self
        
        imageCoverEdit.delegate = self
        
        textFieldName.delegate = self
        
        textFieldTitle.delegate = self
        
        
        // cria um tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "imageTapped:")
        
        // adiciona o gesture a imageView
        imageView.addGestureRecognizer(tapGesture)
        
        //buttonTeste.backgroundColor = UIColor.yellowColor()
        
        // faz com que a imageView fique redonda
        imageView.userInteractionEnabled = true
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.clearColor().CGColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        
        
        var daoCover = DAOCover()
        let myCover = daoCover.getData();
        if(myCover != nil){
            textFieldTitle.text = myCover?.title;
            textFieldName.text = myCover?.name;
            imageView.image = UIImage(contentsOfFile: myCover!.imageProfile);
        }
        
    }
    
    //funcao para que o textField feche quando aperta return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //funcao para escolher a imagem. IF apertar botao da imagem redonda, muda a imageView. ELSE muda a imagem do botao
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if( chamada == "Imagem Redonda" ){
                imageView.contentMode = .ScaleAspectFill
                imageView.image = pickedImage
            } else {
                buttonTeste2.imageView?.contentMode = .ScaleAspectFill
                buttonTeste2.setImage(pickedImage, forState: UIControlState.Normal)
                backImage = pickedImage
            }
        }
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func imageTapped(gesture: UIGestureRecognizer) {
        
        // if the tapped view is a UIImageView then set it to imageview
        
        if let imageView = gesture.view as? UIImageView {
            println("Image Tapped")
            
            //Here you can initiate your new ViewController
            
            myImage.allowsEditing = false
            myImage.sourceType = .PhotoLibrary
            
            chamada = "Imagem Redonda"
            
            presentViewController(myImage, animated: true, completion: nil)
            
        }
        
    }
    
    //botao que salva as infos e leva direto pra DAOCover
    @IBAction func buttonSave(sender: AnyObject) {
        
        var cover: Cover = Cover()
        
        cover.title = textFieldTitle.text
        cover.name = textFieldName.text
        
        var daoCover = DAOCover()
        
        daoCover.saveData(cover, imageProfile: imageView.image!, imageBackground: buttonTeste2.imageView!.image)
       
        let coverVC = CoverVC(nibName: "CoverVC", bundle: nil)
        
        toCoverScreen(coverVC);

    }
    
    
    
    @IBAction func cancelRegistration(sender: AnyObject) {
    
        let cover = CoverVC(nibName: "CoverVC", bundle: nil)
        
        //cover.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        toCoverScreen(cover);
        
    }
    
    private func toCoverScreen(vc : UIViewController){
        if let p = presentingViewController{
            if(p.isKindOfClass(CoverVC)){
                dismissViewControllerAnimated(true, completion: nil);
            }
            else{
                presentViewController(vc, animated: true, completion: nil)
            }
        }
        else{
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    //botao para acessar a troca de imagem de capa
    @IBAction func buttonTesteAcao(sender: AnyObject) {
        println("Image Tapped")
        
        imageCoverEdit.allowsEditing = false
        imageCoverEdit.sourceType = .PhotoLibrary
        
        chamada = "Imagem de Trás"
        
        presentViewController(imageCoverEdit, animated: true, completion: nil)
        
    }
    
    
}