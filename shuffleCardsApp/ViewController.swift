import UIKit




class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var DeckId : String? = ""
    var finalCardDeck: CardResponse?
    var arrayTempCard : [UIImageView] = []
    var tempCard : UIImageView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDeackId()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    @IBAction func shuffleCards(_ sender: Any) {
        loadDeackId()
        arrayTempCard = []
    }
}
    


    

extension ViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  finalCardDeck?.cards.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionView", for: indexPath) as! CustomCollectionViewCell
        if let url = URL(string: finalCardDeck?.cards[indexPath.row].image ?? ""){
            cell.cardImage.load(url: url)
            self.arrayTempCard.append(cell.cardImage)
        }
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tempCard = arrayTempCard[indexPath.row]
        performSegue(withIdentifier: "GoToViewCardViewController", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToViewCardViewController",
            let destination = segue.destination as? CardViewController
             {
              destination.cardViewController = self.tempCard?.image
           
        }
        
        
    }
    
}

extension ViewController {
    
    func loadDeackId() {
        let urlStr = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        guard let url = URL(string: urlStr) else { return }
        
        NetworkManager.shared.get( DeckReponse.self, from: url ) { result in
            
            switch result {
                
            case .success(let deckResponse):
                self.DeckId = deckResponse.deck_id
                self.loadDeckImage()
                
            case .failure(let error):
                print(error)
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    print("OK")
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func loadDeckImage(){
        let urlStr = "https://deckofcardsapi.com/api/deck/\(self.DeckId ?? "")/draw/?count=52"
        guard let url = URL(string: urlStr) else { return }
        
        NetworkManager.shared.get( CardResponse.self, from: url ) { result in
            
            switch result {
                
            case .success(let cardDeck):
                self.finalCardDeck = cardDeck
                self.collectionView.reloadData()
                
                
            case .failure(let error):
                print(error)
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    print("OK")
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        
    
    }
}

extension UIImageView{
    
    func load(url: URL){
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
            
        }
        
    }
}


