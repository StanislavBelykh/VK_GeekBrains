import UIKit
struct Users {
    var list = [
        User(name: "Cheburator1", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator2", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator3", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator4", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator5", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"])

    ]
    
    
    func getSortedUser(for users: [User], searchText: String?) -> [Character:[User]]{
        let filteredUsers: [User]
        
        if let text = searchText?.lowercased() {
            filteredUsers = users.filter{ $0.name.contains(text)}
        } else {
            filteredUsers = users
        }
        let sortedUsers = Dictionary.init(grouping: filteredUsers) { $0.name.lowercased().first! }
            .mapValues{ $0.sorted{ $0.name.lowercased() < $1.name.lowercased() } }
        

        return sortedUsers
    }
}

struct User {
    let name: String
    let avatar: String
    let image: [String]
}


let users = Users()

users.getSortedUser(for: users.list, searchText: "c")

