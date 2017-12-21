//
//  ViewController.swift
//  AudioKitTest
//
//  Created by George Oblapenko on 29/11/2017.
//  Copyright © 2017 George Oblapenko. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class ViewController: UIViewController {
    
    var osc1 = AKOscillator()
    var osc2 = AKOscillator()
    var osc3 = AKOscillator()
    var osc4 = AKOscillator()
    var osc5 = AKOscillator()
    var osc6 = AKOscillator()
    var osc7 = AKOscillator()
    var osc8 = AKOscillator()
    var osc9 = AKOscillator()
    var osc10 = AKOscillator()
    var osc11 = AKOscillator()
    var osc12 = AKOscillator()
    var osc13 = AKOscillator()
    var osc14 = AKOscillator()
    var osc15 = AKOscillator()
    var osc16 = AKOscillator()
    var freq_range = 5.0
    var osclist: [AKOscillator] = []
    
    var mixer = AKMixer()
    
    @IBOutlet var audioInputPlot: EZAudioPlot!
    func setupPlot() {
        let plot = AKNodeOutputPlot(mixer, frame: audioInputPlot.bounds)
        plot.plotType = .rolling
        plot.contentScaleFactor = 0.3
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.backgroundColor = UIColor.black
//        plot.color = UIColor.red
        audioInputPlot.addSubview(plot)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mixer = AKMixer(osc1, osc2, osc3, osc4, osc5, osc6, osc7, osc8, osc9, osc10, osc11, osc12, osc13, osc14, osc15, osc16)
        osc1.frequency = 40
        osc2.frequency = 40
        osc3.frequency = 130
        osc4.frequency = 130
        osc5.frequency = 300
        osc6.frequency = 300
        osc7.frequency = 400
        osc8.frequency = 400
        
        osc9.frequency = 10000
        osc10.frequency = 10000
        osc11.frequency = 11000
        osc12.frequency = 11000
        osc13.frequency = 12000
        osc14.frequency = 12000
        osc15.frequency = 14000
        osc16.frequency = 14000
        osclist = [osc1, osc2, osc3, osc4, osc5, osc6, osc7, osc8, osc9, osc10, osc11, osc12, osc13, osc14, osc15, osc16]
        mixer.volume = 0.5 / 12;
        AudioKit.output = mixer
        AudioKit.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupPlot()
//        Timer.scheduledTimer(timeInterval: 0.1,
//                             target: self,
//                             selector: #selector(ViewController.updateUI),
//                             userInfo: nil,
//                             repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AdjustRange(_ sender: UISlider!) {
        freq_range = Double(sender.value)
        for osc_index in 0...7 {
            osclist[2*osc_index + 1].frequency = max(5, osclist[2 * osc_index].frequency + Double(random(in: -100 ... 100)) * freq_range / 100)
        }
    }
    
    @IBAction func ControlOscillatorFrequency(_ sender: UISlider!) {
        osclist[sender.tag - 1].frequency = Double(sender.value)
        osclist[sender.tag].frequency = max(5, osclist[sender.tag].frequency + Double(random(in: -100 ... 100)) * freq_range / 100)
    }
    
    @IBAction func ControlOscillatorVolume(_ sender: UISlider!) {
        osclist[sender.tag - 2].amplitude = Double(sender.value) / 100
        osclist[sender.tag - 1].amplitude = Double(sender.value) / 100
    }
    
    @IBAction func ControlMixerVolume(_ sender: UISlider!) {
        mixer.volume = Double(sender.value) / 100 / 12
    }
    
    @IBAction func SoundToggle(_ sender: Any) {
        if osc1.isPlaying {
            osclist.forEach { $0.stop() }
        } else {
            osclist.forEach { $0.start() }
        }
    }
    
}

