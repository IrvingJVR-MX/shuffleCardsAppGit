import UIKit

class CardViewController: UIViewController {
    
    var cardViewController: UIImage!
    @IBOutlet weak var cardViewTwo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cardViewTwo.image = cardViewController
       
    }
    

}
