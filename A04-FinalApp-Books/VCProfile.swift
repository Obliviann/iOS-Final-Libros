//
//  VCProfile.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 13/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit

class VCProfile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func temp(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc!, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
