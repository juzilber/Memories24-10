//
//  RegisterFamilyVC.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/18/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//
import AVFoundation
import UIKit

class RegisterFamilyVC: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate, UINavigationControllerDelegate {

    //imagem
    @IBOutlet var familyImg: UIImageView!
    
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    
    //áudio
    @IBOutlet var recordBtn: UIButton!
    @IBOutlet var playBtn: UIButton!
    @IBOutlet var stopBtn: UIButton!
    @IBOutlet var statusLbl: UILabel!
    
    //texto
    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var connetionTxt: UITextField!

    //vai pertimir acessar a camera para escolher imagem para a capa
    var imageFamilyEdit = UIImagePickerController()
  
    var call:String!
    
    //variáveis relativas à gravação de áudio
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var recorder: AVAudioRecorder!
    var player:AVAudioPlayer!
    var meterTimer:NSTimer!
    var soundFileURL:NSURL?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    imageFamilyEdit.delegate = self
    nameTxt.delegate = self
    connetionTxt.delegate = self
    
        // cria um tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "imageTapped:")
        
        // adiciona o gesture a imageView
        familyImg.addGestureRecognizer(tapGesture)
        
        // faz com que a imageView fique redonda
        familyImg.userInteractionEnabled = true
        familyImg.layer.borderWidth = 1
        familyImg.layer.masksToBounds = false
        familyImg.layer.borderColor = UIColor.clearColor().CGColor
        familyImg.layer.cornerRadius = familyImg.frame.height/4
        familyImg.clipsToBounds = true
        

        //Ativa/desativa botoes play e stop
        playBtn.enabled = false
        stopBtn.enabled = false
        
        askForNotifications()
        
    
    }
    
    
    //funcao para que o textField feche quando aperta return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //funcao para escolher a imagem. IF apertar botao da imagem redonda, muda a imageView. ELSE muda a imagem do botao
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
         if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if( call == "Imagem Redonda" ){
                familyImg.contentMode = .ScaleAspectFill
                familyImg.image = pickedImage
            }
        }
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        
        // if the tapped view is a UIImageView then set it to imageview
        
        if let imageView = gesture.view as? UIImageView {
            println("Image Tapped")
            
            //Here you can initiate your new ViewController
            
            imageFamilyEdit.allowsEditing = false
            imageFamilyEdit.sourceType = .PhotoLibrary
            
            call = "Imagem Redonda"
            
            presentViewController(imageFamilyEdit, animated: true, completion: nil)
            
        }
        
    }

    //atualiza tempo de gravação de áudio
    func updateAudioMeter(timer:NSTimer) {
        
        if recorder.recording {
            let min = Int(recorder.currentTime / 60)
            let sec = Int(recorder.currentTime % 60)
            let s = String(format: "%02d:%02d", min, sec)
            statusLbl.text = s
            recorder.updateMeters()
            // if you want to draw some graphics...
            var apc0 = recorder.averagePowerForChannel(0)
            var peak0 = recorder.peakPowerForChannel(0)
        }
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonSave(sender: AnyObject) {
        
        var family: Family = Family()
        
        family.connection = connetionTxt.text
        family.subtitle = nameTxt.text
        let img = familyImg.image;
        
        var daoFamily = DAOFamily()
        daoFamily.saveNewFamily(family, photo: img!);
        
        let summaryVC = ShowSummaryVC(nibName: "ShowSummaryC", bundle: nil)
        //presentViewController(summaryVC, animated: true, completion: nil)
        dismissViewControllerAnimated(true, completion: nil);
    }

    
    @IBAction func cancelRegistration(sender: AnyObject) {
    
        let view = ShowSummaryVC(nibName: "ShowSummaryVC", bundle: nil)
        
        dismissViewControllerAnimated(true, completion: nil);
        //presentViewController(view, animated: true, completion: nil)
    
    
    }


    @IBAction func recordAudio(sender: AnyObject) {
        if player != nil && player.playing {
            player.stop()
        }
        
        if recorder == nil {
            println("recording. recorder nil")
            recordBtn.setTitle("Pause", forState:.Normal)
            playBtn.enabled = false
            stopBtn.enabled = true
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.recording {
            println("pausing")
            recorder.pause()
            recordBtn.setTitle("Continue", forState:.Normal)
            
        } else {
            println("recording")
            recordBtn.setTitle("Pause", forState:.Normal)
            playBtn.enabled = false
            stopBtn.enabled = true
            //            recorder.record()
            recordWithPermission(false)
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        println("stop")
        
        recorder?.stop()
        player?.stop()
        
        meterTimer.invalidate()
        
        recordBtn.setTitle("Record", forState:.Normal)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setActive(false, error: &error) {
            println("could not make session inactive")
            if let e = error {
                println(e.localizedDescription)
                return
            }
        }
        playBtn.enabled = true
        stopBtn.enabled = false
        recordBtn.enabled = true
        //recorder = nil
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        play()
    }
    
    func play() {
        
        println("playing")
        var error: NSError?
        
        if let r = recorder {
            self.player = AVAudioPlayer(contentsOfURL: r.url, error: &error)
            if self.player == nil {
                if let e = error {
                    println(e.localizedDescription)
                }
            }
        }
        
        stopBtn.enabled = true
        
        player.delegate = self
        player.prepareToPlay()
        player.volume = 6.0
        player.play()
    }

    func setupRecorder() {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording-\(format.stringFromDate(NSDate())).m4a"
        println(currentFileName)
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let filemanager = NSFileManager.defaultManager()
        if filemanager.fileExistsAtPath(soundFilePath) {
            // probably won't happen. want to do something about it?
            println("sound exists")
        }
        
        var recordSettings:[NSObject: AnyObject] = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        var error: NSError?
        recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings, error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
    }
    
    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()
                    self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,
                        target:self,
                        selector:"updateAudioMeter:",
                        userInfo:nil,
                        repeats:true)
                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }
    
    func setSessionPlayAndRecord() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    func askForNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"background:",
            name:UIApplicationWillResignActiveNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"foreground:",
            name:UIApplicationWillEnterForegroundNotification,
            object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector:"routeChange:",
            name:AVAudioSessionRouteChangeNotification,
            object:nil)
    }
    
    func background(notification:NSNotification) {
        println("background")
    }
    
    func foreground(notification:NSNotification) {
        println("foreground")
    }


}


// MARK: AVAudioRecorderDelegate
extension RegisterFamilyVC : AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool) {
            println("finished recording \(flag)")
            stopBtn.enabled = false
            playBtn.enabled = true
            recordBtn.setTitle("Record", forState:.Normal)
            
            // iOS8 and later
            var alert = UIAlertController(title: "Recorder",
                message: "Finished Recording",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Keep", style: .Default, handler: {action in
                println("keep was tapped")
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: {action in
                println("delete was tapped")
                self.recorder.deleteRecording()
            }))
            self.presentViewController(alert, animated:true, completion:nil)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!,
        error: NSError!) {
            println("\(error.localizedDescription)")
    }
}

// MARK: AVAudioPlayerDelegate
extension RegisterFamilyVC : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("finished playing \(flag)")
        recordBtn.enabled = true
        stopBtn.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }
}

