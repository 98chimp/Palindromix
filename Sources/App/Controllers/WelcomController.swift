import Vapor
import HTTP
import VaporPostgreSQL

final class WelcomeController
{
    func addRoutes(drop: Droplet)
    {
        drop.get(handler: welcomeView)
        drop.post(handler: addPhrase)
    }
    
    func welcomeView(request: Request) throws -> ResponseRepresentable
    {
        return try drop.view.make("index")
    }
    
    func addPhrase(request: Request) throws -> ResponseRepresentable
    {
        guard let content = request.data["content"]?.string else
        {
            throw Abort.badRequest
        }
        var phrase = Phrase(content: content)
        try phrase.save()
        
        let parameters = try Node(node: [
            "phrase": phrase,
            ])
        return try drop.view.make("index", parameters)
    }
}

extension Request
{
    func phrase() throws -> Phrase
    {
        guard let json = json else { throw Abort.badRequest }
        return try Phrase(node: json)
    }
}
