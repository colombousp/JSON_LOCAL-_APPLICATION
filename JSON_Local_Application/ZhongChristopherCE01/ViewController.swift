
//  ViewController.swift
//  ZhongChristopherCE01
//
//  Created by Christopher Zhong on 11/1/19.
//  Copyright © 2019 Christopher Zhong. All rights reserved.
//

import UIKit

///The application checks for clothing sizes. If available the button will be blue. It will also tell users whether the item is on sale or not. Also, it will tell users the limit per person.

class ViewController: UIViewController {

    //store employees array. at the moment its empty
    var clothings: [Clothing] = []
    //keep track of clothing
    var element: Int = 0
    //present the details of the clothing
    @IBOutlet weak var ClothingName: UILabel!
    @IBOutlet weak var OnSaleStatus: UILabel!
    @IBOutlet weak var Limit: UILabel!
    
    //used to set clothing size availability
    @IBOutlet weak var Text3XS: UIButton!
    @IBOutlet weak var Text2XS: UIButton!
    @IBOutlet weak var TextXS: UIButton!
    @IBOutlet weak var TextS: UIButton!
    @IBOutlet weak var TextM: UIButton!
    @IBOutlet weak var TextL: UIButton!
    @IBOutlet weak var TextXL: UIButton!
    @IBOutlet weak var Text2XL: UIButton!
    @IBOutlet weak var Text3XL: UIButton!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //get access to the json file
        if let path = Bundle.main.path(forResource: "ClothingSizes", ofType: ".json"){
            
            //url path
            let url = URL(fileURLWithPath: path)
            
            //create object and cast it to an array with any types
            do{
                let data = try Data.init(contentsOf: url)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                ParseObject(jsonObject: jsonObj)
                //by default first element
                ClothingName.text = clothings[0].type
                CheckAvailability(clothing: clothings[0])
            }
            //print error if fails to do
            catch{                print(error.localizedDescription)
            }
        }
    }
    //parse json objects
    func ParseObject(jsonObject: [Any]?){
        if let jsonObj = jsonObject{
            for clothing in jsonObj{
                //setting to correct varaible
                guard let object = clothing as? [String: Any],
                    let type = object["type"] as? String,
                    let sizes = object["sizes"] as? [String],
                    let limit = object["limit"] as? Int,
                    let onsale = object["onsale"] as? Bool
                    else{return}
                //create object and add to array
                let e = Clothing(type: type, sizes: sizes, limit: limit, salestatus: onsale)
                clothings.append(e)
            }
        }
    }

    //set all buttons size to false. All sizes are not available.
    func SetButtonFalse(){
        Text3XS.isEnabled = false;
        Text2XS.isEnabled = false;
        TextXS.isEnabled = false;
        TextS.isEnabled = false;
        TextM.isEnabled = false;
        TextL.isEnabled = false;
        TextXL.isEnabled = false;
        Text2XL.isEnabled = false;
        Text3XL.isEnabled = false;
    }
    //Check for available sizes
    func CheckAvailability(clothing : Clothing){
 
        let type  = clothing.type
        ClothingName.text = type
        let sizes: [String] = clothing.sizes
        let limit: Int = clothing.limit
        let onsale = clothing.salestatus
        if onsale == true{
            OnSaleStatus.text = "On Sale"
        }
        if onsale == false{
            OnSaleStatus.text = " "
        }
        
        Limit.text = "Limit is \(limit) per customer."
        //setting everything unavaialbe
        SetButtonFalse()
        //for loop will check if sizes is avaialable for the clothing.
        for i in sizes{
            if i == "3XS"{
                Text3XS.isEnabled = true;
            }
            if i == "2XS"{
                Text2XS.isEnabled = true;
            }
            if i == "XS"{
                TextXS.isEnabled = true;
            }
            if i == "S"{
                TextS.isEnabled = true;
            }
            if i == "M"{
                TextM.isEnabled = true;
            }
            if i == "L"{
                TextL.isEnabled = true;
            }
            if i == "XL"{
                TextXL.isEnabled = true;
            }
            if i == "2XL"{
                Text2XL.isEnabled = true;
            }
            if i == "3XL"{
                Text3XL.isEnabled = true;
            }
        }
    }
    
    //goes to previous element in the clothing array
    @IBAction func PreviousButton(_ sender: UIButton) {
        //making sure not out of bound
        if element > 0 && element < 10{
            element = element - 1
            CheckAvailability(clothing: clothings[element])
        }
        //if already at first element then goes to last one
        else{
            element = 9
            CheckAvailability(clothing: clothings[element])
        }
    }
    //goes to next element in the clothing array
    @IBAction func NextButton(_ sender: UIButton) {
        //making sure not out of bound
        if element > -1 && element < 9{
            element = element + 1
            CheckAvailability(clothing: clothings[element])
        }
        //if at limit then goes back to first element
        else{
            element = 0
            CheckAvailability(clothing: clothings[element])
        }
    }
}

