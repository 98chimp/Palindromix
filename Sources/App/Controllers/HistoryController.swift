import Vapor
import HTTP

final class HistoryController
{
    func addRoutes(drop: Droplet)
    {
        drop.get("history", handler: indexView)
    }

    func indexView(request: Request) throws -> ResponseRepresentable
    {
        let phrases = try Phrase.all().makeNode()
        let parameters = try Node(node: [
            "phrases": phrases,
            ])
        return try drop.view.make("history", parameters)
    }
}
