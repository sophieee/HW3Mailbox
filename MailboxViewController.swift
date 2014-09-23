//
//  MailboxViewController.swift
//  HW3Mailbox
//
//  Created by Sophie Tang on 9/16/14.
//  Copyright (c) 2014 Sophie Tang. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var MessageImage: UIImageView!
    @IBOutlet weak var FeedScrollView: UIScrollView!
    @IBOutlet weak var FeedImage: UIImageView!
    @IBOutlet weak var LaterIcon: UIImageView!
    @IBOutlet weak var ListIcon: UIImageView!
    @IBOutlet weak var ArchiveIcon: UIImageView!
    @IBOutlet weak var DeleteIcon: UIImageView!
    @IBOutlet weak var OtherViews: UIView!
    @IBOutlet weak var RescheduleImage: UIImageView!
    @IBOutlet weak var ListImage: UIImageView!
    
    @IBAction func OnDismiss(sender: AnyObject) {
        
        OtherViews.hidden = true
        RescheduleImage.alpha = 0
        ListImage.alpha = 0
        
        MessageImage.center = CGPointMake(160, 43)
        
    }
    
    var originalImageCenter: CGPoint!
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        FeedScrollView.contentSize = CGSizeMake(320, 1288)
        OtherViews.hidden = true
        RescheduleImage.alpha = 0
        ListImage.alpha = 0
        LaterIcon.alpha = 0
        ListIcon.alpha = 0
        ArchiveIcon.alpha = 0
        DeleteIcon.alpha = 0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnDragMessage(sender: UIPanGestureRecognizer) {
        
        var location = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        println("You panned on Message, velocity.x = \(velocity.x)")
        
        if(sender.state == UIGestureRecognizerState.Began){
            println("Pan began")
            originalImageCenter = MessageImage.center
        } else if(sender.state == UIGestureRecognizerState.Changed){
            println("Pan changed")
            MessageImage.center = CGPointMake(originalImageCenter.x + translation.x, originalImageCenter.y)
        } else if(sender.state == UIGestureRecognizerState.Ended){
            println("Pan ended")
        }
        
        var MessageCenter = Float(MessageImage.center.x)

        var BGAlphaRight = convertValue(MessageCenter, r1Min: 160, r1Max: 100, r2Min: 0.5, r2Max: 1)
        
        var BGAlphaLeft = convertValue(MessageCenter, r1Min: 160, r1Max: 220, r2Min: 0.5, r2Max: 1)
        
        //swipe to the left, grey
        //stop, then back to original position
        if(MessageCenter >= 100 && MessageCenter <= 160 && sender.state == UIGestureRecognizerState.Changed){
            
            LaterIcon.alpha = 1
            ListIcon.alpha = 0
            ArchiveIcon.alpha = 0
            DeleteIcon.alpha = 0
            
            Container.backgroundColor = UIColor(red: CGFloat(200)/255.0, green: CGFloat(200)/255.0, blue: CGFloat(200)/255.0, alpha: CGFloat(BGAlphaRight))

        }else if(MessageCenter >= 100 && MessageCenter <= 160 &&
            sender.state == UIGestureRecognizerState.Ended){
                
            MessageImage.center = CGPointMake(160, 43)
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            ArchiveIcon.alpha = 0
            DeleteIcon.alpha = 0
            
        }
        
        //swipe to the left, yellow, later
        //stop, then display reschedule view
        if(MessageCenter < 100 && MessageCenter > -100 && sender.state == UIGestureRecognizerState.Changed){
            
            Container.backgroundColor = UIColor(red: CGFloat(255)/255.0, green: CGFloat(211)/255.0, blue: CGFloat(32)/255.0, alpha: 1)
            
            LaterIcon.alpha = 1
            ListIcon.alpha = 0
            ArchiveIcon.alpha = 0
            DeleteIcon.alpha = 0
            
            LaterIcon.center = CGPointMake(196.5 + CGFloat(MessageCenter), 42.5)
            
        } else if(MessageCenter < 100 && MessageCenter > -100 && sender.state == UIGestureRecognizerState.Ended){
            
            Container.backgroundColor = UIColor(red: CGFloat(255)/255.0, green: CGFloat(211)/255.0, blue: CGFloat(32)/255.0, alpha: 1)
            
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            ArchiveIcon.alpha = 0
            DeleteIcon.alpha = 0
            OtherViews.hidden = false
            RescheduleImage.alpha = 1
            ListImage.alpha = 0
        }

        //swipe to the left, brown, list
        //stop, then display list view
        if(MessageCenter <= -100 && sender.state == UIGestureRecognizerState.Changed){
            
            LaterIcon.alpha = 0
            ListIcon.alpha = 1
            ArchiveIcon.alpha = 0
            DeleteIcon.alpha = 0
            
            Container.backgroundColor = UIColor(red: CGFloat(216)/255.0, green: CGFloat(166)/255.0, blue: CGFloat(117)/255.0, alpha: 1)
            
            ListIcon.center = CGPointMake(192.5 + CGFloat(MessageCenter), 42.5)
            
        } else if(MessageCenter <= -100 && sender.state == UIGestureRecognizerState.Ended){
            
            Container.backgroundColor = UIColor(red: CGFloat(216)/255.0, green: CGFloat(166)/255.0, blue: CGFloat(117)/255.0, alpha: 1)
            
            ListIcon.alpha = 0
            LaterIcon.alpha = 0
            ArchiveIcon.alpha = 0
            DeleteIcon.alpha = 0
            OtherViews.hidden = false
            RescheduleImage.alpha = 0
            ListImage.alpha = 1
            
            
        }
        
        //swipe to the right, grey
        //stop, then back
        if(MessageCenter > 160 && MessageCenter <= 220 && sender.state == UIGestureRecognizerState.Changed){
        
            Container.backgroundColor = UIColor(red: CGFloat(200)/255.0, green: CGFloat(200)/255.0, blue: CGFloat(200)/255.0, alpha: CGFloat(BGAlphaLeft))
            
            ArchiveIcon.alpha = 1
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            DeleteIcon.alpha = 0
            
        } else if(MessageCenter > 160 && MessageCenter <= 220 && sender.state == UIGestureRecognizerState.Ended){
            
            MessageImage.center = CGPointMake(160, 43)
            ArchiveIcon.alpha = 0
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            DeleteIcon.alpha = 0
            
        }
        
        //swipe to the right, green
        //stop, then hide message
        if(MessageCenter > 220 && MessageCenter <= 420 && sender.state == UIGestureRecognizerState.Changed){
        
            Container.backgroundColor = UIColor(red: CGFloat(98)/255.0, green: CGFloat(217)/255.0, blue: CGFloat(98)/255.0, alpha: 1)
            
            ArchiveIcon.alpha = 1
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            DeleteIcon.alpha = 0
            
            ArchiveIcon.center = CGPointMake(CGFloat(MessageCenter) - 199.5, 42.5)
            
        } else if(MessageCenter > 220 && MessageCenter <= 420 && sender.state == UIGestureRecognizerState.Ended){
            
            ArchiveIcon.alpha = 0
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            DeleteIcon.alpha = 0
            
            Container.backgroundColor = UIColor(red: CGFloat(98)/255.0, green: CGFloat(217)/255.0, blue: CGFloat(98)/255.0, alpha: 1)
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.MessageImage.center = CGPointMake(480, 42.5)
                }, completion: { (finished: Bool) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.FeedImage.frame = CGRectMake(0, 0, 320, 1202)
                        }, completion: {(finished: Bool) -> Void in
                            self.MessageImage.center = CGPointMake(160, -42.5)
                            UIView.animateWithDuration(0.5, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                                self.MessageImage.center = CGPointMake(160, 42.5)
                                self.FeedImage.frame = CGRectMake(0, 85, 320, 1202)
                                }, completion: nil)
                    })
            })
            
        }
        
        //swipe to the right, red
        //stop, then hide message
        if(MessageCenter > 420 && sender.state == UIGestureRecognizerState.Changed){
        
            ArchiveIcon.alpha = 0
            DeleteIcon.alpha = 1
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            
            Container.backgroundColor = UIColor(red: CGFloat(239)/255.0, green: CGFloat(84)/255.0, blue: CGFloat(12)/255.0, alpha: 1)
            DeleteIcon.center = CGPointMake(CGFloat(MessageCenter) - 200 + 7.5, 42.5)
            
        } else if(MessageCenter > 420 && sender.state == UIGestureRecognizerState.Ended){
            
            DeleteIcon.alpha = 0
            LaterIcon.alpha = 0
            ListIcon.alpha = 0
            ArchiveIcon.alpha = 0
            
            Container.backgroundColor = UIColor(red: CGFloat(239)/255.0, green: CGFloat(84)/255.0, blue: CGFloat(12)/255.0, alpha: 1)
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.MessageImage.center = CGPointMake(480, 42.5)
                }, completion: { (finished: Bool) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.FeedImage.frame = CGRectMake(0, 0, 320, 1202)
                        }, completion: {(finished: Bool) -> Void in
                            self.MessageImage.center = CGPointMake(160, -42.5)
                            UIView.animateWithDuration(0.5, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                                self.MessageImage.center = CGPointMake(160, 42.5)
                                self.FeedImage.frame = CGRectMake(0, 85, 320, 1202)
                                }, completion: nil)
                    })
            })

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
