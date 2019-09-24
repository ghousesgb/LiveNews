//
//  NewsHeadlines.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsHeadlinesModel = try NewsHeadlinesModel(json)

import Foundation

// MARK: - NewsHeadlinesModel
class NewsHeadlinesModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?

    init(status: String?, totalResults: Int?, articles: [Article]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: NewsHeadlinesModel convenience initializers and mutators

extension NewsHeadlinesModel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(NewsHeadlinesModel.self, from: data)
        self.init(status: me.status, totalResults: me.totalResults, articles: me.articles)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        status: String?? = nil,
        totalResults: Int?? = nil,
        articles: [Article]?? = nil
    ) -> NewsHeadlinesModel {
        return NewsHeadlinesModel(
            status: status ?? self.status,
            totalResults: totalResults ?? self.totalResults,
            articles: articles ?? self.articles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Article
class Article: Codable {
    let source: Source?
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription
        case url, urlToImage, publishedAt, content
    }

    init(source: Source?, author: String?, title: String?, articleDescription: String?, url: String?, urlToImage: String?, publishedAt: Date?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

// MARK: Article convenience initializers and mutators

extension Article {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Article.self, from: data)
        self.init(source: me.source, author: me.author, title: me.title, articleDescription: me.articleDescription, url: me.url, urlToImage: me.urlToImage, publishedAt: me.publishedAt, content: me.content)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        source: Source?? = nil,
        author: String?? = nil,
        title: String?? = nil,
        articleDescription: String?? = nil,
        url: String?? = nil,
        urlToImage: String?? = nil,
        publishedAt: Date?? = nil,
        content: String?? = nil
    ) -> Article {
        return Article(
            source: source ?? self.source,
            author: author ?? self.author,
            title: title ?? self.title,
            articleDescription: articleDescription ?? self.articleDescription,
            url: url ?? self.url,
            urlToImage: urlToImage ?? self.urlToImage,
            publishedAt: publishedAt ?? self.publishedAt,
            content: content ?? self.content
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Source
class Source: Codable {
    let id: String?
    let name: String?

    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: Source convenience initializers and mutators

extension Source {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Source.self, from: data)
        self.init(id: me.id, name: me.name)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        name: String?? = nil
    ) -> Source {
        return Source(
            id: id ?? self.id,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
