import Vapor
import HTTP
import VaporPostgreSQL

final class TestController
{
    func addRoutes(to drop: Droplet)
    {
        drop.get("all", handler: all)
        drop.get("version", handler: version)
        drop.get("add", handler: add)
        drop.post("model", handler: model)
    }
    
    func version(request: Request) throws -> ResponseRepresentable
    {
        if let db = drop.database?.driver as? PostgreSQLDriver
        {
            let version = try db.raw("SELECT version()")
            return try JSON(node: version)
        }
        else
        {
            return "No db connection"
        }
    }
    
    func all(request: Request) throws -> ResponseRepresentable
    {
        return try Phrase.all().makeNode().converted(to: JSON.self)
    }
    
    func add(request: Request) throws -> ResponseRepresentable
    {
        var phrase = Phrase(content: "Shahin")
        try phrase.save()
        return try JSON(node: Phrase.all().makeNode())
    }
    
    func model(request: Request) throws -> ResponseRepresentable
    {
        let phrase = Phrase(content: "Shahin")
        return try phrase.makeJSON()
    }
}
