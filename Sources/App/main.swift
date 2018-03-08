import Vapor
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider)
drop.preparations += Phrase.self

(drop.view as? LeafRenderer)?.stem.cache = nil

let test = TestController()
test.addRoutes(to: drop)

let history = HistoryController()
history.addRoutes(drop: drop)

let welcome = WelcomeController()
welcome.addRoutes(drop: drop)

drop.run()
