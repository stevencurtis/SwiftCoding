//
//  TimerTableViewCell.swift
//  CountDownTable
//
//  Created by Steven Curtis on 03/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    @IBOutlet weak var hoursView: CountDown!
    @IBOutlet weak var minutesView: CountDown!
    @IBOutlet weak var secondsView: CountDown!
    
    var secondsClosure: (() -> ())?
    var minutesClosure: (() -> ())?
    var hoursClosure: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        secondsView.animationClosure = {
            if let seconds = self.secondsClosure {
                seconds()
            }
        }
        minutesView.animationClosure = {
            if let minutes = self.minutesClosure {
                minutes()
            }
        }
        
        hoursView.animationClosure = {
            if let hours = self.hoursClosure {
                hours()
            }
        }
    }
}
