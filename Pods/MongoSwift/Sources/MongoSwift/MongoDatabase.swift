import mongoc

/// Options to use when running a command against a `MongoDatabase`.
public struct RunCommandOptions: Encodable {
    /// A session to associate with this operation
    public let session: ClientSession?

    /// An optional `ReadConcern` to use for this operation
    public let readConcern: ReadConcern?

    /// An optional `ReadPreference` to use for this operation
    public let readPreference: ReadPreference?

    /// An optional WriteConcern to use for this operation
    public let writeConcern: WriteConcern?

    /// Convenience initializer allowing session to be omitted or optional
    public init(readConcern: ReadConcern? = nil,
                readPreference: ReadPreference? = nil,
                session: ClientSession? = nil,
                writeConcern: WriteConcern? = nil) {
        self.readConcern = readConcern
        self.readPreference = readPreference
        self.session = session
        self.writeConcern = writeConcern
    }

    private enum CodingKeys: String, CodingKey {
        // TODO: Encode ClientSession as "sessionId" (see: SWIFT-28)
        case readConcern, writeConcern
    }
}

/// Options to use when executing a `listCollections` command on a `MongoDatabase`.
public struct ListCollectionsOptions: Encodable {
    /// A filter to match collections against
    public let filter: Document?

    /// The batchSize for the returned cursor
    public let batchSize: Int?

    /// A session to associate with this operation
    public let session: ClientSession?

    /// Convenience initializer allowing any/all parameters to be omitted or optional
    public init(batchSize: Int? = nil, filter: Document? = nil, session: ClientSession? = nil) {
        self.batchSize = batchSize
        self.filter = filter
        self.session = session
    }
}

/// Options to use when executing a `createCollection` command on a `MongoDatabase`.
public struct CreateCollectionOptions: Encodable, CodingStrategyProvider {
    /// Indicates whether this will be a capped collection
    public let capped: Bool?

    /// Whether or not this collection will automatically generate an index on _id
    public let autoIndexId: Bool?

    /// Maximum size, in bytes, of this collection (if capped)
    public let size: Int64?

    /// Maximum number of documents allowed in the collection (if capped)
    public let max: Int64?

    /// Determine which storage engine to use
    public let storageEngine: Document?

    /// What validator should be used for the collection
    public let validator: Document?

    /// Determines how strictly MongoDB applies the validation rules to existing documents during an update
    public let validationLevel: String?

    /// Determines whether to error on invalid documents or just warn about the violations
    /// but allow invalid documents to be inserted
    public let validationAction: String?

    /// Allows users to specify a default configuration for indexes when creating a collection
    public let indexOptionDefaults: Document?

    /// The name of the source collection or view from which to create the view
    public let viewOn: String?

    /// Specifies the default collation for the collection
    public let collation: Document?

    /// A session to associate with this operation
    public let session: ClientSession?

    /// A write concern to use when executing this command. To set a read or write concern
    /// for the collection itself, retrieve the collection using `MongoDatabase.collection`.
    public let writeConcern: WriteConcern?

    /// Specifies the `DateCodingStrategy` to use for BSON encoding/decoding operations performed by this collection.
    /// It is the responsibility of the user to ensure that any `Date`s already stored in this collection can be
    /// decoded using this strategy.
    public let dateCodingStrategy: DateCodingStrategy?

    /// Specifies the `UUIDCodingStrategy` to use for BSON encoding/decoding operations performed by this collection.
    /// It is the responsibility of the user to ensure that any `UUID`s already stored in this collection can be
    /// decoded using this strategy.
    public let uuidCodingStrategy: UUIDCodingStrategy?

    /// Specifies the `DataCodingStrategy` to use for BSON encoding/decoding operations performed by this collection.
    /// It is the responsibility of the user to ensure that any `Data`s already stored in this collection can be
    /// decoded using this strategy.
    public let dataCodingStrategy: DataCodingStrategy?

    private enum CodingKeys: String, CodingKey {
        case capped, autoIndexId, size, max, storageEngine, validator, validationLevel, validationAction,
             indexOptionDefaults, viewOn, collation, session, writeConcern
    }

    /// Convenience initializer allowing any/all parameters to be omitted or optional
    public init(autoIndexId: Bool? = nil,
                capped: Bool? = nil,
                collation: Document? = nil,
                indexOptionDefaults: Document? = nil,
                max: Int64? = nil,
                session: ClientSession? = nil,
                size: Int64? = nil,
                storageEngine: Document? = nil,
                validationAction: String? = nil,
                validationLevel: String? = nil,
                validator: Document? = nil,
                viewOn: String? = nil,
                writeConcern: WriteConcern? = nil,
                dateCodingStrategy: DateCodingStrategy? = nil,
                uuidCodingStrategy: UUIDCodingStrategy? = nil,
                dataCodingStrategy: DataCodingStrategy? = nil) {
        self.autoIndexId = autoIndexId
        self.capped = capped
        self.collation = collation
        self.indexOptionDefaults = indexOptionDefaults
        self.max = max
        self.session = session
        self.size = size
        self.storageEngine = storageEngine
        self.validationAction = validationAction
        self.validationLevel = validationLevel
        self.validator = validator
        self.viewOn = viewOn
        self.writeConcern = writeConcern
        self.dateCodingStrategy = dateCodingStrategy
        self.uuidCodingStrategy = uuidCodingStrategy
        self.dataCodingStrategy = dataCodingStrategy
    }
}

/// Options to set on a retrieved `MongoCollection`.
public struct CollectionOptions: CodingStrategyProvider {
    /// A read concern to set on the returned collection. If one is not specified,
    /// the collection will inherit the database's read concern.
    public let readConcern: ReadConcern?

    /// A read preference to set on the returned collection. If one is not
    /// specified, the collection will inherit the database's read preference.
    public let readPreference: ReadPreference?

    /// A write concern to set on the returned collection. If one is not specified,
    /// the collection will inherit the database's write concern.
    public let writeConcern: WriteConcern?

    /// Specifies the `DateCodingStrategy` to use for BSON encoding/decoding operations performed by this collection.
    /// It is the responsibility of the user to ensure that any `Date`s already stored in this collection can be
    /// decoded using this strategy.
    public let dateCodingStrategy: DateCodingStrategy?

    /// Specifies the `UUIDCodingStrategy` to use for BSON encoding/decoding operations performed by this collection.
    /// It is the responsibility of the user to ensure that any `UUID`s already stored in this collection can be
    /// decoded using this strategy.
    public let uuidCodingStrategy: UUIDCodingStrategy?

    /// Specifies the `DataCodingStrategy` to use for BSON encoding/decoding operations performed by this collection.
    /// It is the responsibility of the user to ensure that any `Data`s already stored in this collection can be
    /// decoded using this strategy.
    public let dataCodingStrategy: DataCodingStrategy?

    /// Convenience initializer allowing any/all arguments to be omitted or optional
    public init(readConcern: ReadConcern? = nil,
                readPreference: ReadPreference? = nil,
                writeConcern: WriteConcern? = nil,
                dateCodingStrategy: DateCodingStrategy? = nil,
                uuidCodingStrategy: UUIDCodingStrategy? = nil,
                dataCodingStrategy: DataCodingStrategy? = nil) {
        self.readConcern = readConcern
        self.readPreference = readPreference
        self.writeConcern = writeConcern
        self.dateCodingStrategy = dateCodingStrategy
        self.uuidCodingStrategy = uuidCodingStrategy
        self.dataCodingStrategy = dataCodingStrategy
    }
}

/// A MongoDB Database
public class MongoDatabase {
    private var _database: OpaquePointer?
    private var _client: MongoClient

    /// Encoder used by this database for BSON conversions.
    /// This encoder's options are inherited by collections derived from this database.
    public let encoder: BSONEncoder

    /// Decoder whose options are inherited by collections derived from this database.
    public let decoder: BSONDecoder

    /// The name of this database.
    public var name: String {
        return String(cString: mongoc_database_get_name(self._database))
    }

    /// The `ReadConcern` set on this database, or `nil` if one is not set.
    public var readConcern: ReadConcern? {
        // per libmongoc docs, we don't need to handle freeing this ourselves
        let rc = ReadConcern(from: mongoc_database_get_read_concern(self._database))
        return rc.isDefault ? nil : rc
    }

    /// The `ReadPreference` set on this database
    public var readPreference: ReadPreference? {
        return ReadPreference(from: mongoc_collection_get_read_prefs(self._database))
    }

    /// The `WriteConcern` set on this database, or `nil` if one is not set.
    public var writeConcern: WriteConcern? {
        // per libmongoc docs, we don't need to handle freeing this ourselves
        let wc = WriteConcern(from: mongoc_database_get_write_concern(self._database))
        return wc.isDefault ? nil : wc
    }

    /// Initializes a new `MongoDatabase` instance, not meant to be instantiated directly.
    internal init(fromDatabase database: OpaquePointer,
                  withClient client: MongoClient,
                  withEncoder encoder: BSONEncoder,
                  withDecoder decoder: BSONDecoder) {
        self._database = database
        self._client = client
        self.encoder = encoder
        self.decoder = decoder
    }

    /// Cleans up internal state.
    deinit {
        guard let database = self._database else {
            return
        }
        mongoc_database_destroy(database)
        self._database = nil
    }

    /// Drops this database.
    /// - Throws:
    ///   - `ServerError.commandError` if an error occurs that prevents the command from executing.
    public func drop() throws {
        var error = bson_error_t()
        guard mongoc_database_drop(self._database, &error) else {
            throw parseMongocError(error)
        }
    }

    /**
     * Access a collection within this database.
     *
     * - Parameters:
     *   - name: the name of the collection to get
     *   - options: options to set on the returned collection
     *
     * - Returns: the requested `MongoCollection<Document>`
     */
    public func collection(_ name: String, options: CollectionOptions? = nil) -> MongoCollection<Document> {
        return self.collection(name, withType: Document.self, options: options)
    }

    /**
     * Access a collection within this database, and associates the specified `Codable` type `T` with the
     * returned `MongoCollection`. This association only exists in the context of this particular
     * `MongoCollection` instance.
     *
     * - Parameters:
     *   - name: the name of the collection to get
     *   - options: options to set on the returned collection
     *
     * - Returns: the requested `MongoCollection<T>`
     */
    public func collection<T: Codable>(_ name: String,
                                       withType: T.Type,
                                       options: CollectionOptions? = nil) -> MongoCollection<T> {
        guard let collection = mongoc_database_get_collection(self._database, name) else {
            fatalError("Could not get collection '\(name)'")
        }

        if let rc = options?.readConcern {
            mongoc_collection_set_read_concern(collection, rc._readConcern)
        }

        if let rp = options?.readPreference {
            mongoc_collection_set_read_prefs(collection, rp._readPreference)
        }

        if let wc = options?.writeConcern {
            mongoc_collection_set_write_concern(collection, wc._writeConcern)
        }

        let encoder = BSONEncoder(copies: self.encoder, options: options)
        let decoder = BSONDecoder(copies: self.decoder, options: options)

        return MongoCollection(
                fromCollection: collection,
                withClient: self._client,
                withEncoder: encoder,
                withDecoder: decoder
        )
    }

    /**
     * Creates a collection in this database with the specified options.
     *
     * - Parameters:
     *   - name: a `String`, the name of the collection to create
     *   - options: Optional `CreateCollectionOptions` to use for the collection
     *
     * - Returns: the newly created `MongoCollection<Document>`
     */
    public func createCollection(_ name: String,
                                 options: CreateCollectionOptions? = nil) throws -> MongoCollection<Document> {
        return try self.createCollection(name, withType: Document.self, options: options)
    }

    /**
     * Creates a collection in this database with the specified options, and associates the
     * specified `Codable` type `T` with the returned `MongoCollection`. This association only
     * exists in the context of this particular `MongoCollection` instance.
     *
     *
     * - Parameters:
     *   - name: a `String`, the name of the collection to create
     *   - options: Optional `CreateCollectionOptions` to use for the collection
     *
     * - Returns: the newly created `MongoCollection<T>`
     *
     * - Throws:
     *   - `ServerError.commandError` if an error occurs that prevents the command from executing.
     *   - `UserError.invalidArgumentError` if the options passed in form an invalid combination.
     *   - `EncodingError` if an error occurs while encoding the options to BSON.
     */
    public func createCollection<T: Codable>(_ name: String,
                                             withType: T.Type,
                                             options: CreateCollectionOptions? = nil) throws -> MongoCollection<T> {
        let opts = try self.encoder.encode(options)
        var error = bson_error_t()

        guard let collection = mongoc_database_create_collection(self._database, name, opts?.data, &error) else {
            throw parseMongocError(error)
        }

        let encoder = BSONEncoder(copies: self.encoder, options: options)
        let decoder = BSONDecoder(copies: self.decoder, options: options)

        return MongoCollection(
                fromCollection: collection,
                withClient: self._client,
                withEncoder: encoder,
                withDecoder: decoder
        )
    }

    /**
     * Lists all the collections in this database.
     *
     * - Parameters:
     *   - filter: a `Document`, optional criteria to filter results by
     *   - options: Optional `ListCollectionsOptions` to use when executing this command
     *
     * - Returns: a `MongoCursor` over an array of collections
     *
     * - Throws: A `userError.invalidArgumentError` if the options passed are an invalid combination.
     */
    public func listCollections(options: ListCollectionsOptions? = nil) throws -> MongoCursor<Document> {
        let opts = try self.encoder.encode(options)
        guard let collections = mongoc_database_find_collections_with_opts(self._database, opts?.data) else {
            fatalError("Couldn't get cursor from the server")
        }

        return try MongoCursor(fromCursor: collections, withClient: self._client, withDecoder: self.decoder)
    }

    /**
     * Issues a MongoDB command against this database.
     *
     * - Parameters:
     *   - command: a `Document` containing the command to issue against the database
     *   - options: Optional `RunCommandOptions` to use when executing this command
     *
     * - Returns: a `Document` containing the server response for the command
     *
     * - Throws:
     *   - `UserError.invalidArgumentError` if `requests` is empty.
     *   - `ServerError.writeError` if any error occurs while the command was performing a write.
     *   - `ServerError.commandError` if an error occurs that prevents the command from being performed.
     *   - `EncodingError` if an error occurs while encoding the options to BSON.
     */
    @discardableResult
    public func runCommand(_ command: Document, options: RunCommandOptions? = nil) throws -> Document {
        let rp = options?.readPreference?._readPreference
        let opts = try self.encoder.encode(options)
        let reply = Document()
        var error = bson_error_t()
        guard mongoc_database_command_with_opts(self._database, command.data, rp, opts?.data, reply.data, &error) else {
            throw getErrorFromReply(bsonError: error, from: reply)
        }
        return reply
    }
}
