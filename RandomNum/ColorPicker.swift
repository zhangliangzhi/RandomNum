//
//  ColorSelect.swift
//  RandomNum
//
//  Created by ZhangLiangZhi on 2017/1/1.
//  Copyright © 2017年 xigk. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ColorPicker : UIView {
    
    weak internal var delegate: ColorPickerDelegate?
    let saturationExponentTop:Float = 2.0
    let saturationExponentBottom:Float = 1.3
    let previewSize: CGFloat = 40
    
    var zoomedPreview: UIView!
    var columns: Int = 19
    var rows: Int = 10
    
    let palette = [
        0xffebee,0xFCE4EC,0xF3E5F5,0xEDE7F6,0xE8EAF6,0xE3F2FD,0xE1F5FE,0xE0F7FA,0xE0F2F1,0xE8F5E9,0xF1F8E9,0xF9FBE7,0xFFFDE7,0xFFF8E1,0xFFF3E0,0xFBE9E7,0xEFEBE9,0xFAFAFA,0xECEFF1,
        0xffcdd2,0xF8BBD0,0xE1BEE7,0xD1C4E9,0xC5CAE9,0xBBDEFB,0xB3E5FC,0xB2EBF2,0xB2DFDB,0xC8E6C9,0xDCEDC8,0xF0F4C3,0xFFF9C4,0xFFECB3,0xFFE0B2,0xFFCCBC,0xD7CCC8,0xF5F5F5,0xCFD8DC,
        0xef9a9a,0xF48FB1,0xCE93D8,0xB39DDB,0x9FA8DA,0x90CAF9,0x81D4FA,0x80DEEA,0x80CBC4,0xA5D6A7,0xC5E1A5,0xE6EE9C,0xFFF59D,0xFFE082,0xFFCC80,0xFFAB91,0xBCAAA4,0xEEEEEE,0xB0BEC5,
        0xe57373,0xF06292,0xBA68C8,0x9575CD,0x7986CB,0x64B5F6,0x4FC3F7,0x4DD0E1,0x4DB6AC,0x81C784,0xAED581,0xDCE775,0xFFF176,0xFFD54F,0xFFB74D,0xFF8A65,0xA1887F,0xE0E0E0,0x90A4AE,
        0xef5350,0xEC407A,0xAB47BC,0x7E57C2,0x5C6BC0,0x42A5F5,0x29B6F6,0x26C6DA,0x26A69A,0x66BB6A,0x9CCC65,0xD4E157,0xFFEE58,0xFFCA28,0xFFA726,0xFF7043,0x8D6E63,0xBDBDBD,0x78909C,
        0xf44336,0xE91E63,0x9C27B0,0x673AB7,0x3F51B5,0x2196F3,0x03A9F4,0x00BCD4,0x009688,0x4CAF50,0x8BC34A,0xCDDC39,0xFFEB3B,0xFFC107,0xFF9800,0xFF5722,0x795548,0x9E9E9E,0x607D8B,
        0xe53935,0xD81B60,0x8E24AA,0x5E35B1,0x3949AB,0x1E88E5,0x039BE5,0x00ACC1,0x00897B,0x43A047,0x7CB342,0xC0CA33,0xFDD835,0xFFB300,0xFB8C00,0xF4511E,0x6D4C41,0x757575,0x546E7A,
        0xd32f2f,0xC2185B,0x7B1FA2,0x512DA8,0x303F9F,0x1976D2,0x0288D1,0x0097A7,0x00796B,0x388E3C,0x689F38,0xAFB42B,0xFBC02D,0xFFA000,0xF57C00,0xE64A19,0x5D4037,0x616161,0x455A64,
        0xc62828,0xAD1457,0x6A1B9A,0x4527A0,0x283593,0x1565C0,0x0277BD,0x00838F,0x00695C,0x2E7D32,0x558B2F,0x9E9D24,0xF9A825,0xFF8F00,0xEF6C00,0xD84315,0x4E342E,0x424242,0x37474F,
        0xb71c1c,0x880E4F,0x4A148C,0x311B92,0x1A237E,0x0D47A1,0x01579B,0x006064,0x004D40,0x1B5E20,0x33691E,0x827717,0xF57F17,0xFF6F00,0xE65100,0xBF360C,0x3E2723,0x212121,0x263238
    ]
    
    @IBInspectable var elementSize: CGFloat = 1.0
        {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private func initialize()
    {
        self.clipsToBounds = true
        let touchGesture = UILongPressGestureRecognizer(target: self, action: #selector(ColorPicker.touchedColor(_:)))
        touchGesture.minimumPressDuration = 0
        touchGesture.allowableMovement = CGFloat.greatestFiniteMagnitude
        self.addGestureRecognizer(touchGesture)
        
        zoomedPreview = UIView(frame: CGRect(x: 0, y: 0, width: previewSize, height: previewSize))
        zoomedPreview.layer.borderColor = UIColor.gray.cgColor
        zoomedPreview.layer.borderWidth = 1
        zoomedPreview.layer.cornerRadius = previewSize / 2
        zoomedPreview.isHidden = true
        
        self.addSubview(zoomedPreview)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func draw(_ rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        
        let cellWidth = rect.width / CGFloat(columns)
        let cellHeight = rect.height / CGFloat(rows)
        
        var index = 0
        for p in palette {
            let color = UIColor(netHex: p)
            
            let i = index % columns
            let j = index / columns
            
            context!.setFillColor(color.cgColor)
            context!.fill(CGRect(x: CGFloat(i) * cellWidth, y: CGFloat(j) * cellHeight, width:cellWidth,height:cellHeight))
            
            index += 1
        }
    }
    
    func getColorAtPoint(point:CGPoint) -> UIColor
    {
        let cellWidth = self.frame.width / CGFloat(columns)
        let cellHeight = self.frame.height / CGFloat(rows)
        let i = Int(point.x / cellWidth)
        let j = Int(point.y / cellHeight)
        var index = i + columns * j
        
        index = index >= 0 ? index : 0
        index = index < palette.count ? index : palette.count - 1
        
        return UIColor(netHex: palette[index])
    }
    
    func getPointForColor(color:UIColor) -> CGPoint
    {
        var hue:CGFloat=0;
        var saturation:CGFloat=0;
        var brightness:CGFloat=0;
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil);
        
        var yPos:CGFloat = 0
        let halfHeight = (self.bounds.height / 2)
        
        if (brightness >= 0.99) {
            let percentageY = powf(Float(saturation), 1.0 / saturationExponentTop)
            yPos = CGFloat(percentageY) * halfHeight
        } else {
            //use brightness to get Y
            yPos = halfHeight + halfHeight * (1.0 - brightness)
        }
        
        let xPos = hue * self.bounds.width
        
        return CGPoint(x: xPos, y: yPos)
    }
    
    func touchedColor(_ gestureRecognizer: UILongPressGestureRecognizer)
    {
        let point = gestureRecognizer.location(in: self)
        let color = getColorAtPoint(point: point)
        
        let state = gestureRecognizer.state
        
        if state == .ended {
            self.delegate?.ColorColorPickerTouched(sender: self, color: color, point: point, state: state)
            zoomedPreview.isHidden = true
        }
        else {
            let px = point.x > self.frame.width / 2 ? point.x - previewSize * 2 : point.x + previewSize * 2
            var py = point.y > previewSize ? point.y - 20 : 20
            py = py < self.frame.height - previewSize ? py : self.frame.height - previewSize
            zoomedPreview.backgroundColor = color
            zoomedPreview.isHidden = false
            zoomedPreview.frame.origin.x = px
            zoomedPreview.frame.origin.y = py
        }
    }
}

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int)
    {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

internal protocol ColorPickerDelegate: class
{
    func ColorColorPickerTouched(sender:ColorPicker, color:UIColor, point:CGPoint, state:UIGestureRecognizerState)
}

