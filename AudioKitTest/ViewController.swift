//
//  ViewController.swift
//  AudioKitTest
//
//  Created by George Oblapenko on 29/11/2017.
//  Copyright © 2017 George Oblapenko. All rights reserved.
//

import UIKit
import AudioKit

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
    var freq_range = 5.0
    var osclist: [AKOscillator] = []
    
    var mixer = AKMixer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mixer = AKMixer(osc1, osc2, osc3, osc4, osc5, osc6, osc7, osc8, osc9, osc10, osc11, osc12)
        osc1.frequency = 40
        osc2.frequency = 40
        osc3.frequency = 130
        osc4.frequency = 130
        osc5.frequency = 300
        osc6.frequency = 300
        osc7.frequency = 1200
        osc8.frequency = 1200
        osc9.frequency = 3000
        osc10.frequency = 3000
        osc11.frequency = 6000
        osc12.frequency = 6000
        osclist = [osc1, osc2, osc3, osc4, osc5, osc6, osc7, osc8, osc9, osc10, osc11, osc12]
        mixer.volume = 0.5
        AudioKit.output = mixer
        AudioKit.start()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AdjustRange(_ sender: UISlider!) {
        freq_range = Double(sender.value)
        for osc_index in 0...5 {
            osclist[2*osc_index + 1].frequency = max(5, osclist[2 * osc_index].frequency + Double(random(in: -100 ... 100)) * freq_range / 100)
        }
    }
    
    
    @IBAction func ControlOscillators(_ sender: UISlider!) {
        let change_vol = sender.tag % 2
        if (change_vol > 0) {
            osclist[sender.tag - 1].amplitude = Double(sender.value) / 100
            osclist[sender.tag].amplitude = Double(sender.value) / 100
        }
        else {
            osclist[sender.tag].frequency = Double(sender.value)
            osclist[sender.tag + 1].frequency = max(5, osclist[sender.tag].frequency + Double(random(in: -100 ... 100)) * freq_range / 100)
        }
    }
    
    
    @IBAction func SoundToggle(_ sender: Any) {
        if osc1.isPlaying {
            osclist.forEach { $0.stop() }
//            osc1.stop()
//            osc2.stop()
//            osc3.stop()
//            osc4.stop()
//            osc5.stop()
//            osc6.stop()
//            osc7.stop()
//            osc8.stop()
//            osc9.stop()
//            osc10.stop()
//            osc11.stop()
//            osc12.stop()
        } else {
            osclist.forEach { $0.start() }
//            osc1.start()
//            osc2.start()
//            osc3.start()
//            osc4.start()
//            osc5.start()
//            osc6.start()
//            osc7.start()
//            osc8.start()
//            osc9.start()
//            osc10.start()
//            osc11.start()
//            osc12.start()
        }
    }
    
}

