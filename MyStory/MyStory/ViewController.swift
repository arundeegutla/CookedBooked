//
//  ViewController.swift
//  MyStory
//
//  Created by CHENGTAO on 2/25/23.
//

import UIKit

class ViewController: UIViewController {
    
    // image and label text data for detail screen
    let earlyLife = ContextItem(image: UIImage(named: "Erlangen city")!, text: "Georg Simon Ohm was born into a Protestant family in Erlangen, Brandenburg-Bayreuth (then part of the Holy Roman Empire), son to locksmith Johann Wolfgang Ohm, and Maria Elizabeth Beck, daughter of a tailor in Erlangen. From early childhood, Georg and Martin were taught by their father who brought them to a high standard in mathematics, physics, chemistry and philosophy. Georg Simon attended Erlangen Gymnasium from age eleven to fifteen where he received little in the area of scientific training, which sharply contrasted with the inspired instruction that both Georg and Martin received from their father. This characteristic made the Ohms bear a resemblance to the Bernoulli family, as noted by Karl Christian von Langsdorf, a professor at the University of Erlangen.")
    
    let university = ContextItem(image: UIImage(named: "Erlangen University")!, text: "Georg Ohm's father, concerned that his son was wasting his educational opportunity, sent Ohm to Switzerland. There in September 1806 Ohm accepted a position as a mathematics teacher in a school in Gottstadt bei Nidau.\nKarl Christian von Langsdorf left the University of Erlangen in early 1809 to take up a post in the University of Heidelberg. Ohm wanted to restart his mathematical studies with Langsdorf in Heidelberg. Langsdorf, however, advised Ohm to pursue mathematical studies on his own, and suggested that Ohm read works of Euler, Laplace and Lacroix. Rather reluctantly Ohm took his advice but he left his teaching post in Gottstatt Monastery in March 1809 to become a private tutor in Neuchâtel. For two years he carried out his duties as a tutor while he followed Langsdorf's advice and continued his private study of mathematics. Then in April 1811 he returned to the University of Erlangen.")
    
    let ohmsLaw = ContextItem(image: UIImage(named: "Ohm's law")!, text: " Ohm's law first appeared in the famous book Die galvanische Kette, mathematisch bearbeitet (The Galvanic Circuit Investigated Mathematically) (1827) in which he gave his complete theory of electricity. In this work, he stated his law for electromotive force acting between the extremities of any part of a circuit is the product of the strength of the current, and the resistance of that part of the circuit. It states that the current through a conductor between two points is directly proportional to the voltage across the two points. Introducing the constant of proportionality, the resistance,[1] one arrives at the usual mathematical equation that describes this relationship.")
    
    // Array for storing Dinosaurs
    var contextItems: [ContextItem] = []
    
    @IBOutlet weak var earlyLifeView: UIView!
    @IBOutlet weak var universityView: UIView!
    @IBOutlet weak var OhmsLawView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        contextItems = [earlyLife, university, ohmsLaw]
        
        designUIView(Container: earlyLifeView)
        designUIView(Container: universityView)
        designUIView(Container: OhmsLawView)
        
    }
    
    
    @IBAction func didTappedDetail(_ sender: UITapGestureRecognizer) {
        
        if let tappedView = sender.view {
            performSegue(withIdentifier: "myStory", sender: tappedView)
        }
        
    }
    
    
    func designUIView(Container: UIView) {
        Container.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        Container.layer.shadowOpacity = 1.0
        Container.layer.shadowRadius = 0.0
        Container.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        Container.layer.masksToBounds = true
        Container.layer.cornerRadius = 15
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myStory",
           let tappedView = sender as? UIView,
           let detailViewController = segue.destination as? DetailViewController {
            if tappedView.tag == 0 {
                detailViewController.contextItem = contextItems[0]
            } else if tappedView.tag == 1 {
                detailViewController.contextItem = contextItems[1]
            } else if tappedView.tag == 2 {
                detailViewController.contextItem = contextItems[2]
            } else {
                print("no context item was tapped, please check your selection.")
            }
        }
    }
    

}

