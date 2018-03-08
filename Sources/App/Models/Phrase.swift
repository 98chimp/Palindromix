import Vapor
import Fluent
import Foundation

final class Phrase: Model
{
    var id: Node?
    var content: String
    var isPalindromic: Bool = false
    var exists: Bool = false
    
    init(content: String)
    {
        self.id = nil
        self.content = content
        self.isPalindromic = self.content.isPalindromic
    }
    
    init(node: Node, in context: Context) throws
    {
        id = try node.extract("id")
        content = try node.extract("content")
        isPalindromic = try node.extract("ispalindromic")
    }
    
    func makeNode(context: Context) throws -> Node
    {
        return try Node(node: [
            "id": id,
            "content": content,
            "ispalindromic": isPalindromic
            ])
    }
}

extension Phrase
{
    public convenience init?(from string: String) throws
    {
        self.init(content: string)
    }
}

extension Phrase: Preparation
{
    static func prepare(_ database: Database) throws
    {
        try database.create("phrases") { users in
            users.id()
            users.string("content")
            users.bool("ispalindromic")
        }
    }
    
    static func revert(_ database: Database) throws
    {
        try database.delete("phrases")
    }
}
