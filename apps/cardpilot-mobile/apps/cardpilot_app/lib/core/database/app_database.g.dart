// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalProfilesTable extends LocalProfiles
    with TableInfo<$LocalProfilesTable, LocalProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authUserIdMeta = const VerificationMeta(
    'authUserId',
  );
  @override
  late final GeneratedColumn<String> authUserId = GeneratedColumn<String>(
    'auth_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverUserIdMeta = const VerificationMeta(
    'serverUserId',
  );
  @override
  late final GeneratedColumn<String> serverUserId = GeneratedColumn<String>(
    'server_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accessModeMeta = const VerificationMeta(
    'accessMode',
  );
  @override
  late final GeneratedColumn<String> accessMode = GeneratedColumn<String>(
    'access_mode',
    aliasedName,
    false,
    check: () => accessMode.isIn(const ['guest', 'authenticated']),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bornDateAtMsMeta = const VerificationMeta(
    'bornDateAtMs',
  );
  @override
  late final GeneratedColumn<int> bornDateAtMs = GeneratedColumn<int>(
    'born_date_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _setupCompletedAtMsMeta =
      const VerificationMeta('setupCompletedAtMs');
  @override
  late final GeneratedColumn<int> setupCompletedAtMs = GeneratedColumn<int>(
    'setup_completed_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMsMeta = const VerificationMeta(
    'deletedAtMs',
  );
  @override
  late final GeneratedColumn<int> deletedAtMs = GeneratedColumn<int>(
    'deleted_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    check: () => syncStatus.isIn(const [
      'local_only',
      'pending',
      'synced',
      'failed',
      'conflict',
    ]),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local_only'),
  );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<int> serverVersion = GeneratedColumn<int>(
    'server_version',
    aliasedName,
    true,
    check: () =>
        serverVersion.isNull() |
        ComparableExpr(serverVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMsMeta = const VerificationMeta(
    'lastSyncedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAtMs = GeneratedColumn<int>(
    'last_synced_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    authUserId,
    serverUserId,
    accessMode,
    email,
    displayName,
    bornDateAtMs,
    setupCompletedAtMs,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('auth_user_id')) {
      context.handle(
        _authUserIdMeta,
        authUserId.isAcceptableOrUnknown(
          data['auth_user_id']!,
          _authUserIdMeta,
        ),
      );
    }
    if (data.containsKey('server_user_id')) {
      context.handle(
        _serverUserIdMeta,
        serverUserId.isAcceptableOrUnknown(
          data['server_user_id']!,
          _serverUserIdMeta,
        ),
      );
    }
    if (data.containsKey('access_mode')) {
      context.handle(
        _accessModeMeta,
        accessMode.isAcceptableOrUnknown(data['access_mode']!, _accessModeMeta),
      );
    } else if (isInserting) {
      context.missing(_accessModeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('born_date_at_ms')) {
      context.handle(
        _bornDateAtMsMeta,
        bornDateAtMs.isAcceptableOrUnknown(
          data['born_date_at_ms']!,
          _bornDateAtMsMeta,
        ),
      );
    }
    if (data.containsKey('setup_completed_at_ms')) {
      context.handle(
        _setupCompletedAtMsMeta,
        setupCompletedAtMs.isAcceptableOrUnknown(
          data['setup_completed_at_ms']!,
          _setupCompletedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('deleted_at_ms')) {
      context.handle(
        _deletedAtMsMeta,
        deletedAtMs.isAcceptableOrUnknown(
          data['deleted_at_ms']!,
          _deletedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at_ms')) {
      context.handle(
        _lastSyncedAtMsMeta,
        lastSyncedAtMs.isAcceptableOrUnknown(
          data['last_synced_at_ms']!,
          _lastSyncedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      authUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_user_id'],
      ),
      serverUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_user_id'],
      ),
      accessMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}access_mode'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      bornDateAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}born_date_at_ms'],
      ),
      setupCompletedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}setup_completed_at_ms'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      deletedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_ms'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version'],
      ),
      lastSyncedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at_ms'],
      ),
    );
  }

  @override
  $LocalProfilesTable createAlias(String alias) {
    return $LocalProfilesTable(attachedDatabase, alias);
  }
}

class LocalProfileRow extends DataClass implements Insertable<LocalProfileRow> {
  final String id;
  final String? authUserId;
  final String? serverUserId;
  final String accessMode;
  final String? email;
  final String displayName;
  final int? bornDateAtMs;
  final int? setupCompletedAtMs;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  final String syncStatus;
  final int? serverVersion;
  final int? lastSyncedAtMs;
  const LocalProfileRow({
    required this.id,
    this.authUserId,
    this.serverUserId,
    required this.accessMode,
    this.email,
    required this.displayName,
    this.bornDateAtMs,
    this.setupCompletedAtMs,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
    required this.syncStatus,
    this.serverVersion,
    this.lastSyncedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || authUserId != null) {
      map['auth_user_id'] = Variable<String>(authUserId);
    }
    if (!nullToAbsent || serverUserId != null) {
      map['server_user_id'] = Variable<String>(serverUserId);
    }
    map['access_mode'] = Variable<String>(accessMode);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || bornDateAtMs != null) {
      map['born_date_at_ms'] = Variable<int>(bornDateAtMs);
    }
    if (!nullToAbsent || setupCompletedAtMs != null) {
      map['setup_completed_at_ms'] = Variable<int>(setupCompletedAtMs);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    if (!nullToAbsent || deletedAtMs != null) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || serverVersion != null) {
      map['server_version'] = Variable<int>(serverVersion);
    }
    if (!nullToAbsent || lastSyncedAtMs != null) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs);
    }
    return map;
  }

  LocalProfilesCompanion toCompanion(bool nullToAbsent) {
    return LocalProfilesCompanion(
      id: Value(id),
      authUserId: authUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(authUserId),
      serverUserId: serverUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUserId),
      accessMode: Value(accessMode),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      displayName: Value(displayName),
      bornDateAtMs: bornDateAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(bornDateAtMs),
      setupCompletedAtMs: setupCompletedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(setupCompletedAtMs),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      deletedAtMs: deletedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtMs),
      syncStatus: Value(syncStatus),
      serverVersion: serverVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(serverVersion),
      lastSyncedAtMs: lastSyncedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAtMs),
    );
  }

  factory LocalProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProfileRow(
      id: serializer.fromJson<String>(json['id']),
      authUserId: serializer.fromJson<String?>(json['authUserId']),
      serverUserId: serializer.fromJson<String?>(json['serverUserId']),
      accessMode: serializer.fromJson<String>(json['accessMode']),
      email: serializer.fromJson<String?>(json['email']),
      displayName: serializer.fromJson<String>(json['displayName']),
      bornDateAtMs: serializer.fromJson<int?>(json['bornDateAtMs']),
      setupCompletedAtMs: serializer.fromJson<int?>(json['setupCompletedAtMs']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      deletedAtMs: serializer.fromJson<int?>(json['deletedAtMs']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      serverVersion: serializer.fromJson<int?>(json['serverVersion']),
      lastSyncedAtMs: serializer.fromJson<int?>(json['lastSyncedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'authUserId': serializer.toJson<String?>(authUserId),
      'serverUserId': serializer.toJson<String?>(serverUserId),
      'accessMode': serializer.toJson<String>(accessMode),
      'email': serializer.toJson<String?>(email),
      'displayName': serializer.toJson<String>(displayName),
      'bornDateAtMs': serializer.toJson<int?>(bornDateAtMs),
      'setupCompletedAtMs': serializer.toJson<int?>(setupCompletedAtMs),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'deletedAtMs': serializer.toJson<int?>(deletedAtMs),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'serverVersion': serializer.toJson<int?>(serverVersion),
      'lastSyncedAtMs': serializer.toJson<int?>(lastSyncedAtMs),
    };
  }

  LocalProfileRow copyWith({
    String? id,
    Value<String?> authUserId = const Value.absent(),
    Value<String?> serverUserId = const Value.absent(),
    String? accessMode,
    Value<String?> email = const Value.absent(),
    String? displayName,
    Value<int?> bornDateAtMs = const Value.absent(),
    Value<int?> setupCompletedAtMs = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    Value<int?> deletedAtMs = const Value.absent(),
    String? syncStatus,
    Value<int?> serverVersion = const Value.absent(),
    Value<int?> lastSyncedAtMs = const Value.absent(),
  }) => LocalProfileRow(
    id: id ?? this.id,
    authUserId: authUserId.present ? authUserId.value : this.authUserId,
    serverUserId: serverUserId.present ? serverUserId.value : this.serverUserId,
    accessMode: accessMode ?? this.accessMode,
    email: email.present ? email.value : this.email,
    displayName: displayName ?? this.displayName,
    bornDateAtMs: bornDateAtMs.present ? bornDateAtMs.value : this.bornDateAtMs,
    setupCompletedAtMs: setupCompletedAtMs.present
        ? setupCompletedAtMs.value
        : this.setupCompletedAtMs,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    deletedAtMs: deletedAtMs.present ? deletedAtMs.value : this.deletedAtMs,
    syncStatus: syncStatus ?? this.syncStatus,
    serverVersion: serverVersion.present
        ? serverVersion.value
        : this.serverVersion,
    lastSyncedAtMs: lastSyncedAtMs.present
        ? lastSyncedAtMs.value
        : this.lastSyncedAtMs,
  );
  LocalProfileRow copyWithCompanion(LocalProfilesCompanion data) {
    return LocalProfileRow(
      id: data.id.present ? data.id.value : this.id,
      authUserId: data.authUserId.present
          ? data.authUserId.value
          : this.authUserId,
      serverUserId: data.serverUserId.present
          ? data.serverUserId.value
          : this.serverUserId,
      accessMode: data.accessMode.present
          ? data.accessMode.value
          : this.accessMode,
      email: data.email.present ? data.email.value : this.email,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      bornDateAtMs: data.bornDateAtMs.present
          ? data.bornDateAtMs.value
          : this.bornDateAtMs,
      setupCompletedAtMs: data.setupCompletedAtMs.present
          ? data.setupCompletedAtMs.value
          : this.setupCompletedAtMs,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      deletedAtMs: data.deletedAtMs.present
          ? data.deletedAtMs.value
          : this.deletedAtMs,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      lastSyncedAtMs: data.lastSyncedAtMs.present
          ? data.lastSyncedAtMs.value
          : this.lastSyncedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProfileRow(')
          ..write('id: $id, ')
          ..write('authUserId: $authUserId, ')
          ..write('serverUserId: $serverUserId, ')
          ..write('accessMode: $accessMode, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('bornDateAtMs: $bornDateAtMs, ')
          ..write('setupCompletedAtMs: $setupCompletedAtMs, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    authUserId,
    serverUserId,
    accessMode,
    email,
    displayName,
    bornDateAtMs,
    setupCompletedAtMs,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProfileRow &&
          other.id == this.id &&
          other.authUserId == this.authUserId &&
          other.serverUserId == this.serverUserId &&
          other.accessMode == this.accessMode &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.bornDateAtMs == this.bornDateAtMs &&
          other.setupCompletedAtMs == this.setupCompletedAtMs &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.deletedAtMs == this.deletedAtMs &&
          other.syncStatus == this.syncStatus &&
          other.serverVersion == this.serverVersion &&
          other.lastSyncedAtMs == this.lastSyncedAtMs);
}

class LocalProfilesCompanion extends UpdateCompanion<LocalProfileRow> {
  final Value<String> id;
  final Value<String?> authUserId;
  final Value<String?> serverUserId;
  final Value<String> accessMode;
  final Value<String?> email;
  final Value<String> displayName;
  final Value<int?> bornDateAtMs;
  final Value<int?> setupCompletedAtMs;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int?> deletedAtMs;
  final Value<String> syncStatus;
  final Value<int?> serverVersion;
  final Value<int?> lastSyncedAtMs;
  final Value<int> rowid;
  const LocalProfilesCompanion({
    this.id = const Value.absent(),
    this.authUserId = const Value.absent(),
    this.serverUserId = const Value.absent(),
    this.accessMode = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.bornDateAtMs = const Value.absent(),
    this.setupCompletedAtMs = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalProfilesCompanion.insert({
    required String id,
    this.authUserId = const Value.absent(),
    this.serverUserId = const Value.absent(),
    required String accessMode,
    this.email = const Value.absent(),
    required String displayName,
    this.bornDateAtMs = const Value.absent(),
    this.setupCompletedAtMs = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accessMode = Value(accessMode),
       displayName = Value(displayName),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LocalProfileRow> custom({
    Expression<String>? id,
    Expression<String>? authUserId,
    Expression<String>? serverUserId,
    Expression<String>? accessMode,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<int>? bornDateAtMs,
    Expression<int>? setupCompletedAtMs,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? deletedAtMs,
    Expression<String>? syncStatus,
    Expression<int>? serverVersion,
    Expression<int>? lastSyncedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authUserId != null) 'auth_user_id': authUserId,
      if (serverUserId != null) 'server_user_id': serverUserId,
      if (accessMode != null) 'access_mode': accessMode,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (bornDateAtMs != null) 'born_date_at_ms': bornDateAtMs,
      if (setupCompletedAtMs != null)
        'setup_completed_at_ms': setupCompletedAtMs,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (deletedAtMs != null) 'deleted_at_ms': deletedAtMs,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (serverVersion != null) 'server_version': serverVersion,
      if (lastSyncedAtMs != null) 'last_synced_at_ms': lastSyncedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? authUserId,
    Value<String?>? serverUserId,
    Value<String>? accessMode,
    Value<String?>? email,
    Value<String>? displayName,
    Value<int?>? bornDateAtMs,
    Value<int?>? setupCompletedAtMs,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int?>? deletedAtMs,
    Value<String>? syncStatus,
    Value<int?>? serverVersion,
    Value<int?>? lastSyncedAtMs,
    Value<int>? rowid,
  }) {
    return LocalProfilesCompanion(
      id: id ?? this.id,
      authUserId: authUserId ?? this.authUserId,
      serverUserId: serverUserId ?? this.serverUserId,
      accessMode: accessMode ?? this.accessMode,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      bornDateAtMs: bornDateAtMs ?? this.bornDateAtMs,
      setupCompletedAtMs: setupCompletedAtMs ?? this.setupCompletedAtMs,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      deletedAtMs: deletedAtMs ?? this.deletedAtMs,
      syncStatus: syncStatus ?? this.syncStatus,
      serverVersion: serverVersion ?? this.serverVersion,
      lastSyncedAtMs: lastSyncedAtMs ?? this.lastSyncedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (authUserId.present) {
      map['auth_user_id'] = Variable<String>(authUserId.value);
    }
    if (serverUserId.present) {
      map['server_user_id'] = Variable<String>(serverUserId.value);
    }
    if (accessMode.present) {
      map['access_mode'] = Variable<String>(accessMode.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (bornDateAtMs.present) {
      map['born_date_at_ms'] = Variable<int>(bornDateAtMs.value);
    }
    if (setupCompletedAtMs.present) {
      map['setup_completed_at_ms'] = Variable<int>(setupCompletedAtMs.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (deletedAtMs.present) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<int>(serverVersion.value);
    }
    if (lastSyncedAtMs.present) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProfilesCompanion(')
          ..write('id: $id, ')
          ..write('authUserId: $authUserId, ')
          ..write('serverUserId: $serverUserId, ')
          ..write('accessMode: $accessMode, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('bornDateAtMs: $bornDateAtMs, ')
          ..write('setupCompletedAtMs: $setupCompletedAtMs, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    check: () => id.equals(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _installationIdMeta = const VerificationMeta(
    'installationId',
  );
  @override
  late final GeneratedColumn<String> installationId = GeneratedColumn<String>(
    'installation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeProfileIdMeta = const VerificationMeta(
    'activeProfileId',
  );
  @override
  late final GeneratedColumn<String> activeProfileId = GeneratedColumn<String>(
    'active_profile_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    installationId,
    activeProfileId,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('installation_id')) {
      context.handle(
        _installationIdMeta,
        installationId.isAcceptableOrUnknown(
          data['installation_id']!,
          _installationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installationIdMeta);
    }
    if (data.containsKey('active_profile_id')) {
      context.handle(
        _activeProfileIdMeta,
        activeProfileId.isAcceptableOrUnknown(
          data['active_profile_id']!,
          _activeProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      installationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installation_id'],
      )!,
      activeProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_profile_id'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingsRow extends DataClass implements Insertable<AppSettingsRow> {
  final int id;
  final String installationId;
  final String? activeProfileId;
  final int createdAtMs;
  final int updatedAtMs;
  const AppSettingsRow({
    required this.id,
    required this.installationId,
    this.activeProfileId,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['installation_id'] = Variable<String>(installationId);
    if (!nullToAbsent || activeProfileId != null) {
      map['active_profile_id'] = Variable<String>(activeProfileId);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      installationId: Value(installationId),
      activeProfileId: activeProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeProfileId),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory AppSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsRow(
      id: serializer.fromJson<int>(json['id']),
      installationId: serializer.fromJson<String>(json['installationId']),
      activeProfileId: serializer.fromJson<String?>(json['activeProfileId']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'installationId': serializer.toJson<String>(installationId),
      'activeProfileId': serializer.toJson<String?>(activeProfileId),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  AppSettingsRow copyWith({
    int? id,
    String? installationId,
    Value<String?> activeProfileId = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
  }) => AppSettingsRow(
    id: id ?? this.id,
    installationId: installationId ?? this.installationId,
    activeProfileId: activeProfileId.present
        ? activeProfileId.value
        : this.activeProfileId,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  AppSettingsRow copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      installationId: data.installationId.present
          ? data.installationId.value
          : this.installationId,
      activeProfileId: data.activeProfileId.present
          ? data.activeProfileId.value
          : this.activeProfileId,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsRow(')
          ..write('id: $id, ')
          ..write('installationId: $installationId, ')
          ..write('activeProfileId: $activeProfileId, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    installationId,
    activeProfileId,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsRow &&
          other.id == this.id &&
          other.installationId == this.installationId &&
          other.activeProfileId == this.activeProfileId &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingsRow> {
  final Value<int> id;
  final Value<String> installationId;
  final Value<String?> activeProfileId;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.installationId = const Value.absent(),
    this.activeProfileId = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String installationId,
    this.activeProfileId = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
  }) : installationId = Value(installationId),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<AppSettingsRow> custom({
    Expression<int>? id,
    Expression<String>? installationId,
    Expression<String>? activeProfileId,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (installationId != null) 'installation_id': installationId,
      if (activeProfileId != null) 'active_profile_id': activeProfileId,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? installationId,
    Value<String?>? activeProfileId,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      installationId: installationId ?? this.installationId,
      activeProfileId: activeProfileId ?? this.activeProfileId,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (installationId.present) {
      map['installation_id'] = Variable<String>(installationId.value);
    }
    if (activeProfileId.present) {
      map['active_profile_id'] = Variable<String>(activeProfileId.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('installationId: $installationId, ')
          ..write('activeProfileId: $activeProfileId, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }
}

class $MembershipsCacheTable extends MembershipsCache
    with TableInfo<$MembershipsCacheTable, MembershipCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembershipsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _maxCardsMeta = const VerificationMeta(
    'maxCards',
  );
  @override
  late final GeneratedColumn<int> maxCards = GeneratedColumn<int>(
    'max_cards',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxReceiptScansPerMonthMeta =
      const VerificationMeta('maxReceiptScansPerMonth');
  @override
  late final GeneratedColumn<int> maxReceiptScansPerMonth =
      GeneratedColumn<int>(
        'max_receipt_scans_per_month',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _maxCashbackCalculationsPerMonthMeta =
      const VerificationMeta('maxCashbackCalculationsPerMonth');
  @override
  late final GeneratedColumn<int> maxCashbackCalculationsPerMonth =
      GeneratedColumn<int>(
        'max_cashback_calculations_per_month',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _serverUpdatedAtMsMeta = const VerificationMeta(
    'serverUpdatedAtMs',
  );
  @override
  late final GeneratedColumn<int> serverUpdatedAtMs = GeneratedColumn<int>(
    'server_updated_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    check: () => ComparableExpr(datasetVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    maxCards,
    maxReceiptScansPerMonth,
    maxCashbackCalculationsPerMonth,
    serverUpdatedAtMs,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memberships_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<MembershipCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('max_cards')) {
      context.handle(
        _maxCardsMeta,
        maxCards.isAcceptableOrUnknown(data['max_cards']!, _maxCardsMeta),
      );
    }
    if (data.containsKey('max_receipt_scans_per_month')) {
      context.handle(
        _maxReceiptScansPerMonthMeta,
        maxReceiptScansPerMonth.isAcceptableOrUnknown(
          data['max_receipt_scans_per_month']!,
          _maxReceiptScansPerMonthMeta,
        ),
      );
    }
    if (data.containsKey('max_cashback_calculations_per_month')) {
      context.handle(
        _maxCashbackCalculationsPerMonthMeta,
        maxCashbackCalculationsPerMonth.isAcceptableOrUnknown(
          data['max_cashback_calculations_per_month']!,
          _maxCashbackCalculationsPerMonthMeta,
        ),
      );
    }
    if (data.containsKey('server_updated_at_ms')) {
      context.handle(
        _serverUpdatedAtMsMeta,
        serverUpdatedAtMs.isAcceptableOrUnknown(
          data['server_updated_at_ms']!,
          _serverUpdatedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MembershipCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MembershipCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      maxCards: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_cards'],
      ),
      maxReceiptScansPerMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_receipt_scans_per_month'],
      ),
      maxCashbackCalculationsPerMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_cashback_calculations_per_month'],
      ),
      serverUpdatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_updated_at_ms'],
      ),
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $MembershipsCacheTable createAlias(String alias) {
    return $MembershipsCacheTable(attachedDatabase, alias);
  }
}

class MembershipCacheRow extends DataClass
    implements Insertable<MembershipCacheRow> {
  final String id;
  final String name;
  final int? maxCards;
  final int? maxReceiptScansPerMonth;
  final int? maxCashbackCalculationsPerMonth;
  final int? serverUpdatedAtMs;
  final int datasetVersion;
  const MembershipCacheRow({
    required this.id,
    required this.name,
    this.maxCards,
    this.maxReceiptScansPerMonth,
    this.maxCashbackCalculationsPerMonth,
    this.serverUpdatedAtMs,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || maxCards != null) {
      map['max_cards'] = Variable<int>(maxCards);
    }
    if (!nullToAbsent || maxReceiptScansPerMonth != null) {
      map['max_receipt_scans_per_month'] = Variable<int>(
        maxReceiptScansPerMonth,
      );
    }
    if (!nullToAbsent || maxCashbackCalculationsPerMonth != null) {
      map['max_cashback_calculations_per_month'] = Variable<int>(
        maxCashbackCalculationsPerMonth,
      );
    }
    if (!nullToAbsent || serverUpdatedAtMs != null) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs);
    }
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  MembershipsCacheCompanion toCompanion(bool nullToAbsent) {
    return MembershipsCacheCompanion(
      id: Value(id),
      name: Value(name),
      maxCards: maxCards == null && nullToAbsent
          ? const Value.absent()
          : Value(maxCards),
      maxReceiptScansPerMonth: maxReceiptScansPerMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(maxReceiptScansPerMonth),
      maxCashbackCalculationsPerMonth:
          maxCashbackCalculationsPerMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(maxCashbackCalculationsPerMonth),
      serverUpdatedAtMs: serverUpdatedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAtMs),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory MembershipCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MembershipCacheRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      maxCards: serializer.fromJson<int?>(json['maxCards']),
      maxReceiptScansPerMonth: serializer.fromJson<int?>(
        json['maxReceiptScansPerMonth'],
      ),
      maxCashbackCalculationsPerMonth: serializer.fromJson<int?>(
        json['maxCashbackCalculationsPerMonth'],
      ),
      serverUpdatedAtMs: serializer.fromJson<int?>(json['serverUpdatedAtMs']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'maxCards': serializer.toJson<int?>(maxCards),
      'maxReceiptScansPerMonth': serializer.toJson<int?>(
        maxReceiptScansPerMonth,
      ),
      'maxCashbackCalculationsPerMonth': serializer.toJson<int?>(
        maxCashbackCalculationsPerMonth,
      ),
      'serverUpdatedAtMs': serializer.toJson<int?>(serverUpdatedAtMs),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  MembershipCacheRow copyWith({
    String? id,
    String? name,
    Value<int?> maxCards = const Value.absent(),
    Value<int?> maxReceiptScansPerMonth = const Value.absent(),
    Value<int?> maxCashbackCalculationsPerMonth = const Value.absent(),
    Value<int?> serverUpdatedAtMs = const Value.absent(),
    int? datasetVersion,
  }) => MembershipCacheRow(
    id: id ?? this.id,
    name: name ?? this.name,
    maxCards: maxCards.present ? maxCards.value : this.maxCards,
    maxReceiptScansPerMonth: maxReceiptScansPerMonth.present
        ? maxReceiptScansPerMonth.value
        : this.maxReceiptScansPerMonth,
    maxCashbackCalculationsPerMonth: maxCashbackCalculationsPerMonth.present
        ? maxCashbackCalculationsPerMonth.value
        : this.maxCashbackCalculationsPerMonth,
    serverUpdatedAtMs: serverUpdatedAtMs.present
        ? serverUpdatedAtMs.value
        : this.serverUpdatedAtMs,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  MembershipCacheRow copyWithCompanion(MembershipsCacheCompanion data) {
    return MembershipCacheRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      maxCards: data.maxCards.present ? data.maxCards.value : this.maxCards,
      maxReceiptScansPerMonth: data.maxReceiptScansPerMonth.present
          ? data.maxReceiptScansPerMonth.value
          : this.maxReceiptScansPerMonth,
      maxCashbackCalculationsPerMonth:
          data.maxCashbackCalculationsPerMonth.present
          ? data.maxCashbackCalculationsPerMonth.value
          : this.maxCashbackCalculationsPerMonth,
      serverUpdatedAtMs: data.serverUpdatedAtMs.present
          ? data.serverUpdatedAtMs.value
          : this.serverUpdatedAtMs,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MembershipCacheRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxCards: $maxCards, ')
          ..write('maxReceiptScansPerMonth: $maxReceiptScansPerMonth, ')
          ..write(
            'maxCashbackCalculationsPerMonth: $maxCashbackCalculationsPerMonth, ',
          )
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    maxCards,
    maxReceiptScansPerMonth,
    maxCashbackCalculationsPerMonth,
    serverUpdatedAtMs,
    datasetVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MembershipCacheRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.maxCards == this.maxCards &&
          other.maxReceiptScansPerMonth == this.maxReceiptScansPerMonth &&
          other.maxCashbackCalculationsPerMonth ==
              this.maxCashbackCalculationsPerMonth &&
          other.serverUpdatedAtMs == this.serverUpdatedAtMs &&
          other.datasetVersion == this.datasetVersion);
}

class MembershipsCacheCompanion extends UpdateCompanion<MembershipCacheRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int?> maxCards;
  final Value<int?> maxReceiptScansPerMonth;
  final Value<int?> maxCashbackCalculationsPerMonth;
  final Value<int?> serverUpdatedAtMs;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const MembershipsCacheCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.maxCards = const Value.absent(),
    this.maxReceiptScansPerMonth = const Value.absent(),
    this.maxCashbackCalculationsPerMonth = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembershipsCacheCompanion.insert({
    required String id,
    required String name,
    this.maxCards = const Value.absent(),
    this.maxReceiptScansPerMonth = const Value.absent(),
    this.maxCashbackCalculationsPerMonth = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    required int datasetVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       datasetVersion = Value(datasetVersion);
  static Insertable<MembershipCacheRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? maxCards,
    Expression<int>? maxReceiptScansPerMonth,
    Expression<int>? maxCashbackCalculationsPerMonth,
    Expression<int>? serverUpdatedAtMs,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (maxCards != null) 'max_cards': maxCards,
      if (maxReceiptScansPerMonth != null)
        'max_receipt_scans_per_month': maxReceiptScansPerMonth,
      if (maxCashbackCalculationsPerMonth != null)
        'max_cashback_calculations_per_month': maxCashbackCalculationsPerMonth,
      if (serverUpdatedAtMs != null) 'server_updated_at_ms': serverUpdatedAtMs,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembershipsCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int?>? maxCards,
    Value<int?>? maxReceiptScansPerMonth,
    Value<int?>? maxCashbackCalculationsPerMonth,
    Value<int?>? serverUpdatedAtMs,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return MembershipsCacheCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      maxCards: maxCards ?? this.maxCards,
      maxReceiptScansPerMonth:
          maxReceiptScansPerMonth ?? this.maxReceiptScansPerMonth,
      maxCashbackCalculationsPerMonth:
          maxCashbackCalculationsPerMonth ??
          this.maxCashbackCalculationsPerMonth,
      serverUpdatedAtMs: serverUpdatedAtMs ?? this.serverUpdatedAtMs,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (maxCards.present) {
      map['max_cards'] = Variable<int>(maxCards.value);
    }
    if (maxReceiptScansPerMonth.present) {
      map['max_receipt_scans_per_month'] = Variable<int>(
        maxReceiptScansPerMonth.value,
      );
    }
    if (maxCashbackCalculationsPerMonth.present) {
      map['max_cashback_calculations_per_month'] = Variable<int>(
        maxCashbackCalculationsPerMonth.value,
      );
    }
    if (serverUpdatedAtMs.present) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembershipsCacheCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxCards: $maxCards, ')
          ..write('maxReceiptScansPerMonth: $maxReceiptScansPerMonth, ')
          ..write(
            'maxCashbackCalculationsPerMonth: $maxCashbackCalculationsPerMonth, ',
          )
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BanksCacheTable extends BanksCache
    with TableInfo<$BanksCacheTable, BankCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BanksCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _swiftCodeMeta = const VerificationMeta(
    'swiftCode',
  );
  @override
  late final GeneratedColumn<String> swiftCode = GeneratedColumn<String>(
    'swift_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortNameMeta = const VerificationMeta(
    'shortName',
  );
  @override
  late final GeneratedColumn<String> shortName = GeneratedColumn<String>(
    'short_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverUpdatedAtMsMeta = const VerificationMeta(
    'serverUpdatedAtMs',
  );
  @override
  late final GeneratedColumn<int> serverUpdatedAtMs = GeneratedColumn<int>(
    'server_updated_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    check: () => ComparableExpr(datasetVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    swiftCode,
    name,
    shortName,
    serverUpdatedAtMs,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banks_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('swift_code')) {
      context.handle(
        _swiftCodeMeta,
        swiftCode.isAcceptableOrUnknown(data['swift_code']!, _swiftCodeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('short_name')) {
      context.handle(
        _shortNameMeta,
        shortName.isAcceptableOrUnknown(data['short_name']!, _shortNameMeta),
      );
    }
    if (data.containsKey('server_updated_at_ms')) {
      context.handle(
        _serverUpdatedAtMsMeta,
        serverUpdatedAtMs.isAcceptableOrUnknown(
          data['server_updated_at_ms']!,
          _serverUpdatedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      swiftCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}swift_code'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      shortName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_name'],
      ),
      serverUpdatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_updated_at_ms'],
      ),
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $BanksCacheTable createAlias(String alias) {
    return $BanksCacheTable(attachedDatabase, alias);
  }
}

class BankCacheRow extends DataClass implements Insertable<BankCacheRow> {
  final String id;
  final String? swiftCode;
  final String name;
  final String? shortName;
  final int? serverUpdatedAtMs;
  final int datasetVersion;
  const BankCacheRow({
    required this.id,
    this.swiftCode,
    required this.name,
    this.shortName,
    this.serverUpdatedAtMs,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || swiftCode != null) {
      map['swift_code'] = Variable<String>(swiftCode);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || shortName != null) {
      map['short_name'] = Variable<String>(shortName);
    }
    if (!nullToAbsent || serverUpdatedAtMs != null) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs);
    }
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  BanksCacheCompanion toCompanion(bool nullToAbsent) {
    return BanksCacheCompanion(
      id: Value(id),
      swiftCode: swiftCode == null && nullToAbsent
          ? const Value.absent()
          : Value(swiftCode),
      name: Value(name),
      shortName: shortName == null && nullToAbsent
          ? const Value.absent()
          : Value(shortName),
      serverUpdatedAtMs: serverUpdatedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAtMs),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory BankCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankCacheRow(
      id: serializer.fromJson<String>(json['id']),
      swiftCode: serializer.fromJson<String?>(json['swiftCode']),
      name: serializer.fromJson<String>(json['name']),
      shortName: serializer.fromJson<String?>(json['shortName']),
      serverUpdatedAtMs: serializer.fromJson<int?>(json['serverUpdatedAtMs']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'swiftCode': serializer.toJson<String?>(swiftCode),
      'name': serializer.toJson<String>(name),
      'shortName': serializer.toJson<String?>(shortName),
      'serverUpdatedAtMs': serializer.toJson<int?>(serverUpdatedAtMs),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  BankCacheRow copyWith({
    String? id,
    Value<String?> swiftCode = const Value.absent(),
    String? name,
    Value<String?> shortName = const Value.absent(),
    Value<int?> serverUpdatedAtMs = const Value.absent(),
    int? datasetVersion,
  }) => BankCacheRow(
    id: id ?? this.id,
    swiftCode: swiftCode.present ? swiftCode.value : this.swiftCode,
    name: name ?? this.name,
    shortName: shortName.present ? shortName.value : this.shortName,
    serverUpdatedAtMs: serverUpdatedAtMs.present
        ? serverUpdatedAtMs.value
        : this.serverUpdatedAtMs,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  BankCacheRow copyWithCompanion(BanksCacheCompanion data) {
    return BankCacheRow(
      id: data.id.present ? data.id.value : this.id,
      swiftCode: data.swiftCode.present ? data.swiftCode.value : this.swiftCode,
      name: data.name.present ? data.name.value : this.name,
      shortName: data.shortName.present ? data.shortName.value : this.shortName,
      serverUpdatedAtMs: data.serverUpdatedAtMs.present
          ? data.serverUpdatedAtMs.value
          : this.serverUpdatedAtMs,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankCacheRow(')
          ..write('id: $id, ')
          ..write('swiftCode: $swiftCode, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    swiftCode,
    name,
    shortName,
    serverUpdatedAtMs,
    datasetVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankCacheRow &&
          other.id == this.id &&
          other.swiftCode == this.swiftCode &&
          other.name == this.name &&
          other.shortName == this.shortName &&
          other.serverUpdatedAtMs == this.serverUpdatedAtMs &&
          other.datasetVersion == this.datasetVersion);
}

class BanksCacheCompanion extends UpdateCompanion<BankCacheRow> {
  final Value<String> id;
  final Value<String?> swiftCode;
  final Value<String> name;
  final Value<String?> shortName;
  final Value<int?> serverUpdatedAtMs;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const BanksCacheCompanion({
    this.id = const Value.absent(),
    this.swiftCode = const Value.absent(),
    this.name = const Value.absent(),
    this.shortName = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BanksCacheCompanion.insert({
    required String id,
    this.swiftCode = const Value.absent(),
    required String name,
    this.shortName = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    required int datasetVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       datasetVersion = Value(datasetVersion);
  static Insertable<BankCacheRow> custom({
    Expression<String>? id,
    Expression<String>? swiftCode,
    Expression<String>? name,
    Expression<String>? shortName,
    Expression<int>? serverUpdatedAtMs,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (swiftCode != null) 'swift_code': swiftCode,
      if (name != null) 'name': name,
      if (shortName != null) 'short_name': shortName,
      if (serverUpdatedAtMs != null) 'server_updated_at_ms': serverUpdatedAtMs,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BanksCacheCompanion copyWith({
    Value<String>? id,
    Value<String?>? swiftCode,
    Value<String>? name,
    Value<String?>? shortName,
    Value<int?>? serverUpdatedAtMs,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return BanksCacheCompanion(
      id: id ?? this.id,
      swiftCode: swiftCode ?? this.swiftCode,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      serverUpdatedAtMs: serverUpdatedAtMs ?? this.serverUpdatedAtMs,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (swiftCode.present) {
      map['swift_code'] = Variable<String>(swiftCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shortName.present) {
      map['short_name'] = Variable<String>(shortName.value);
    }
    if (serverUpdatedAtMs.present) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BanksCacheCompanion(')
          ..write('id: $id, ')
          ..write('swiftCode: $swiftCode, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CreditCardsCacheTable extends CreditCardsCache
    with TableInfo<$CreditCardsCacheTable, CreditCardCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedColumn<String> bankId = GeneratedColumn<String>(
    'bank_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _networkMeta = const VerificationMeta(
    'network',
  );
  @override
  late final GeneratedColumn<String> network = GeneratedColumn<String>(
    'network',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardTypeMeta = const VerificationMeta(
    'cardType',
  );
  @override
  late final GeneratedColumn<String> cardType = GeneratedColumn<String>(
    'card_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('credit'),
  );
  static const VerificationMeta _annualFeeDecimalMeta = const VerificationMeta(
    'annualFeeDecimal',
  );
  @override
  late final GeneratedColumn<String> annualFeeDecimal = GeneratedColumn<String>(
    'annual_fee_decimal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastVerifiedAtMsMeta = const VerificationMeta(
    'lastVerifiedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastVerifiedAtMs = GeneratedColumn<int>(
    'last_verified_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _serverUpdatedAtMsMeta = const VerificationMeta(
    'serverUpdatedAtMs',
  );
  @override
  late final GeneratedColumn<int> serverUpdatedAtMs = GeneratedColumn<int>(
    'server_updated_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    check: () => ComparableExpr(datasetVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bankId,
    name,
    network,
    cardType,
    annualFeeDecimal,
    sourceUrl,
    lastVerifiedAtMs,
    isActive,
    serverUpdatedAtMs,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_cards_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCardCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('bank_id')) {
      context.handle(
        _bankIdMeta,
        bankId.isAcceptableOrUnknown(data['bank_id']!, _bankIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bankIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('network')) {
      context.handle(
        _networkMeta,
        network.isAcceptableOrUnknown(data['network']!, _networkMeta),
      );
    }
    if (data.containsKey('card_type')) {
      context.handle(
        _cardTypeMeta,
        cardType.isAcceptableOrUnknown(data['card_type']!, _cardTypeMeta),
      );
    }
    if (data.containsKey('annual_fee_decimal')) {
      context.handle(
        _annualFeeDecimalMeta,
        annualFeeDecimal.isAcceptableOrUnknown(
          data['annual_fee_decimal']!,
          _annualFeeDecimalMeta,
        ),
      );
    }
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    }
    if (data.containsKey('last_verified_at_ms')) {
      context.handle(
        _lastVerifiedAtMsMeta,
        lastVerifiedAtMs.isAcceptableOrUnknown(
          data['last_verified_at_ms']!,
          _lastVerifiedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('server_updated_at_ms')) {
      context.handle(
        _serverUpdatedAtMsMeta,
        serverUpdatedAtMs.isAcceptableOrUnknown(
          data['server_updated_at_ms']!,
          _serverUpdatedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCardCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bankId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      network: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}network'],
      ),
      cardType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_type'],
      )!,
      annualFeeDecimal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}annual_fee_decimal'],
      ),
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      ),
      lastVerifiedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_verified_at_ms'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      serverUpdatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_updated_at_ms'],
      ),
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $CreditCardsCacheTable createAlias(String alias) {
    return $CreditCardsCacheTable(attachedDatabase, alias);
  }
}

class CreditCardCacheRow extends DataClass
    implements Insertable<CreditCardCacheRow> {
  final String id;
  final String bankId;
  final String name;
  final String? network;
  final String cardType;
  final String? annualFeeDecimal;
  final String? sourceUrl;
  final int? lastVerifiedAtMs;
  final bool isActive;
  final int? serverUpdatedAtMs;
  final int datasetVersion;
  const CreditCardCacheRow({
    required this.id,
    required this.bankId,
    required this.name,
    this.network,
    required this.cardType,
    this.annualFeeDecimal,
    this.sourceUrl,
    this.lastVerifiedAtMs,
    required this.isActive,
    this.serverUpdatedAtMs,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bank_id'] = Variable<String>(bankId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || network != null) {
      map['network'] = Variable<String>(network);
    }
    map['card_type'] = Variable<String>(cardType);
    if (!nullToAbsent || annualFeeDecimal != null) {
      map['annual_fee_decimal'] = Variable<String>(annualFeeDecimal);
    }
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || lastVerifiedAtMs != null) {
      map['last_verified_at_ms'] = Variable<int>(lastVerifiedAtMs);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || serverUpdatedAtMs != null) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs);
    }
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  CreditCardsCacheCompanion toCompanion(bool nullToAbsent) {
    return CreditCardsCacheCompanion(
      id: Value(id),
      bankId: Value(bankId),
      name: Value(name),
      network: network == null && nullToAbsent
          ? const Value.absent()
          : Value(network),
      cardType: Value(cardType),
      annualFeeDecimal: annualFeeDecimal == null && nullToAbsent
          ? const Value.absent()
          : Value(annualFeeDecimal),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      lastVerifiedAtMs: lastVerifiedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVerifiedAtMs),
      isActive: Value(isActive),
      serverUpdatedAtMs: serverUpdatedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAtMs),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory CreditCardCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardCacheRow(
      id: serializer.fromJson<String>(json['id']),
      bankId: serializer.fromJson<String>(json['bankId']),
      name: serializer.fromJson<String>(json['name']),
      network: serializer.fromJson<String?>(json['network']),
      cardType: serializer.fromJson<String>(json['cardType']),
      annualFeeDecimal: serializer.fromJson<String?>(json['annualFeeDecimal']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      lastVerifiedAtMs: serializer.fromJson<int?>(json['lastVerifiedAtMs']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      serverUpdatedAtMs: serializer.fromJson<int?>(json['serverUpdatedAtMs']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bankId': serializer.toJson<String>(bankId),
      'name': serializer.toJson<String>(name),
      'network': serializer.toJson<String?>(network),
      'cardType': serializer.toJson<String>(cardType),
      'annualFeeDecimal': serializer.toJson<String?>(annualFeeDecimal),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'lastVerifiedAtMs': serializer.toJson<int?>(lastVerifiedAtMs),
      'isActive': serializer.toJson<bool>(isActive),
      'serverUpdatedAtMs': serializer.toJson<int?>(serverUpdatedAtMs),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  CreditCardCacheRow copyWith({
    String? id,
    String? bankId,
    String? name,
    Value<String?> network = const Value.absent(),
    String? cardType,
    Value<String?> annualFeeDecimal = const Value.absent(),
    Value<String?> sourceUrl = const Value.absent(),
    Value<int?> lastVerifiedAtMs = const Value.absent(),
    bool? isActive,
    Value<int?> serverUpdatedAtMs = const Value.absent(),
    int? datasetVersion,
  }) => CreditCardCacheRow(
    id: id ?? this.id,
    bankId: bankId ?? this.bankId,
    name: name ?? this.name,
    network: network.present ? network.value : this.network,
    cardType: cardType ?? this.cardType,
    annualFeeDecimal: annualFeeDecimal.present
        ? annualFeeDecimal.value
        : this.annualFeeDecimal,
    sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
    lastVerifiedAtMs: lastVerifiedAtMs.present
        ? lastVerifiedAtMs.value
        : this.lastVerifiedAtMs,
    isActive: isActive ?? this.isActive,
    serverUpdatedAtMs: serverUpdatedAtMs.present
        ? serverUpdatedAtMs.value
        : this.serverUpdatedAtMs,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  CreditCardCacheRow copyWithCompanion(CreditCardsCacheCompanion data) {
    return CreditCardCacheRow(
      id: data.id.present ? data.id.value : this.id,
      bankId: data.bankId.present ? data.bankId.value : this.bankId,
      name: data.name.present ? data.name.value : this.name,
      network: data.network.present ? data.network.value : this.network,
      cardType: data.cardType.present ? data.cardType.value : this.cardType,
      annualFeeDecimal: data.annualFeeDecimal.present
          ? data.annualFeeDecimal.value
          : this.annualFeeDecimal,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      lastVerifiedAtMs: data.lastVerifiedAtMs.present
          ? data.lastVerifiedAtMs.value
          : this.lastVerifiedAtMs,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      serverUpdatedAtMs: data.serverUpdatedAtMs.present
          ? data.serverUpdatedAtMs.value
          : this.serverUpdatedAtMs,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardCacheRow(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('name: $name, ')
          ..write('network: $network, ')
          ..write('cardType: $cardType, ')
          ..write('annualFeeDecimal: $annualFeeDecimal, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('lastVerifiedAtMs: $lastVerifiedAtMs, ')
          ..write('isActive: $isActive, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bankId,
    name,
    network,
    cardType,
    annualFeeDecimal,
    sourceUrl,
    lastVerifiedAtMs,
    isActive,
    serverUpdatedAtMs,
    datasetVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardCacheRow &&
          other.id == this.id &&
          other.bankId == this.bankId &&
          other.name == this.name &&
          other.network == this.network &&
          other.cardType == this.cardType &&
          other.annualFeeDecimal == this.annualFeeDecimal &&
          other.sourceUrl == this.sourceUrl &&
          other.lastVerifiedAtMs == this.lastVerifiedAtMs &&
          other.isActive == this.isActive &&
          other.serverUpdatedAtMs == this.serverUpdatedAtMs &&
          other.datasetVersion == this.datasetVersion);
}

class CreditCardsCacheCompanion extends UpdateCompanion<CreditCardCacheRow> {
  final Value<String> id;
  final Value<String> bankId;
  final Value<String> name;
  final Value<String?> network;
  final Value<String> cardType;
  final Value<String?> annualFeeDecimal;
  final Value<String?> sourceUrl;
  final Value<int?> lastVerifiedAtMs;
  final Value<bool> isActive;
  final Value<int?> serverUpdatedAtMs;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const CreditCardsCacheCompanion({
    this.id = const Value.absent(),
    this.bankId = const Value.absent(),
    this.name = const Value.absent(),
    this.network = const Value.absent(),
    this.cardType = const Value.absent(),
    this.annualFeeDecimal = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.lastVerifiedAtMs = const Value.absent(),
    this.isActive = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CreditCardsCacheCompanion.insert({
    required String id,
    required String bankId,
    required String name,
    this.network = const Value.absent(),
    this.cardType = const Value.absent(),
    this.annualFeeDecimal = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.lastVerifiedAtMs = const Value.absent(),
    this.isActive = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    required int datasetVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bankId = Value(bankId),
       name = Value(name),
       datasetVersion = Value(datasetVersion);
  static Insertable<CreditCardCacheRow> custom({
    Expression<String>? id,
    Expression<String>? bankId,
    Expression<String>? name,
    Expression<String>? network,
    Expression<String>? cardType,
    Expression<String>? annualFeeDecimal,
    Expression<String>? sourceUrl,
    Expression<int>? lastVerifiedAtMs,
    Expression<bool>? isActive,
    Expression<int>? serverUpdatedAtMs,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankId != null) 'bank_id': bankId,
      if (name != null) 'name': name,
      if (network != null) 'network': network,
      if (cardType != null) 'card_type': cardType,
      if (annualFeeDecimal != null) 'annual_fee_decimal': annualFeeDecimal,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (lastVerifiedAtMs != null) 'last_verified_at_ms': lastVerifiedAtMs,
      if (isActive != null) 'is_active': isActive,
      if (serverUpdatedAtMs != null) 'server_updated_at_ms': serverUpdatedAtMs,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CreditCardsCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? bankId,
    Value<String>? name,
    Value<String?>? network,
    Value<String>? cardType,
    Value<String?>? annualFeeDecimal,
    Value<String?>? sourceUrl,
    Value<int?>? lastVerifiedAtMs,
    Value<bool>? isActive,
    Value<int?>? serverUpdatedAtMs,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return CreditCardsCacheCompanion(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      name: name ?? this.name,
      network: network ?? this.network,
      cardType: cardType ?? this.cardType,
      annualFeeDecimal: annualFeeDecimal ?? this.annualFeeDecimal,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      lastVerifiedAtMs: lastVerifiedAtMs ?? this.lastVerifiedAtMs,
      isActive: isActive ?? this.isActive,
      serverUpdatedAtMs: serverUpdatedAtMs ?? this.serverUpdatedAtMs,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (network.present) {
      map['network'] = Variable<String>(network.value);
    }
    if (cardType.present) {
      map['card_type'] = Variable<String>(cardType.value);
    }
    if (annualFeeDecimal.present) {
      map['annual_fee_decimal'] = Variable<String>(annualFeeDecimal.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (lastVerifiedAtMs.present) {
      map['last_verified_at_ms'] = Variable<int>(lastVerifiedAtMs.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (serverUpdatedAtMs.present) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardsCacheCompanion(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('name: $name, ')
          ..write('network: $network, ')
          ..write('cardType: $cardType, ')
          ..write('annualFeeDecimal: $annualFeeDecimal, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('lastVerifiedAtMs: $lastVerifiedAtMs, ')
          ..write('isActive: $isActive, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MerchantCategoryCodesCacheTable extends MerchantCategoryCodesCache
    with
        TableInfo<
          $MerchantCategoryCodesCacheTable,
          MerchantCategoryCodeCacheRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantCategoryCodesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validPaymentMeta = const VerificationMeta(
    'validPayment',
  );
  @override
  late final GeneratedColumn<String> validPayment = GeneratedColumn<String>(
    'valid_payment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _serverUpdatedAtMsMeta = const VerificationMeta(
    'serverUpdatedAtMs',
  );
  @override
  late final GeneratedColumn<int> serverUpdatedAtMs = GeneratedColumn<int>(
    'server_updated_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    check: () => ComparableExpr(datasetVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    description,
    category,
    validPayment,
    isActive,
    serverUpdatedAtMs,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchant_category_codes_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<MerchantCategoryCodeCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('valid_payment')) {
      context.handle(
        _validPaymentMeta,
        validPayment.isAcceptableOrUnknown(
          data['valid_payment']!,
          _validPaymentMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('server_updated_at_ms')) {
      context.handle(
        _serverUpdatedAtMsMeta,
        serverUpdatedAtMs.isAcceptableOrUnknown(
          data['server_updated_at_ms']!,
          _serverUpdatedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  MerchantCategoryCodeCacheRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MerchantCategoryCodeCacheRow(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      validPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valid_payment'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      serverUpdatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_updated_at_ms'],
      ),
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $MerchantCategoryCodesCacheTable createAlias(String alias) {
    return $MerchantCategoryCodesCacheTable(attachedDatabase, alias);
  }
}

class MerchantCategoryCodeCacheRow extends DataClass
    implements Insertable<MerchantCategoryCodeCacheRow> {
  final String code;
  final String description;
  final String? category;
  final String? validPayment;
  final bool isActive;
  final int? serverUpdatedAtMs;
  final int datasetVersion;
  const MerchantCategoryCodeCacheRow({
    required this.code,
    required this.description,
    this.category,
    this.validPayment,
    required this.isActive,
    this.serverUpdatedAtMs,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || validPayment != null) {
      map['valid_payment'] = Variable<String>(validPayment);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || serverUpdatedAtMs != null) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs);
    }
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  MerchantCategoryCodesCacheCompanion toCompanion(bool nullToAbsent) {
    return MerchantCategoryCodesCacheCompanion(
      code: Value(code),
      description: Value(description),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      validPayment: validPayment == null && nullToAbsent
          ? const Value.absent()
          : Value(validPayment),
      isActive: Value(isActive),
      serverUpdatedAtMs: serverUpdatedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAtMs),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory MerchantCategoryCodeCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MerchantCategoryCodeCacheRow(
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String?>(json['category']),
      validPayment: serializer.fromJson<String?>(json['validPayment']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      serverUpdatedAtMs: serializer.fromJson<int?>(json['serverUpdatedAtMs']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String?>(category),
      'validPayment': serializer.toJson<String?>(validPayment),
      'isActive': serializer.toJson<bool>(isActive),
      'serverUpdatedAtMs': serializer.toJson<int?>(serverUpdatedAtMs),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  MerchantCategoryCodeCacheRow copyWith({
    String? code,
    String? description,
    Value<String?> category = const Value.absent(),
    Value<String?> validPayment = const Value.absent(),
    bool? isActive,
    Value<int?> serverUpdatedAtMs = const Value.absent(),
    int? datasetVersion,
  }) => MerchantCategoryCodeCacheRow(
    code: code ?? this.code,
    description: description ?? this.description,
    category: category.present ? category.value : this.category,
    validPayment: validPayment.present ? validPayment.value : this.validPayment,
    isActive: isActive ?? this.isActive,
    serverUpdatedAtMs: serverUpdatedAtMs.present
        ? serverUpdatedAtMs.value
        : this.serverUpdatedAtMs,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  MerchantCategoryCodeCacheRow copyWithCompanion(
    MerchantCategoryCodesCacheCompanion data,
  ) {
    return MerchantCategoryCodeCacheRow(
      code: data.code.present ? data.code.value : this.code,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      validPayment: data.validPayment.present
          ? data.validPayment.value
          : this.validPayment,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      serverUpdatedAtMs: data.serverUpdatedAtMs.present
          ? data.serverUpdatedAtMs.value
          : this.serverUpdatedAtMs,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MerchantCategoryCodeCacheRow(')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('validPayment: $validPayment, ')
          ..write('isActive: $isActive, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    code,
    description,
    category,
    validPayment,
    isActive,
    serverUpdatedAtMs,
    datasetVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MerchantCategoryCodeCacheRow &&
          other.code == this.code &&
          other.description == this.description &&
          other.category == this.category &&
          other.validPayment == this.validPayment &&
          other.isActive == this.isActive &&
          other.serverUpdatedAtMs == this.serverUpdatedAtMs &&
          other.datasetVersion == this.datasetVersion);
}

class MerchantCategoryCodesCacheCompanion
    extends UpdateCompanion<MerchantCategoryCodeCacheRow> {
  final Value<String> code;
  final Value<String> description;
  final Value<String?> category;
  final Value<String?> validPayment;
  final Value<bool> isActive;
  final Value<int?> serverUpdatedAtMs;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const MerchantCategoryCodesCacheCompanion({
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.validPayment = const Value.absent(),
    this.isActive = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MerchantCategoryCodesCacheCompanion.insert({
    required String code,
    required String description,
    this.category = const Value.absent(),
    this.validPayment = const Value.absent(),
    this.isActive = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    required int datasetVersion,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       description = Value(description),
       datasetVersion = Value(datasetVersion);
  static Insertable<MerchantCategoryCodeCacheRow> custom({
    Expression<String>? code,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? validPayment,
    Expression<bool>? isActive,
    Expression<int>? serverUpdatedAtMs,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (validPayment != null) 'valid_payment': validPayment,
      if (isActive != null) 'is_active': isActive,
      if (serverUpdatedAtMs != null) 'server_updated_at_ms': serverUpdatedAtMs,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MerchantCategoryCodesCacheCompanion copyWith({
    Value<String>? code,
    Value<String>? description,
    Value<String?>? category,
    Value<String?>? validPayment,
    Value<bool>? isActive,
    Value<int?>? serverUpdatedAtMs,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return MerchantCategoryCodesCacheCompanion(
      code: code ?? this.code,
      description: description ?? this.description,
      category: category ?? this.category,
      validPayment: validPayment ?? this.validPayment,
      isActive: isActive ?? this.isActive,
      serverUpdatedAtMs: serverUpdatedAtMs ?? this.serverUpdatedAtMs,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (validPayment.present) {
      map['valid_payment'] = Variable<String>(validPayment.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (serverUpdatedAtMs.present) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MerchantCategoryCodesCacheCompanion(')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('validPayment: $validPayment, ')
          ..write('isActive: $isActive, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RewardRulesCacheTable extends RewardRulesCache
    with TableInfo<$RewardRulesCacheTable, RewardRuleCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardRulesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditCardIdMeta = const VerificationMeta(
    'creditCardId',
  );
  @override
  late final GeneratedColumn<String> creditCardId = GeneratedColumn<String>(
    'credit_card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardTypeMeta = const VerificationMeta(
    'rewardType',
  );
  @override
  late final GeneratedColumn<String> rewardType = GeneratedColumn<String>(
    'reward_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashbackRateDecimalMeta =
      const VerificationMeta('cashbackRateDecimal');
  @override
  late final GeneratedColumn<String> cashbackRateDecimal =
      GeneratedColumn<String>(
        'cashback_rate_decimal',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _pointsRateDecimalMeta = const VerificationMeta(
    'pointsRateDecimal',
  );
  @override
  late final GeneratedColumn<String> pointsRateDecimal =
      GeneratedColumn<String>(
        'points_rate_decimal',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _monthlyCapAmountDecimalMeta =
      const VerificationMeta('monthlyCapAmountDecimal');
  @override
  late final GeneratedColumn<String> monthlyCapAmountDecimal =
      GeneratedColumn<String>(
        'monthly_cap_amount_decimal',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _minimumTransactionDecimalMeta =
      const VerificationMeta('minimumTransactionDecimal');
  @override
  late final GeneratedColumn<String> minimumTransactionDecimal =
      GeneratedColumn<String>(
        'minimum_transaction_decimal',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _minimumMonthlySpendDecimalMeta =
      const VerificationMeta('minimumMonthlySpendDecimal');
  @override
  late final GeneratedColumn<String> minimumMonthlySpendDecimal =
      GeneratedColumn<String>(
        'minimum_monthly_spend_decimal',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _eligibleChannelMeta = const VerificationMeta(
    'eligibleChannel',
  );
  @override
  late final GeneratedColumn<String> eligibleChannel = GeneratedColumn<String>(
    'eligible_channel',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('any'),
  );
  static const VerificationMeta _conditionsTextMeta = const VerificationMeta(
    'conditionsText',
  );
  @override
  late final GeneratedColumn<String> conditionsText = GeneratedColumn<String>(
    'conditions_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectiveFromMeta = const VerificationMeta(
    'effectiveFrom',
  );
  @override
  late final GeneratedColumn<String> effectiveFrom = GeneratedColumn<String>(
    'effective_from',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectiveToMeta = const VerificationMeta(
    'effectiveTo',
  );
  @override
  late final GeneratedColumn<String> effectiveTo = GeneratedColumn<String>(
    'effective_to',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidencePpmMeta = const VerificationMeta(
    'confidencePpm',
  );
  @override
  late final GeneratedColumn<int> confidencePpm = GeneratedColumn<int>(
    'confidence_ppm',
    aliasedName,
    true,
    check: () =>
        confidencePpm.isNull() |
        ComparableExpr(confidencePpm).isBetweenValues(0, 1000000),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastVerifiedAtMsMeta = const VerificationMeta(
    'lastVerifiedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastVerifiedAtMs = GeneratedColumn<int>(
    'last_verified_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _serverUpdatedAtMsMeta = const VerificationMeta(
    'serverUpdatedAtMs',
  );
  @override
  late final GeneratedColumn<int> serverUpdatedAtMs = GeneratedColumn<int>(
    'server_updated_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    check: () => ComparableExpr(datasetVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creditCardId,
    name,
    rewardType,
    cashbackRateDecimal,
    pointsRateDecimal,
    monthlyCapAmountDecimal,
    minimumTransactionDecimal,
    minimumMonthlySpendDecimal,
    eligibleChannel,
    conditionsText,
    effectiveFrom,
    effectiveTo,
    sourceUrl,
    confidencePpm,
    lastVerifiedAtMs,
    isActive,
    serverUpdatedAtMs,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reward_rules_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardRuleCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('credit_card_id')) {
      context.handle(
        _creditCardIdMeta,
        creditCardId.isAcceptableOrUnknown(
          data['credit_card_id']!,
          _creditCardIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditCardIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('reward_type')) {
      context.handle(
        _rewardTypeMeta,
        rewardType.isAcceptableOrUnknown(data['reward_type']!, _rewardTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_rewardTypeMeta);
    }
    if (data.containsKey('cashback_rate_decimal')) {
      context.handle(
        _cashbackRateDecimalMeta,
        cashbackRateDecimal.isAcceptableOrUnknown(
          data['cashback_rate_decimal']!,
          _cashbackRateDecimalMeta,
        ),
      );
    }
    if (data.containsKey('points_rate_decimal')) {
      context.handle(
        _pointsRateDecimalMeta,
        pointsRateDecimal.isAcceptableOrUnknown(
          data['points_rate_decimal']!,
          _pointsRateDecimalMeta,
        ),
      );
    }
    if (data.containsKey('monthly_cap_amount_decimal')) {
      context.handle(
        _monthlyCapAmountDecimalMeta,
        monthlyCapAmountDecimal.isAcceptableOrUnknown(
          data['monthly_cap_amount_decimal']!,
          _monthlyCapAmountDecimalMeta,
        ),
      );
    }
    if (data.containsKey('minimum_transaction_decimal')) {
      context.handle(
        _minimumTransactionDecimalMeta,
        minimumTransactionDecimal.isAcceptableOrUnknown(
          data['minimum_transaction_decimal']!,
          _minimumTransactionDecimalMeta,
        ),
      );
    }
    if (data.containsKey('minimum_monthly_spend_decimal')) {
      context.handle(
        _minimumMonthlySpendDecimalMeta,
        minimumMonthlySpendDecimal.isAcceptableOrUnknown(
          data['minimum_monthly_spend_decimal']!,
          _minimumMonthlySpendDecimalMeta,
        ),
      );
    }
    if (data.containsKey('eligible_channel')) {
      context.handle(
        _eligibleChannelMeta,
        eligibleChannel.isAcceptableOrUnknown(
          data['eligible_channel']!,
          _eligibleChannelMeta,
        ),
      );
    }
    if (data.containsKey('conditions_text')) {
      context.handle(
        _conditionsTextMeta,
        conditionsText.isAcceptableOrUnknown(
          data['conditions_text']!,
          _conditionsTextMeta,
        ),
      );
    }
    if (data.containsKey('effective_from')) {
      context.handle(
        _effectiveFromMeta,
        effectiveFrom.isAcceptableOrUnknown(
          data['effective_from']!,
          _effectiveFromMeta,
        ),
      );
    }
    if (data.containsKey('effective_to')) {
      context.handle(
        _effectiveToMeta,
        effectiveTo.isAcceptableOrUnknown(
          data['effective_to']!,
          _effectiveToMeta,
        ),
      );
    }
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    }
    if (data.containsKey('confidence_ppm')) {
      context.handle(
        _confidencePpmMeta,
        confidencePpm.isAcceptableOrUnknown(
          data['confidence_ppm']!,
          _confidencePpmMeta,
        ),
      );
    }
    if (data.containsKey('last_verified_at_ms')) {
      context.handle(
        _lastVerifiedAtMsMeta,
        lastVerifiedAtMs.isAcceptableOrUnknown(
          data['last_verified_at_ms']!,
          _lastVerifiedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('server_updated_at_ms')) {
      context.handle(
        _serverUpdatedAtMsMeta,
        serverUpdatedAtMs.isAcceptableOrUnknown(
          data['server_updated_at_ms']!,
          _serverUpdatedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RewardRuleCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardRuleCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      creditCardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_card_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      rewardType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reward_type'],
      )!,
      cashbackRateDecimal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cashback_rate_decimal'],
      ),
      pointsRateDecimal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}points_rate_decimal'],
      ),
      monthlyCapAmountDecimal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}monthly_cap_amount_decimal'],
      ),
      minimumTransactionDecimal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}minimum_transaction_decimal'],
      ),
      minimumMonthlySpendDecimal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}minimum_monthly_spend_decimal'],
      ),
      eligibleChannel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}eligible_channel'],
      )!,
      conditionsText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conditions_text'],
      ),
      effectiveFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_from'],
      ),
      effectiveTo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_to'],
      ),
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      ),
      confidencePpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence_ppm'],
      ),
      lastVerifiedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_verified_at_ms'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      serverUpdatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_updated_at_ms'],
      ),
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $RewardRulesCacheTable createAlias(String alias) {
    return $RewardRulesCacheTable(attachedDatabase, alias);
  }
}

class RewardRuleCacheRow extends DataClass
    implements Insertable<RewardRuleCacheRow> {
  final String id;
  final String creditCardId;
  final String name;
  final String rewardType;
  final String? cashbackRateDecimal;
  final String? pointsRateDecimal;
  final String? monthlyCapAmountDecimal;
  final String? minimumTransactionDecimal;
  final String? minimumMonthlySpendDecimal;
  final String eligibleChannel;
  final String? conditionsText;
  final String? effectiveFrom;
  final String? effectiveTo;
  final String? sourceUrl;
  final int? confidencePpm;
  final int? lastVerifiedAtMs;
  final bool isActive;
  final int? serverUpdatedAtMs;
  final int datasetVersion;
  const RewardRuleCacheRow({
    required this.id,
    required this.creditCardId,
    required this.name,
    required this.rewardType,
    this.cashbackRateDecimal,
    this.pointsRateDecimal,
    this.monthlyCapAmountDecimal,
    this.minimumTransactionDecimal,
    this.minimumMonthlySpendDecimal,
    required this.eligibleChannel,
    this.conditionsText,
    this.effectiveFrom,
    this.effectiveTo,
    this.sourceUrl,
    this.confidencePpm,
    this.lastVerifiedAtMs,
    required this.isActive,
    this.serverUpdatedAtMs,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['credit_card_id'] = Variable<String>(creditCardId);
    map['name'] = Variable<String>(name);
    map['reward_type'] = Variable<String>(rewardType);
    if (!nullToAbsent || cashbackRateDecimal != null) {
      map['cashback_rate_decimal'] = Variable<String>(cashbackRateDecimal);
    }
    if (!nullToAbsent || pointsRateDecimal != null) {
      map['points_rate_decimal'] = Variable<String>(pointsRateDecimal);
    }
    if (!nullToAbsent || monthlyCapAmountDecimal != null) {
      map['monthly_cap_amount_decimal'] = Variable<String>(
        monthlyCapAmountDecimal,
      );
    }
    if (!nullToAbsent || minimumTransactionDecimal != null) {
      map['minimum_transaction_decimal'] = Variable<String>(
        minimumTransactionDecimal,
      );
    }
    if (!nullToAbsent || minimumMonthlySpendDecimal != null) {
      map['minimum_monthly_spend_decimal'] = Variable<String>(
        minimumMonthlySpendDecimal,
      );
    }
    map['eligible_channel'] = Variable<String>(eligibleChannel);
    if (!nullToAbsent || conditionsText != null) {
      map['conditions_text'] = Variable<String>(conditionsText);
    }
    if (!nullToAbsent || effectiveFrom != null) {
      map['effective_from'] = Variable<String>(effectiveFrom);
    }
    if (!nullToAbsent || effectiveTo != null) {
      map['effective_to'] = Variable<String>(effectiveTo);
    }
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || confidencePpm != null) {
      map['confidence_ppm'] = Variable<int>(confidencePpm);
    }
    if (!nullToAbsent || lastVerifiedAtMs != null) {
      map['last_verified_at_ms'] = Variable<int>(lastVerifiedAtMs);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || serverUpdatedAtMs != null) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs);
    }
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  RewardRulesCacheCompanion toCompanion(bool nullToAbsent) {
    return RewardRulesCacheCompanion(
      id: Value(id),
      creditCardId: Value(creditCardId),
      name: Value(name),
      rewardType: Value(rewardType),
      cashbackRateDecimal: cashbackRateDecimal == null && nullToAbsent
          ? const Value.absent()
          : Value(cashbackRateDecimal),
      pointsRateDecimal: pointsRateDecimal == null && nullToAbsent
          ? const Value.absent()
          : Value(pointsRateDecimal),
      monthlyCapAmountDecimal: monthlyCapAmountDecimal == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyCapAmountDecimal),
      minimumTransactionDecimal:
          minimumTransactionDecimal == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumTransactionDecimal),
      minimumMonthlySpendDecimal:
          minimumMonthlySpendDecimal == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumMonthlySpendDecimal),
      eligibleChannel: Value(eligibleChannel),
      conditionsText: conditionsText == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionsText),
      effectiveFrom: effectiveFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveFrom),
      effectiveTo: effectiveTo == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveTo),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      confidencePpm: confidencePpm == null && nullToAbsent
          ? const Value.absent()
          : Value(confidencePpm),
      lastVerifiedAtMs: lastVerifiedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVerifiedAtMs),
      isActive: Value(isActive),
      serverUpdatedAtMs: serverUpdatedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUpdatedAtMs),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory RewardRuleCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardRuleCacheRow(
      id: serializer.fromJson<String>(json['id']),
      creditCardId: serializer.fromJson<String>(json['creditCardId']),
      name: serializer.fromJson<String>(json['name']),
      rewardType: serializer.fromJson<String>(json['rewardType']),
      cashbackRateDecimal: serializer.fromJson<String?>(
        json['cashbackRateDecimal'],
      ),
      pointsRateDecimal: serializer.fromJson<String?>(
        json['pointsRateDecimal'],
      ),
      monthlyCapAmountDecimal: serializer.fromJson<String?>(
        json['monthlyCapAmountDecimal'],
      ),
      minimumTransactionDecimal: serializer.fromJson<String?>(
        json['minimumTransactionDecimal'],
      ),
      minimumMonthlySpendDecimal: serializer.fromJson<String?>(
        json['minimumMonthlySpendDecimal'],
      ),
      eligibleChannel: serializer.fromJson<String>(json['eligibleChannel']),
      conditionsText: serializer.fromJson<String?>(json['conditionsText']),
      effectiveFrom: serializer.fromJson<String?>(json['effectiveFrom']),
      effectiveTo: serializer.fromJson<String?>(json['effectiveTo']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      confidencePpm: serializer.fromJson<int?>(json['confidencePpm']),
      lastVerifiedAtMs: serializer.fromJson<int?>(json['lastVerifiedAtMs']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      serverUpdatedAtMs: serializer.fromJson<int?>(json['serverUpdatedAtMs']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'creditCardId': serializer.toJson<String>(creditCardId),
      'name': serializer.toJson<String>(name),
      'rewardType': serializer.toJson<String>(rewardType),
      'cashbackRateDecimal': serializer.toJson<String?>(cashbackRateDecimal),
      'pointsRateDecimal': serializer.toJson<String?>(pointsRateDecimal),
      'monthlyCapAmountDecimal': serializer.toJson<String?>(
        monthlyCapAmountDecimal,
      ),
      'minimumTransactionDecimal': serializer.toJson<String?>(
        minimumTransactionDecimal,
      ),
      'minimumMonthlySpendDecimal': serializer.toJson<String?>(
        minimumMonthlySpendDecimal,
      ),
      'eligibleChannel': serializer.toJson<String>(eligibleChannel),
      'conditionsText': serializer.toJson<String?>(conditionsText),
      'effectiveFrom': serializer.toJson<String?>(effectiveFrom),
      'effectiveTo': serializer.toJson<String?>(effectiveTo),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'confidencePpm': serializer.toJson<int?>(confidencePpm),
      'lastVerifiedAtMs': serializer.toJson<int?>(lastVerifiedAtMs),
      'isActive': serializer.toJson<bool>(isActive),
      'serverUpdatedAtMs': serializer.toJson<int?>(serverUpdatedAtMs),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  RewardRuleCacheRow copyWith({
    String? id,
    String? creditCardId,
    String? name,
    String? rewardType,
    Value<String?> cashbackRateDecimal = const Value.absent(),
    Value<String?> pointsRateDecimal = const Value.absent(),
    Value<String?> monthlyCapAmountDecimal = const Value.absent(),
    Value<String?> minimumTransactionDecimal = const Value.absent(),
    Value<String?> minimumMonthlySpendDecimal = const Value.absent(),
    String? eligibleChannel,
    Value<String?> conditionsText = const Value.absent(),
    Value<String?> effectiveFrom = const Value.absent(),
    Value<String?> effectiveTo = const Value.absent(),
    Value<String?> sourceUrl = const Value.absent(),
    Value<int?> confidencePpm = const Value.absent(),
    Value<int?> lastVerifiedAtMs = const Value.absent(),
    bool? isActive,
    Value<int?> serverUpdatedAtMs = const Value.absent(),
    int? datasetVersion,
  }) => RewardRuleCacheRow(
    id: id ?? this.id,
    creditCardId: creditCardId ?? this.creditCardId,
    name: name ?? this.name,
    rewardType: rewardType ?? this.rewardType,
    cashbackRateDecimal: cashbackRateDecimal.present
        ? cashbackRateDecimal.value
        : this.cashbackRateDecimal,
    pointsRateDecimal: pointsRateDecimal.present
        ? pointsRateDecimal.value
        : this.pointsRateDecimal,
    monthlyCapAmountDecimal: monthlyCapAmountDecimal.present
        ? monthlyCapAmountDecimal.value
        : this.monthlyCapAmountDecimal,
    minimumTransactionDecimal: minimumTransactionDecimal.present
        ? minimumTransactionDecimal.value
        : this.minimumTransactionDecimal,
    minimumMonthlySpendDecimal: minimumMonthlySpendDecimal.present
        ? minimumMonthlySpendDecimal.value
        : this.minimumMonthlySpendDecimal,
    eligibleChannel: eligibleChannel ?? this.eligibleChannel,
    conditionsText: conditionsText.present
        ? conditionsText.value
        : this.conditionsText,
    effectiveFrom: effectiveFrom.present
        ? effectiveFrom.value
        : this.effectiveFrom,
    effectiveTo: effectiveTo.present ? effectiveTo.value : this.effectiveTo,
    sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
    confidencePpm: confidencePpm.present
        ? confidencePpm.value
        : this.confidencePpm,
    lastVerifiedAtMs: lastVerifiedAtMs.present
        ? lastVerifiedAtMs.value
        : this.lastVerifiedAtMs,
    isActive: isActive ?? this.isActive,
    serverUpdatedAtMs: serverUpdatedAtMs.present
        ? serverUpdatedAtMs.value
        : this.serverUpdatedAtMs,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  RewardRuleCacheRow copyWithCompanion(RewardRulesCacheCompanion data) {
    return RewardRuleCacheRow(
      id: data.id.present ? data.id.value : this.id,
      creditCardId: data.creditCardId.present
          ? data.creditCardId.value
          : this.creditCardId,
      name: data.name.present ? data.name.value : this.name,
      rewardType: data.rewardType.present
          ? data.rewardType.value
          : this.rewardType,
      cashbackRateDecimal: data.cashbackRateDecimal.present
          ? data.cashbackRateDecimal.value
          : this.cashbackRateDecimal,
      pointsRateDecimal: data.pointsRateDecimal.present
          ? data.pointsRateDecimal.value
          : this.pointsRateDecimal,
      monthlyCapAmountDecimal: data.monthlyCapAmountDecimal.present
          ? data.monthlyCapAmountDecimal.value
          : this.monthlyCapAmountDecimal,
      minimumTransactionDecimal: data.minimumTransactionDecimal.present
          ? data.minimumTransactionDecimal.value
          : this.minimumTransactionDecimal,
      minimumMonthlySpendDecimal: data.minimumMonthlySpendDecimal.present
          ? data.minimumMonthlySpendDecimal.value
          : this.minimumMonthlySpendDecimal,
      eligibleChannel: data.eligibleChannel.present
          ? data.eligibleChannel.value
          : this.eligibleChannel,
      conditionsText: data.conditionsText.present
          ? data.conditionsText.value
          : this.conditionsText,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      effectiveTo: data.effectiveTo.present
          ? data.effectiveTo.value
          : this.effectiveTo,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      confidencePpm: data.confidencePpm.present
          ? data.confidencePpm.value
          : this.confidencePpm,
      lastVerifiedAtMs: data.lastVerifiedAtMs.present
          ? data.lastVerifiedAtMs.value
          : this.lastVerifiedAtMs,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      serverUpdatedAtMs: data.serverUpdatedAtMs.present
          ? data.serverUpdatedAtMs.value
          : this.serverUpdatedAtMs,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardRuleCacheRow(')
          ..write('id: $id, ')
          ..write('creditCardId: $creditCardId, ')
          ..write('name: $name, ')
          ..write('rewardType: $rewardType, ')
          ..write('cashbackRateDecimal: $cashbackRateDecimal, ')
          ..write('pointsRateDecimal: $pointsRateDecimal, ')
          ..write('monthlyCapAmountDecimal: $monthlyCapAmountDecimal, ')
          ..write('minimumTransactionDecimal: $minimumTransactionDecimal, ')
          ..write('minimumMonthlySpendDecimal: $minimumMonthlySpendDecimal, ')
          ..write('eligibleChannel: $eligibleChannel, ')
          ..write('conditionsText: $conditionsText, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('confidencePpm: $confidencePpm, ')
          ..write('lastVerifiedAtMs: $lastVerifiedAtMs, ')
          ..write('isActive: $isActive, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creditCardId,
    name,
    rewardType,
    cashbackRateDecimal,
    pointsRateDecimal,
    monthlyCapAmountDecimal,
    minimumTransactionDecimal,
    minimumMonthlySpendDecimal,
    eligibleChannel,
    conditionsText,
    effectiveFrom,
    effectiveTo,
    sourceUrl,
    confidencePpm,
    lastVerifiedAtMs,
    isActive,
    serverUpdatedAtMs,
    datasetVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardRuleCacheRow &&
          other.id == this.id &&
          other.creditCardId == this.creditCardId &&
          other.name == this.name &&
          other.rewardType == this.rewardType &&
          other.cashbackRateDecimal == this.cashbackRateDecimal &&
          other.pointsRateDecimal == this.pointsRateDecimal &&
          other.monthlyCapAmountDecimal == this.monthlyCapAmountDecimal &&
          other.minimumTransactionDecimal == this.minimumTransactionDecimal &&
          other.minimumMonthlySpendDecimal == this.minimumMonthlySpendDecimal &&
          other.eligibleChannel == this.eligibleChannel &&
          other.conditionsText == this.conditionsText &&
          other.effectiveFrom == this.effectiveFrom &&
          other.effectiveTo == this.effectiveTo &&
          other.sourceUrl == this.sourceUrl &&
          other.confidencePpm == this.confidencePpm &&
          other.lastVerifiedAtMs == this.lastVerifiedAtMs &&
          other.isActive == this.isActive &&
          other.serverUpdatedAtMs == this.serverUpdatedAtMs &&
          other.datasetVersion == this.datasetVersion);
}

class RewardRulesCacheCompanion extends UpdateCompanion<RewardRuleCacheRow> {
  final Value<String> id;
  final Value<String> creditCardId;
  final Value<String> name;
  final Value<String> rewardType;
  final Value<String?> cashbackRateDecimal;
  final Value<String?> pointsRateDecimal;
  final Value<String?> monthlyCapAmountDecimal;
  final Value<String?> minimumTransactionDecimal;
  final Value<String?> minimumMonthlySpendDecimal;
  final Value<String> eligibleChannel;
  final Value<String?> conditionsText;
  final Value<String?> effectiveFrom;
  final Value<String?> effectiveTo;
  final Value<String?> sourceUrl;
  final Value<int?> confidencePpm;
  final Value<int?> lastVerifiedAtMs;
  final Value<bool> isActive;
  final Value<int?> serverUpdatedAtMs;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const RewardRulesCacheCompanion({
    this.id = const Value.absent(),
    this.creditCardId = const Value.absent(),
    this.name = const Value.absent(),
    this.rewardType = const Value.absent(),
    this.cashbackRateDecimal = const Value.absent(),
    this.pointsRateDecimal = const Value.absent(),
    this.monthlyCapAmountDecimal = const Value.absent(),
    this.minimumTransactionDecimal = const Value.absent(),
    this.minimumMonthlySpendDecimal = const Value.absent(),
    this.eligibleChannel = const Value.absent(),
    this.conditionsText = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.effectiveTo = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.confidencePpm = const Value.absent(),
    this.lastVerifiedAtMs = const Value.absent(),
    this.isActive = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RewardRulesCacheCompanion.insert({
    required String id,
    required String creditCardId,
    required String name,
    required String rewardType,
    this.cashbackRateDecimal = const Value.absent(),
    this.pointsRateDecimal = const Value.absent(),
    this.monthlyCapAmountDecimal = const Value.absent(),
    this.minimumTransactionDecimal = const Value.absent(),
    this.minimumMonthlySpendDecimal = const Value.absent(),
    this.eligibleChannel = const Value.absent(),
    this.conditionsText = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.effectiveTo = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.confidencePpm = const Value.absent(),
    this.lastVerifiedAtMs = const Value.absent(),
    this.isActive = const Value.absent(),
    this.serverUpdatedAtMs = const Value.absent(),
    required int datasetVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       creditCardId = Value(creditCardId),
       name = Value(name),
       rewardType = Value(rewardType),
       datasetVersion = Value(datasetVersion);
  static Insertable<RewardRuleCacheRow> custom({
    Expression<String>? id,
    Expression<String>? creditCardId,
    Expression<String>? name,
    Expression<String>? rewardType,
    Expression<String>? cashbackRateDecimal,
    Expression<String>? pointsRateDecimal,
    Expression<String>? monthlyCapAmountDecimal,
    Expression<String>? minimumTransactionDecimal,
    Expression<String>? minimumMonthlySpendDecimal,
    Expression<String>? eligibleChannel,
    Expression<String>? conditionsText,
    Expression<String>? effectiveFrom,
    Expression<String>? effectiveTo,
    Expression<String>? sourceUrl,
    Expression<int>? confidencePpm,
    Expression<int>? lastVerifiedAtMs,
    Expression<bool>? isActive,
    Expression<int>? serverUpdatedAtMs,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creditCardId != null) 'credit_card_id': creditCardId,
      if (name != null) 'name': name,
      if (rewardType != null) 'reward_type': rewardType,
      if (cashbackRateDecimal != null)
        'cashback_rate_decimal': cashbackRateDecimal,
      if (pointsRateDecimal != null) 'points_rate_decimal': pointsRateDecimal,
      if (monthlyCapAmountDecimal != null)
        'monthly_cap_amount_decimal': monthlyCapAmountDecimal,
      if (minimumTransactionDecimal != null)
        'minimum_transaction_decimal': minimumTransactionDecimal,
      if (minimumMonthlySpendDecimal != null)
        'minimum_monthly_spend_decimal': minimumMonthlySpendDecimal,
      if (eligibleChannel != null) 'eligible_channel': eligibleChannel,
      if (conditionsText != null) 'conditions_text': conditionsText,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (effectiveTo != null) 'effective_to': effectiveTo,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (confidencePpm != null) 'confidence_ppm': confidencePpm,
      if (lastVerifiedAtMs != null) 'last_verified_at_ms': lastVerifiedAtMs,
      if (isActive != null) 'is_active': isActive,
      if (serverUpdatedAtMs != null) 'server_updated_at_ms': serverUpdatedAtMs,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RewardRulesCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? creditCardId,
    Value<String>? name,
    Value<String>? rewardType,
    Value<String?>? cashbackRateDecimal,
    Value<String?>? pointsRateDecimal,
    Value<String?>? monthlyCapAmountDecimal,
    Value<String?>? minimumTransactionDecimal,
    Value<String?>? minimumMonthlySpendDecimal,
    Value<String>? eligibleChannel,
    Value<String?>? conditionsText,
    Value<String?>? effectiveFrom,
    Value<String?>? effectiveTo,
    Value<String?>? sourceUrl,
    Value<int?>? confidencePpm,
    Value<int?>? lastVerifiedAtMs,
    Value<bool>? isActive,
    Value<int?>? serverUpdatedAtMs,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return RewardRulesCacheCompanion(
      id: id ?? this.id,
      creditCardId: creditCardId ?? this.creditCardId,
      name: name ?? this.name,
      rewardType: rewardType ?? this.rewardType,
      cashbackRateDecimal: cashbackRateDecimal ?? this.cashbackRateDecimal,
      pointsRateDecimal: pointsRateDecimal ?? this.pointsRateDecimal,
      monthlyCapAmountDecimal:
          monthlyCapAmountDecimal ?? this.monthlyCapAmountDecimal,
      minimumTransactionDecimal:
          minimumTransactionDecimal ?? this.minimumTransactionDecimal,
      minimumMonthlySpendDecimal:
          minimumMonthlySpendDecimal ?? this.minimumMonthlySpendDecimal,
      eligibleChannel: eligibleChannel ?? this.eligibleChannel,
      conditionsText: conditionsText ?? this.conditionsText,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo ?? this.effectiveTo,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      confidencePpm: confidencePpm ?? this.confidencePpm,
      lastVerifiedAtMs: lastVerifiedAtMs ?? this.lastVerifiedAtMs,
      isActive: isActive ?? this.isActive,
      serverUpdatedAtMs: serverUpdatedAtMs ?? this.serverUpdatedAtMs,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (creditCardId.present) {
      map['credit_card_id'] = Variable<String>(creditCardId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rewardType.present) {
      map['reward_type'] = Variable<String>(rewardType.value);
    }
    if (cashbackRateDecimal.present) {
      map['cashback_rate_decimal'] = Variable<String>(
        cashbackRateDecimal.value,
      );
    }
    if (pointsRateDecimal.present) {
      map['points_rate_decimal'] = Variable<String>(pointsRateDecimal.value);
    }
    if (monthlyCapAmountDecimal.present) {
      map['monthly_cap_amount_decimal'] = Variable<String>(
        monthlyCapAmountDecimal.value,
      );
    }
    if (minimumTransactionDecimal.present) {
      map['minimum_transaction_decimal'] = Variable<String>(
        minimumTransactionDecimal.value,
      );
    }
    if (minimumMonthlySpendDecimal.present) {
      map['minimum_monthly_spend_decimal'] = Variable<String>(
        minimumMonthlySpendDecimal.value,
      );
    }
    if (eligibleChannel.present) {
      map['eligible_channel'] = Variable<String>(eligibleChannel.value);
    }
    if (conditionsText.present) {
      map['conditions_text'] = Variable<String>(conditionsText.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<String>(effectiveFrom.value);
    }
    if (effectiveTo.present) {
      map['effective_to'] = Variable<String>(effectiveTo.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (confidencePpm.present) {
      map['confidence_ppm'] = Variable<int>(confidencePpm.value);
    }
    if (lastVerifiedAtMs.present) {
      map['last_verified_at_ms'] = Variable<int>(lastVerifiedAtMs.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (serverUpdatedAtMs.present) {
      map['server_updated_at_ms'] = Variable<int>(serverUpdatedAtMs.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardRulesCacheCompanion(')
          ..write('id: $id, ')
          ..write('creditCardId: $creditCardId, ')
          ..write('name: $name, ')
          ..write('rewardType: $rewardType, ')
          ..write('cashbackRateDecimal: $cashbackRateDecimal, ')
          ..write('pointsRateDecimal: $pointsRateDecimal, ')
          ..write('monthlyCapAmountDecimal: $monthlyCapAmountDecimal, ')
          ..write('minimumTransactionDecimal: $minimumTransactionDecimal, ')
          ..write('minimumMonthlySpendDecimal: $minimumMonthlySpendDecimal, ')
          ..write('eligibleChannel: $eligibleChannel, ')
          ..write('conditionsText: $conditionsText, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('confidencePpm: $confidencePpm, ')
          ..write('lastVerifiedAtMs: $lastVerifiedAtMs, ')
          ..write('isActive: $isActive, ')
          ..write('serverUpdatedAtMs: $serverUpdatedAtMs, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RewardRuleMccsCacheTable extends RewardRuleMccsCache
    with TableInfo<$RewardRuleMccsCacheTable, RewardRuleMccCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardRuleMccsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardRuleIdMeta = const VerificationMeta(
    'rewardRuleId',
  );
  @override
  late final GeneratedColumn<String> rewardRuleId = GeneratedColumn<String>(
    'reward_rule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mccCodeMeta = const VerificationMeta(
    'mccCode',
  );
  @override
  late final GeneratedColumn<String> mccCode = GeneratedColumn<String>(
    'mcc_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matchTypeMeta = const VerificationMeta(
    'matchType',
  );
  @override
  late final GeneratedColumn<String> matchType = GeneratedColumn<String>(
    'match_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    check: () => ComparableExpr(datasetVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rewardRuleId,
    mccCode,
    matchType,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reward_rule_mccs_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardRuleMccCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reward_rule_id')) {
      context.handle(
        _rewardRuleIdMeta,
        rewardRuleId.isAcceptableOrUnknown(
          data['reward_rule_id']!,
          _rewardRuleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardRuleIdMeta);
    }
    if (data.containsKey('mcc_code')) {
      context.handle(
        _mccCodeMeta,
        mccCode.isAcceptableOrUnknown(data['mcc_code']!, _mccCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_mccCodeMeta);
    }
    if (data.containsKey('match_type')) {
      context.handle(
        _matchTypeMeta,
        matchType.isAcceptableOrUnknown(data['match_type']!, _matchTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_matchTypeMeta);
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {rewardRuleId, mccCode, matchType},
  ];
  @override
  RewardRuleMccCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardRuleMccCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      rewardRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reward_rule_id'],
      )!,
      mccCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc_code'],
      )!,
      matchType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_type'],
      )!,
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $RewardRuleMccsCacheTable createAlias(String alias) {
    return $RewardRuleMccsCacheTable(attachedDatabase, alias);
  }
}

class RewardRuleMccCacheRow extends DataClass
    implements Insertable<RewardRuleMccCacheRow> {
  final String id;
  final String rewardRuleId;
  final String mccCode;
  final String matchType;
  final int datasetVersion;
  const RewardRuleMccCacheRow({
    required this.id,
    required this.rewardRuleId,
    required this.mccCode,
    required this.matchType,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['reward_rule_id'] = Variable<String>(rewardRuleId);
    map['mcc_code'] = Variable<String>(mccCode);
    map['match_type'] = Variable<String>(matchType);
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  RewardRuleMccsCacheCompanion toCompanion(bool nullToAbsent) {
    return RewardRuleMccsCacheCompanion(
      id: Value(id),
      rewardRuleId: Value(rewardRuleId),
      mccCode: Value(mccCode),
      matchType: Value(matchType),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory RewardRuleMccCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardRuleMccCacheRow(
      id: serializer.fromJson<String>(json['id']),
      rewardRuleId: serializer.fromJson<String>(json['rewardRuleId']),
      mccCode: serializer.fromJson<String>(json['mccCode']),
      matchType: serializer.fromJson<String>(json['matchType']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'rewardRuleId': serializer.toJson<String>(rewardRuleId),
      'mccCode': serializer.toJson<String>(mccCode),
      'matchType': serializer.toJson<String>(matchType),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  RewardRuleMccCacheRow copyWith({
    String? id,
    String? rewardRuleId,
    String? mccCode,
    String? matchType,
    int? datasetVersion,
  }) => RewardRuleMccCacheRow(
    id: id ?? this.id,
    rewardRuleId: rewardRuleId ?? this.rewardRuleId,
    mccCode: mccCode ?? this.mccCode,
    matchType: matchType ?? this.matchType,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  RewardRuleMccCacheRow copyWithCompanion(RewardRuleMccsCacheCompanion data) {
    return RewardRuleMccCacheRow(
      id: data.id.present ? data.id.value : this.id,
      rewardRuleId: data.rewardRuleId.present
          ? data.rewardRuleId.value
          : this.rewardRuleId,
      mccCode: data.mccCode.present ? data.mccCode.value : this.mccCode,
      matchType: data.matchType.present ? data.matchType.value : this.matchType,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardRuleMccCacheRow(')
          ..write('id: $id, ')
          ..write('rewardRuleId: $rewardRuleId, ')
          ..write('mccCode: $mccCode, ')
          ..write('matchType: $matchType, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, rewardRuleId, mccCode, matchType, datasetVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardRuleMccCacheRow &&
          other.id == this.id &&
          other.rewardRuleId == this.rewardRuleId &&
          other.mccCode == this.mccCode &&
          other.matchType == this.matchType &&
          other.datasetVersion == this.datasetVersion);
}

class RewardRuleMccsCacheCompanion
    extends UpdateCompanion<RewardRuleMccCacheRow> {
  final Value<String> id;
  final Value<String> rewardRuleId;
  final Value<String> mccCode;
  final Value<String> matchType;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const RewardRuleMccsCacheCompanion({
    this.id = const Value.absent(),
    this.rewardRuleId = const Value.absent(),
    this.mccCode = const Value.absent(),
    this.matchType = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RewardRuleMccsCacheCompanion.insert({
    required String id,
    required String rewardRuleId,
    required String mccCode,
    required String matchType,
    required int datasetVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       rewardRuleId = Value(rewardRuleId),
       mccCode = Value(mccCode),
       matchType = Value(matchType),
       datasetVersion = Value(datasetVersion);
  static Insertable<RewardRuleMccCacheRow> custom({
    Expression<String>? id,
    Expression<String>? rewardRuleId,
    Expression<String>? mccCode,
    Expression<String>? matchType,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rewardRuleId != null) 'reward_rule_id': rewardRuleId,
      if (mccCode != null) 'mcc_code': mccCode,
      if (matchType != null) 'match_type': matchType,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RewardRuleMccsCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? rewardRuleId,
    Value<String>? mccCode,
    Value<String>? matchType,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return RewardRuleMccsCacheCompanion(
      id: id ?? this.id,
      rewardRuleId: rewardRuleId ?? this.rewardRuleId,
      mccCode: mccCode ?? this.mccCode,
      matchType: matchType ?? this.matchType,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rewardRuleId.present) {
      map['reward_rule_id'] = Variable<String>(rewardRuleId.value);
    }
    if (mccCode.present) {
      map['mcc_code'] = Variable<String>(mccCode.value);
    }
    if (matchType.present) {
      map['match_type'] = Variable<String>(matchType.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardRuleMccsCacheCompanion(')
          ..write('id: $id, ')
          ..write('rewardRuleId: $rewardRuleId, ')
          ..write('mccCode: $mccCode, ')
          ..write('matchType: $matchType, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MerchantMccCandidatesCacheTable extends MerchantMccCandidatesCache
    with
        TableInfo<
          $MerchantMccCandidatesCacheTable,
          MerchantMccCandidateCacheRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantMccCandidatesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantServerIdMeta = const VerificationMeta(
    'merchantServerId',
  );
  @override
  late final GeneratedColumn<String> merchantServerId = GeneratedColumn<String>(
    'merchant_server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantNameMeta = const VerificationMeta(
    'merchantName',
  );
  @override
  late final GeneratedColumn<String> merchantName = GeneratedColumn<String>(
    'merchant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantNameNormalizedMeta =
      const VerificationMeta('merchantNameNormalized');
  @override
  late final GeneratedColumn<String> merchantNameNormalized =
      GeneratedColumn<String>(
        'merchant_name_normalized',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _locationTextMeta = const VerificationMeta(
    'locationText',
  );
  @override
  late final GeneratedColumn<String> locationText = GeneratedColumn<String>(
    'location_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mccCodeMeta = const VerificationMeta(
    'mccCode',
  );
  @override
  late final GeneratedColumn<String> mccCode = GeneratedColumn<String>(
    'mcc_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mccDescriptionMeta = const VerificationMeta(
    'mccDescription',
  );
  @override
  late final GeneratedColumn<String> mccDescription = GeneratedColumn<String>(
    'mcc_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentTypeMeta = const VerificationMeta(
    'paymentType',
  );
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
    'payment_type',
    aliasedName,
    false,
    check: () => paymentType.isIn(const [
      'unknown',
      'in_store',
      'online',
      'shopee_food',
      'grab_food',
      'other',
    ]),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidencePpmMeta = const VerificationMeta(
    'confidencePpm',
  );
  @override
  late final GeneratedColumn<int> confidencePpm = GeneratedColumn<int>(
    'confidence_ppm',
    aliasedName,
    true,
    check: () =>
        confidencePpm.isNull() |
        ComparableExpr(confidencePpm).isBetweenValues(0, 1000000),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    merchantServerId,
    merchantName,
    merchantNameNormalized,
    locationText,
    mccCode,
    mccDescription,
    paymentType,
    source,
    confidencePpm,
    status,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchant_mcc_candidates_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<MerchantMccCandidateCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('merchant_server_id')) {
      context.handle(
        _merchantServerIdMeta,
        merchantServerId.isAcceptableOrUnknown(
          data['merchant_server_id']!,
          _merchantServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantServerIdMeta);
    }
    if (data.containsKey('merchant_name')) {
      context.handle(
        _merchantNameMeta,
        merchantName.isAcceptableOrUnknown(
          data['merchant_name']!,
          _merchantNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantNameMeta);
    }
    if (data.containsKey('merchant_name_normalized')) {
      context.handle(
        _merchantNameNormalizedMeta,
        merchantNameNormalized.isAcceptableOrUnknown(
          data['merchant_name_normalized']!,
          _merchantNameNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantNameNormalizedMeta);
    }
    if (data.containsKey('location_text')) {
      context.handle(
        _locationTextMeta,
        locationText.isAcceptableOrUnknown(
          data['location_text']!,
          _locationTextMeta,
        ),
      );
    }
    if (data.containsKey('mcc_code')) {
      context.handle(
        _mccCodeMeta,
        mccCode.isAcceptableOrUnknown(data['mcc_code']!, _mccCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_mccCodeMeta);
    }
    if (data.containsKey('mcc_description')) {
      context.handle(
        _mccDescriptionMeta,
        mccDescription.isAcceptableOrUnknown(
          data['mcc_description']!,
          _mccDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('payment_type')) {
      context.handle(
        _paymentTypeMeta,
        paymentType.isAcceptableOrUnknown(
          data['payment_type']!,
          _paymentTypeMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('confidence_ppm')) {
      context.handle(
        _confidencePpmMeta,
        confidencePpm.isAcceptableOrUnknown(
          data['confidence_ppm']!,
          _confidencePpmMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MerchantMccCandidateCacheRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MerchantMccCandidateCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      merchantServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_server_id'],
      )!,
      merchantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_name'],
      )!,
      merchantNameNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_name_normalized'],
      )!,
      locationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_text'],
      ),
      mccCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc_code'],
      )!,
      mccDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc_description'],
      ),
      paymentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      confidencePpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence_ppm'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $MerchantMccCandidatesCacheTable createAlias(String alias) {
    return $MerchantMccCandidatesCacheTable(attachedDatabase, alias);
  }
}

class MerchantMccCandidateCacheRow extends DataClass
    implements Insertable<MerchantMccCandidateCacheRow> {
  final String id;
  final String merchantServerId;
  final String merchantName;
  final String merchantNameNormalized;
  final String? locationText;
  final String mccCode;
  final String? mccDescription;
  final String paymentType;
  final String source;
  final int? confidencePpm;
  final String status;
  final int datasetVersion;
  const MerchantMccCandidateCacheRow({
    required this.id,
    required this.merchantServerId,
    required this.merchantName,
    required this.merchantNameNormalized,
    this.locationText,
    required this.mccCode,
    this.mccDescription,
    required this.paymentType,
    required this.source,
    this.confidencePpm,
    required this.status,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['merchant_server_id'] = Variable<String>(merchantServerId);
    map['merchant_name'] = Variable<String>(merchantName);
    map['merchant_name_normalized'] = Variable<String>(merchantNameNormalized);
    if (!nullToAbsent || locationText != null) {
      map['location_text'] = Variable<String>(locationText);
    }
    map['mcc_code'] = Variable<String>(mccCode);
    if (!nullToAbsent || mccDescription != null) {
      map['mcc_description'] = Variable<String>(mccDescription);
    }
    map['payment_type'] = Variable<String>(paymentType);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || confidencePpm != null) {
      map['confidence_ppm'] = Variable<int>(confidencePpm);
    }
    map['status'] = Variable<String>(status);
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  MerchantMccCandidatesCacheCompanion toCompanion(bool nullToAbsent) {
    return MerchantMccCandidatesCacheCompanion(
      id: Value(id),
      merchantServerId: Value(merchantServerId),
      merchantName: Value(merchantName),
      merchantNameNormalized: Value(merchantNameNormalized),
      locationText: locationText == null && nullToAbsent
          ? const Value.absent()
          : Value(locationText),
      mccCode: Value(mccCode),
      mccDescription: mccDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(mccDescription),
      paymentType: Value(paymentType),
      source: Value(source),
      confidencePpm: confidencePpm == null && nullToAbsent
          ? const Value.absent()
          : Value(confidencePpm),
      status: Value(status),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory MerchantMccCandidateCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MerchantMccCandidateCacheRow(
      id: serializer.fromJson<String>(json['id']),
      merchantServerId: serializer.fromJson<String>(json['merchantServerId']),
      merchantName: serializer.fromJson<String>(json['merchantName']),
      merchantNameNormalized: serializer.fromJson<String>(
        json['merchantNameNormalized'],
      ),
      locationText: serializer.fromJson<String?>(json['locationText']),
      mccCode: serializer.fromJson<String>(json['mccCode']),
      mccDescription: serializer.fromJson<String?>(json['mccDescription']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      source: serializer.fromJson<String>(json['source']),
      confidencePpm: serializer.fromJson<int?>(json['confidencePpm']),
      status: serializer.fromJson<String>(json['status']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'merchantServerId': serializer.toJson<String>(merchantServerId),
      'merchantName': serializer.toJson<String>(merchantName),
      'merchantNameNormalized': serializer.toJson<String>(
        merchantNameNormalized,
      ),
      'locationText': serializer.toJson<String?>(locationText),
      'mccCode': serializer.toJson<String>(mccCode),
      'mccDescription': serializer.toJson<String?>(mccDescription),
      'paymentType': serializer.toJson<String>(paymentType),
      'source': serializer.toJson<String>(source),
      'confidencePpm': serializer.toJson<int?>(confidencePpm),
      'status': serializer.toJson<String>(status),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  MerchantMccCandidateCacheRow copyWith({
    String? id,
    String? merchantServerId,
    String? merchantName,
    String? merchantNameNormalized,
    Value<String?> locationText = const Value.absent(),
    String? mccCode,
    Value<String?> mccDescription = const Value.absent(),
    String? paymentType,
    String? source,
    Value<int?> confidencePpm = const Value.absent(),
    String? status,
    int? datasetVersion,
  }) => MerchantMccCandidateCacheRow(
    id: id ?? this.id,
    merchantServerId: merchantServerId ?? this.merchantServerId,
    merchantName: merchantName ?? this.merchantName,
    merchantNameNormalized:
        merchantNameNormalized ?? this.merchantNameNormalized,
    locationText: locationText.present ? locationText.value : this.locationText,
    mccCode: mccCode ?? this.mccCode,
    mccDescription: mccDescription.present
        ? mccDescription.value
        : this.mccDescription,
    paymentType: paymentType ?? this.paymentType,
    source: source ?? this.source,
    confidencePpm: confidencePpm.present
        ? confidencePpm.value
        : this.confidencePpm,
    status: status ?? this.status,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  MerchantMccCandidateCacheRow copyWithCompanion(
    MerchantMccCandidatesCacheCompanion data,
  ) {
    return MerchantMccCandidateCacheRow(
      id: data.id.present ? data.id.value : this.id,
      merchantServerId: data.merchantServerId.present
          ? data.merchantServerId.value
          : this.merchantServerId,
      merchantName: data.merchantName.present
          ? data.merchantName.value
          : this.merchantName,
      merchantNameNormalized: data.merchantNameNormalized.present
          ? data.merchantNameNormalized.value
          : this.merchantNameNormalized,
      locationText: data.locationText.present
          ? data.locationText.value
          : this.locationText,
      mccCode: data.mccCode.present ? data.mccCode.value : this.mccCode,
      mccDescription: data.mccDescription.present
          ? data.mccDescription.value
          : this.mccDescription,
      paymentType: data.paymentType.present
          ? data.paymentType.value
          : this.paymentType,
      source: data.source.present ? data.source.value : this.source,
      confidencePpm: data.confidencePpm.present
          ? data.confidencePpm.value
          : this.confidencePpm,
      status: data.status.present ? data.status.value : this.status,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MerchantMccCandidateCacheRow(')
          ..write('id: $id, ')
          ..write('merchantServerId: $merchantServerId, ')
          ..write('merchantName: $merchantName, ')
          ..write('merchantNameNormalized: $merchantNameNormalized, ')
          ..write('locationText: $locationText, ')
          ..write('mccCode: $mccCode, ')
          ..write('mccDescription: $mccDescription, ')
          ..write('paymentType: $paymentType, ')
          ..write('source: $source, ')
          ..write('confidencePpm: $confidencePpm, ')
          ..write('status: $status, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    merchantServerId,
    merchantName,
    merchantNameNormalized,
    locationText,
    mccCode,
    mccDescription,
    paymentType,
    source,
    confidencePpm,
    status,
    datasetVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MerchantMccCandidateCacheRow &&
          other.id == this.id &&
          other.merchantServerId == this.merchantServerId &&
          other.merchantName == this.merchantName &&
          other.merchantNameNormalized == this.merchantNameNormalized &&
          other.locationText == this.locationText &&
          other.mccCode == this.mccCode &&
          other.mccDescription == this.mccDescription &&
          other.paymentType == this.paymentType &&
          other.source == this.source &&
          other.confidencePpm == this.confidencePpm &&
          other.status == this.status &&
          other.datasetVersion == this.datasetVersion);
}

class MerchantMccCandidatesCacheCompanion
    extends UpdateCompanion<MerchantMccCandidateCacheRow> {
  final Value<String> id;
  final Value<String> merchantServerId;
  final Value<String> merchantName;
  final Value<String> merchantNameNormalized;
  final Value<String?> locationText;
  final Value<String> mccCode;
  final Value<String?> mccDescription;
  final Value<String> paymentType;
  final Value<String> source;
  final Value<int?> confidencePpm;
  final Value<String> status;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const MerchantMccCandidatesCacheCompanion({
    this.id = const Value.absent(),
    this.merchantServerId = const Value.absent(),
    this.merchantName = const Value.absent(),
    this.merchantNameNormalized = const Value.absent(),
    this.locationText = const Value.absent(),
    this.mccCode = const Value.absent(),
    this.mccDescription = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.source = const Value.absent(),
    this.confidencePpm = const Value.absent(),
    this.status = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MerchantMccCandidatesCacheCompanion.insert({
    required String id,
    required String merchantServerId,
    required String merchantName,
    required String merchantNameNormalized,
    this.locationText = const Value.absent(),
    required String mccCode,
    this.mccDescription = const Value.absent(),
    this.paymentType = const Value.absent(),
    required String source,
    this.confidencePpm = const Value.absent(),
    required String status,
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       merchantServerId = Value(merchantServerId),
       merchantName = Value(merchantName),
       merchantNameNormalized = Value(merchantNameNormalized),
       mccCode = Value(mccCode),
       source = Value(source),
       status = Value(status);
  static Insertable<MerchantMccCandidateCacheRow> custom({
    Expression<String>? id,
    Expression<String>? merchantServerId,
    Expression<String>? merchantName,
    Expression<String>? merchantNameNormalized,
    Expression<String>? locationText,
    Expression<String>? mccCode,
    Expression<String>? mccDescription,
    Expression<String>? paymentType,
    Expression<String>? source,
    Expression<int>? confidencePpm,
    Expression<String>? status,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (merchantServerId != null) 'merchant_server_id': merchantServerId,
      if (merchantName != null) 'merchant_name': merchantName,
      if (merchantNameNormalized != null)
        'merchant_name_normalized': merchantNameNormalized,
      if (locationText != null) 'location_text': locationText,
      if (mccCode != null) 'mcc_code': mccCode,
      if (mccDescription != null) 'mcc_description': mccDescription,
      if (paymentType != null) 'payment_type': paymentType,
      if (source != null) 'source': source,
      if (confidencePpm != null) 'confidence_ppm': confidencePpm,
      if (status != null) 'status': status,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MerchantMccCandidatesCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? merchantServerId,
    Value<String>? merchantName,
    Value<String>? merchantNameNormalized,
    Value<String?>? locationText,
    Value<String>? mccCode,
    Value<String?>? mccDescription,
    Value<String>? paymentType,
    Value<String>? source,
    Value<int?>? confidencePpm,
    Value<String>? status,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return MerchantMccCandidatesCacheCompanion(
      id: id ?? this.id,
      merchantServerId: merchantServerId ?? this.merchantServerId,
      merchantName: merchantName ?? this.merchantName,
      merchantNameNormalized:
          merchantNameNormalized ?? this.merchantNameNormalized,
      locationText: locationText ?? this.locationText,
      mccCode: mccCode ?? this.mccCode,
      mccDescription: mccDescription ?? this.mccDescription,
      paymentType: paymentType ?? this.paymentType,
      source: source ?? this.source,
      confidencePpm: confidencePpm ?? this.confidencePpm,
      status: status ?? this.status,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (merchantServerId.present) {
      map['merchant_server_id'] = Variable<String>(merchantServerId.value);
    }
    if (merchantName.present) {
      map['merchant_name'] = Variable<String>(merchantName.value);
    }
    if (merchantNameNormalized.present) {
      map['merchant_name_normalized'] = Variable<String>(
        merchantNameNormalized.value,
      );
    }
    if (locationText.present) {
      map['location_text'] = Variable<String>(locationText.value);
    }
    if (mccCode.present) {
      map['mcc_code'] = Variable<String>(mccCode.value);
    }
    if (mccDescription.present) {
      map['mcc_description'] = Variable<String>(mccDescription.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (confidencePpm.present) {
      map['confidence_ppm'] = Variable<int>(confidencePpm.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MerchantMccCandidatesCacheCompanion(')
          ..write('id: $id, ')
          ..write('merchantServerId: $merchantServerId, ')
          ..write('merchantName: $merchantName, ')
          ..write('merchantNameNormalized: $merchantNameNormalized, ')
          ..write('locationText: $locationText, ')
          ..write('mccCode: $mccCode, ')
          ..write('mccDescription: $mccDescription, ')
          ..write('paymentType: $paymentType, ')
          ..write('source: $source, ')
          ..write('confidencePpm: $confidencePpm, ')
          ..write('status: $status, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MerchantBranchesCacheTable extends MerchantBranchesCache
    with TableInfo<$MerchantBranchesCacheTable, MerchantBranchCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantBranchesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameNormalizedMeta = const VerificationMeta(
    'nameNormalized',
  );
  @override
  late final GeneratedColumn<String> nameNormalized = GeneratedColumn<String>(
    'name_normalized',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationTextMeta = const VerificationMeta(
    'locationText',
  );
  @override
  late final GeneratedColumn<String> locationText = GeneratedColumn<String>(
    'location_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameNormalized,
    locationText,
    datasetVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchant_branches_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<MerchantBranchCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_normalized')) {
      context.handle(
        _nameNormalizedMeta,
        nameNormalized.isAcceptableOrUnknown(
          data['name_normalized']!,
          _nameNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameNormalizedMeta);
    }
    if (data.containsKey('location_text')) {
      context.handle(
        _locationTextMeta,
        locationText.isAcceptableOrUnknown(
          data['location_text']!,
          _locationTextMeta,
        ),
      );
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MerchantBranchCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MerchantBranchCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_normalized'],
      )!,
      locationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_text'],
      ),
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
    );
  }

  @override
  $MerchantBranchesCacheTable createAlias(String alias) {
    return $MerchantBranchesCacheTable(attachedDatabase, alias);
  }
}

class MerchantBranchCacheRow extends DataClass
    implements Insertable<MerchantBranchCacheRow> {
  final String id;
  final String name;
  final String nameNormalized;
  final String? locationText;
  final int datasetVersion;
  const MerchantBranchCacheRow({
    required this.id,
    required this.name,
    required this.nameNormalized,
    this.locationText,
    required this.datasetVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['name_normalized'] = Variable<String>(nameNormalized);
    if (!nullToAbsent || locationText != null) {
      map['location_text'] = Variable<String>(locationText);
    }
    map['dataset_version'] = Variable<int>(datasetVersion);
    return map;
  }

  MerchantBranchesCacheCompanion toCompanion(bool nullToAbsent) {
    return MerchantBranchesCacheCompanion(
      id: Value(id),
      name: Value(name),
      nameNormalized: Value(nameNormalized),
      locationText: locationText == null && nullToAbsent
          ? const Value.absent()
          : Value(locationText),
      datasetVersion: Value(datasetVersion),
    );
  }

  factory MerchantBranchCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MerchantBranchCacheRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameNormalized: serializer.fromJson<String>(json['nameNormalized']),
      locationText: serializer.fromJson<String?>(json['locationText']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'nameNormalized': serializer.toJson<String>(nameNormalized),
      'locationText': serializer.toJson<String?>(locationText),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
    };
  }

  MerchantBranchCacheRow copyWith({
    String? id,
    String? name,
    String? nameNormalized,
    Value<String?> locationText = const Value.absent(),
    int? datasetVersion,
  }) => MerchantBranchCacheRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameNormalized: nameNormalized ?? this.nameNormalized,
    locationText: locationText.present ? locationText.value : this.locationText,
    datasetVersion: datasetVersion ?? this.datasetVersion,
  );
  MerchantBranchCacheRow copyWithCompanion(
    MerchantBranchesCacheCompanion data,
  ) {
    return MerchantBranchCacheRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameNormalized: data.nameNormalized.present
          ? data.nameNormalized.value
          : this.nameNormalized,
      locationText: data.locationText.present
          ? data.locationText.value
          : this.locationText,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MerchantBranchCacheRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('locationText: $locationText, ')
          ..write('datasetVersion: $datasetVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, nameNormalized, locationText, datasetVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MerchantBranchCacheRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameNormalized == this.nameNormalized &&
          other.locationText == this.locationText &&
          other.datasetVersion == this.datasetVersion);
}

class MerchantBranchesCacheCompanion
    extends UpdateCompanion<MerchantBranchCacheRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> nameNormalized;
  final Value<String?> locationText;
  final Value<int> datasetVersion;
  final Value<int> rowid;
  const MerchantBranchesCacheCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameNormalized = const Value.absent(),
    this.locationText = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MerchantBranchesCacheCompanion.insert({
    required String id,
    required String name,
    required String nameNormalized,
    this.locationText = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       nameNormalized = Value(nameNormalized);
  static Insertable<MerchantBranchCacheRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? nameNormalized,
    Expression<String>? locationText,
    Expression<int>? datasetVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameNormalized != null) 'name_normalized': nameNormalized,
      if (locationText != null) 'location_text': locationText,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MerchantBranchesCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? nameNormalized,
    Value<String?>? locationText,
    Value<int>? datasetVersion,
    Value<int>? rowid,
  }) {
    return MerchantBranchesCacheCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameNormalized: nameNormalized ?? this.nameNormalized,
      locationText: locationText ?? this.locationText,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameNormalized.present) {
      map['name_normalized'] = Variable<String>(nameNormalized.value);
    }
    if (locationText.present) {
      map['location_text'] = Variable<String>(locationText.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MerchantBranchesCacheCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('locationText: $locationText, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUserCardsTable extends LocalUserCards
    with TableInfo<$LocalUserCardsTable, LocalUserCardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUserCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _creditCardIdMeta = const VerificationMeta(
    'creditCardId',
  );
  @override
  late final GeneratedColumn<String> creditCardId = GeneratedColumn<String>(
    'credit_card_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedColumn<String> bankId = GeneratedColumn<String>(
    'bank_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankNameSnapshotMeta = const VerificationMeta(
    'bankNameSnapshot',
  );
  @override
  late final GeneratedColumn<String> bankNameSnapshot = GeneratedColumn<String>(
    'bank_name_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billingCycleDayMeta = const VerificationMeta(
    'billingCycleDay',
  );
  @override
  late final GeneratedColumn<int> billingCycleDay = GeneratedColumn<int>(
    'billing_cycle_day',
    aliasedName,
    false,
    check: () => ComparableExpr(billingCycleDay).isBetweenValues(1, 31),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditLimitMinorMeta = const VerificationMeta(
    'creditLimitMinor',
  );
  @override
  late final GeneratedColumn<int> creditLimitMinor = GeneratedColumn<int>(
    'credit_limit_minor',
    aliasedName,
    false,
    check: () => ComparableExpr(creditLimitMinor).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hasAnnualFeeMeta = const VerificationMeta(
    'hasAnnualFee',
  );
  @override
  late final GeneratedColumn<bool> hasAnnualFee = GeneratedColumn<bool>(
    'has_annual_fee',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_annual_fee" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMsMeta = const VerificationMeta(
    'deletedAtMs',
  );
  @override
  late final GeneratedColumn<int> deletedAtMs = GeneratedColumn<int>(
    'deleted_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    check: () => syncStatus.isIn(const [
      'local_only',
      'pending',
      'synced',
      'failed',
      'conflict',
    ]),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local_only'),
  );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<int> serverVersion = GeneratedColumn<int>(
    'server_version',
    aliasedName,
    true,
    check: () =>
        serverVersion.isNull() |
        ComparableExpr(serverVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMsMeta = const VerificationMeta(
    'lastSyncedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAtMs = GeneratedColumn<int>(
    'last_synced_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    creditCardId,
    bankId,
    bankNameSnapshot,
    nickname,
    billingCycleDay,
    creditLimitMinor,
    isDefault,
    hasAnnualFee,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_user_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUserCardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('credit_card_id')) {
      context.handle(
        _creditCardIdMeta,
        creditCardId.isAcceptableOrUnknown(
          data['credit_card_id']!,
          _creditCardIdMeta,
        ),
      );
    }
    if (data.containsKey('bank_id')) {
      context.handle(
        _bankIdMeta,
        bankId.isAcceptableOrUnknown(data['bank_id']!, _bankIdMeta),
      );
    }
    if (data.containsKey('bank_name_snapshot')) {
      context.handle(
        _bankNameSnapshotMeta,
        bankNameSnapshot.isAcceptableOrUnknown(
          data['bank_name_snapshot']!,
          _bankNameSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bankNameSnapshotMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('billing_cycle_day')) {
      context.handle(
        _billingCycleDayMeta,
        billingCycleDay.isAcceptableOrUnknown(
          data['billing_cycle_day']!,
          _billingCycleDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingCycleDayMeta);
    }
    if (data.containsKey('credit_limit_minor')) {
      context.handle(
        _creditLimitMinorMeta,
        creditLimitMinor.isAcceptableOrUnknown(
          data['credit_limit_minor']!,
          _creditLimitMinorMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('has_annual_fee')) {
      context.handle(
        _hasAnnualFeeMeta,
        hasAnnualFee.isAcceptableOrUnknown(
          data['has_annual_fee']!,
          _hasAnnualFeeMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('deleted_at_ms')) {
      context.handle(
        _deletedAtMsMeta,
        deletedAtMs.isAcceptableOrUnknown(
          data['deleted_at_ms']!,
          _deletedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at_ms')) {
      context.handle(
        _lastSyncedAtMsMeta,
        lastSyncedAtMs.isAcceptableOrUnknown(
          data['last_synced_at_ms']!,
          _lastSyncedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUserCardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUserCardRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      creditCardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_card_id'],
      ),
      bankId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_id'],
      ),
      bankNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name_snapshot'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      )!,
      billingCycleDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_cycle_day'],
      )!,
      creditLimitMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_limit_minor'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      hasAnnualFee: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_annual_fee'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      deletedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_ms'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version'],
      ),
      lastSyncedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at_ms'],
      ),
    );
  }

  @override
  $LocalUserCardsTable createAlias(String alias) {
    return $LocalUserCardsTable(attachedDatabase, alias);
  }
}

class LocalUserCardRow extends DataClass
    implements Insertable<LocalUserCardRow> {
  final String id;
  final String profileId;
  final String? creditCardId;
  final String? bankId;
  final String bankNameSnapshot;
  final String nickname;
  final int billingCycleDay;
  final int creditLimitMinor;
  final bool isDefault;
  final bool hasAnnualFee;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  final String syncStatus;
  final int? serverVersion;
  final int? lastSyncedAtMs;
  const LocalUserCardRow({
    required this.id,
    required this.profileId,
    this.creditCardId,
    this.bankId,
    required this.bankNameSnapshot,
    required this.nickname,
    required this.billingCycleDay,
    required this.creditLimitMinor,
    required this.isDefault,
    required this.hasAnnualFee,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
    required this.syncStatus,
    this.serverVersion,
    this.lastSyncedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || creditCardId != null) {
      map['credit_card_id'] = Variable<String>(creditCardId);
    }
    if (!nullToAbsent || bankId != null) {
      map['bank_id'] = Variable<String>(bankId);
    }
    map['bank_name_snapshot'] = Variable<String>(bankNameSnapshot);
    map['nickname'] = Variable<String>(nickname);
    map['billing_cycle_day'] = Variable<int>(billingCycleDay);
    map['credit_limit_minor'] = Variable<int>(creditLimitMinor);
    map['is_default'] = Variable<bool>(isDefault);
    map['has_annual_fee'] = Variable<bool>(hasAnnualFee);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    if (!nullToAbsent || deletedAtMs != null) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || serverVersion != null) {
      map['server_version'] = Variable<int>(serverVersion);
    }
    if (!nullToAbsent || lastSyncedAtMs != null) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs);
    }
    return map;
  }

  LocalUserCardsCompanion toCompanion(bool nullToAbsent) {
    return LocalUserCardsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      creditCardId: creditCardId == null && nullToAbsent
          ? const Value.absent()
          : Value(creditCardId),
      bankId: bankId == null && nullToAbsent
          ? const Value.absent()
          : Value(bankId),
      bankNameSnapshot: Value(bankNameSnapshot),
      nickname: Value(nickname),
      billingCycleDay: Value(billingCycleDay),
      creditLimitMinor: Value(creditLimitMinor),
      isDefault: Value(isDefault),
      hasAnnualFee: Value(hasAnnualFee),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      deletedAtMs: deletedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtMs),
      syncStatus: Value(syncStatus),
      serverVersion: serverVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(serverVersion),
      lastSyncedAtMs: lastSyncedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAtMs),
    );
  }

  factory LocalUserCardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUserCardRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      creditCardId: serializer.fromJson<String?>(json['creditCardId']),
      bankId: serializer.fromJson<String?>(json['bankId']),
      bankNameSnapshot: serializer.fromJson<String>(json['bankNameSnapshot']),
      nickname: serializer.fromJson<String>(json['nickname']),
      billingCycleDay: serializer.fromJson<int>(json['billingCycleDay']),
      creditLimitMinor: serializer.fromJson<int>(json['creditLimitMinor']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      hasAnnualFee: serializer.fromJson<bool>(json['hasAnnualFee']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      deletedAtMs: serializer.fromJson<int?>(json['deletedAtMs']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      serverVersion: serializer.fromJson<int?>(json['serverVersion']),
      lastSyncedAtMs: serializer.fromJson<int?>(json['lastSyncedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'creditCardId': serializer.toJson<String?>(creditCardId),
      'bankId': serializer.toJson<String?>(bankId),
      'bankNameSnapshot': serializer.toJson<String>(bankNameSnapshot),
      'nickname': serializer.toJson<String>(nickname),
      'billingCycleDay': serializer.toJson<int>(billingCycleDay),
      'creditLimitMinor': serializer.toJson<int>(creditLimitMinor),
      'isDefault': serializer.toJson<bool>(isDefault),
      'hasAnnualFee': serializer.toJson<bool>(hasAnnualFee),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'deletedAtMs': serializer.toJson<int?>(deletedAtMs),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'serverVersion': serializer.toJson<int?>(serverVersion),
      'lastSyncedAtMs': serializer.toJson<int?>(lastSyncedAtMs),
    };
  }

  LocalUserCardRow copyWith({
    String? id,
    String? profileId,
    Value<String?> creditCardId = const Value.absent(),
    Value<String?> bankId = const Value.absent(),
    String? bankNameSnapshot,
    String? nickname,
    int? billingCycleDay,
    int? creditLimitMinor,
    bool? isDefault,
    bool? hasAnnualFee,
    int? createdAtMs,
    int? updatedAtMs,
    Value<int?> deletedAtMs = const Value.absent(),
    String? syncStatus,
    Value<int?> serverVersion = const Value.absent(),
    Value<int?> lastSyncedAtMs = const Value.absent(),
  }) => LocalUserCardRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    creditCardId: creditCardId.present ? creditCardId.value : this.creditCardId,
    bankId: bankId.present ? bankId.value : this.bankId,
    bankNameSnapshot: bankNameSnapshot ?? this.bankNameSnapshot,
    nickname: nickname ?? this.nickname,
    billingCycleDay: billingCycleDay ?? this.billingCycleDay,
    creditLimitMinor: creditLimitMinor ?? this.creditLimitMinor,
    isDefault: isDefault ?? this.isDefault,
    hasAnnualFee: hasAnnualFee ?? this.hasAnnualFee,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    deletedAtMs: deletedAtMs.present ? deletedAtMs.value : this.deletedAtMs,
    syncStatus: syncStatus ?? this.syncStatus,
    serverVersion: serverVersion.present
        ? serverVersion.value
        : this.serverVersion,
    lastSyncedAtMs: lastSyncedAtMs.present
        ? lastSyncedAtMs.value
        : this.lastSyncedAtMs,
  );
  LocalUserCardRow copyWithCompanion(LocalUserCardsCompanion data) {
    return LocalUserCardRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      creditCardId: data.creditCardId.present
          ? data.creditCardId.value
          : this.creditCardId,
      bankId: data.bankId.present ? data.bankId.value : this.bankId,
      bankNameSnapshot: data.bankNameSnapshot.present
          ? data.bankNameSnapshot.value
          : this.bankNameSnapshot,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      billingCycleDay: data.billingCycleDay.present
          ? data.billingCycleDay.value
          : this.billingCycleDay,
      creditLimitMinor: data.creditLimitMinor.present
          ? data.creditLimitMinor.value
          : this.creditLimitMinor,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      hasAnnualFee: data.hasAnnualFee.present
          ? data.hasAnnualFee.value
          : this.hasAnnualFee,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      deletedAtMs: data.deletedAtMs.present
          ? data.deletedAtMs.value
          : this.deletedAtMs,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      lastSyncedAtMs: data.lastSyncedAtMs.present
          ? data.lastSyncedAtMs.value
          : this.lastSyncedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserCardRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('creditCardId: $creditCardId, ')
          ..write('bankId: $bankId, ')
          ..write('bankNameSnapshot: $bankNameSnapshot, ')
          ..write('nickname: $nickname, ')
          ..write('billingCycleDay: $billingCycleDay, ')
          ..write('creditLimitMinor: $creditLimitMinor, ')
          ..write('isDefault: $isDefault, ')
          ..write('hasAnnualFee: $hasAnnualFee, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    creditCardId,
    bankId,
    bankNameSnapshot,
    nickname,
    billingCycleDay,
    creditLimitMinor,
    isDefault,
    hasAnnualFee,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUserCardRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.creditCardId == this.creditCardId &&
          other.bankId == this.bankId &&
          other.bankNameSnapshot == this.bankNameSnapshot &&
          other.nickname == this.nickname &&
          other.billingCycleDay == this.billingCycleDay &&
          other.creditLimitMinor == this.creditLimitMinor &&
          other.isDefault == this.isDefault &&
          other.hasAnnualFee == this.hasAnnualFee &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.deletedAtMs == this.deletedAtMs &&
          other.syncStatus == this.syncStatus &&
          other.serverVersion == this.serverVersion &&
          other.lastSyncedAtMs == this.lastSyncedAtMs);
}

class LocalUserCardsCompanion extends UpdateCompanion<LocalUserCardRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String?> creditCardId;
  final Value<String?> bankId;
  final Value<String> bankNameSnapshot;
  final Value<String> nickname;
  final Value<int> billingCycleDay;
  final Value<int> creditLimitMinor;
  final Value<bool> isDefault;
  final Value<bool> hasAnnualFee;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int?> deletedAtMs;
  final Value<String> syncStatus;
  final Value<int?> serverVersion;
  final Value<int?> lastSyncedAtMs;
  final Value<int> rowid;
  const LocalUserCardsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.creditCardId = const Value.absent(),
    this.bankId = const Value.absent(),
    this.bankNameSnapshot = const Value.absent(),
    this.nickname = const Value.absent(),
    this.billingCycleDay = const Value.absent(),
    this.creditLimitMinor = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.hasAnnualFee = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUserCardsCompanion.insert({
    required String id,
    required String profileId,
    this.creditCardId = const Value.absent(),
    this.bankId = const Value.absent(),
    required String bankNameSnapshot,
    required String nickname,
    required int billingCycleDay,
    this.creditLimitMinor = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.hasAnnualFee = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       bankNameSnapshot = Value(bankNameSnapshot),
       nickname = Value(nickname),
       billingCycleDay = Value(billingCycleDay),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LocalUserCardRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? creditCardId,
    Expression<String>? bankId,
    Expression<String>? bankNameSnapshot,
    Expression<String>? nickname,
    Expression<int>? billingCycleDay,
    Expression<int>? creditLimitMinor,
    Expression<bool>? isDefault,
    Expression<bool>? hasAnnualFee,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? deletedAtMs,
    Expression<String>? syncStatus,
    Expression<int>? serverVersion,
    Expression<int>? lastSyncedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (creditCardId != null) 'credit_card_id': creditCardId,
      if (bankId != null) 'bank_id': bankId,
      if (bankNameSnapshot != null) 'bank_name_snapshot': bankNameSnapshot,
      if (nickname != null) 'nickname': nickname,
      if (billingCycleDay != null) 'billing_cycle_day': billingCycleDay,
      if (creditLimitMinor != null) 'credit_limit_minor': creditLimitMinor,
      if (isDefault != null) 'is_default': isDefault,
      if (hasAnnualFee != null) 'has_annual_fee': hasAnnualFee,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (deletedAtMs != null) 'deleted_at_ms': deletedAtMs,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (serverVersion != null) 'server_version': serverVersion,
      if (lastSyncedAtMs != null) 'last_synced_at_ms': lastSyncedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUserCardsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String?>? creditCardId,
    Value<String?>? bankId,
    Value<String>? bankNameSnapshot,
    Value<String>? nickname,
    Value<int>? billingCycleDay,
    Value<int>? creditLimitMinor,
    Value<bool>? isDefault,
    Value<bool>? hasAnnualFee,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int?>? deletedAtMs,
    Value<String>? syncStatus,
    Value<int?>? serverVersion,
    Value<int?>? lastSyncedAtMs,
    Value<int>? rowid,
  }) {
    return LocalUserCardsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      creditCardId: creditCardId ?? this.creditCardId,
      bankId: bankId ?? this.bankId,
      bankNameSnapshot: bankNameSnapshot ?? this.bankNameSnapshot,
      nickname: nickname ?? this.nickname,
      billingCycleDay: billingCycleDay ?? this.billingCycleDay,
      creditLimitMinor: creditLimitMinor ?? this.creditLimitMinor,
      isDefault: isDefault ?? this.isDefault,
      hasAnnualFee: hasAnnualFee ?? this.hasAnnualFee,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      deletedAtMs: deletedAtMs ?? this.deletedAtMs,
      syncStatus: syncStatus ?? this.syncStatus,
      serverVersion: serverVersion ?? this.serverVersion,
      lastSyncedAtMs: lastSyncedAtMs ?? this.lastSyncedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (creditCardId.present) {
      map['credit_card_id'] = Variable<String>(creditCardId.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (bankNameSnapshot.present) {
      map['bank_name_snapshot'] = Variable<String>(bankNameSnapshot.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (billingCycleDay.present) {
      map['billing_cycle_day'] = Variable<int>(billingCycleDay.value);
    }
    if (creditLimitMinor.present) {
      map['credit_limit_minor'] = Variable<int>(creditLimitMinor.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (hasAnnualFee.present) {
      map['has_annual_fee'] = Variable<bool>(hasAnnualFee.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (deletedAtMs.present) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<int>(serverVersion.value);
    }
    if (lastSyncedAtMs.present) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUserCardsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('creditCardId: $creditCardId, ')
          ..write('bankId: $bankId, ')
          ..write('bankNameSnapshot: $bankNameSnapshot, ')
          ..write('nickname: $nickname, ')
          ..write('billingCycleDay: $billingCycleDay, ')
          ..write('creditLimitMinor: $creditLimitMinor, ')
          ..write('isDefault: $isDefault, ')
          ..write('hasAnnualFee: $hasAnnualFee, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalMerchantMccContributionsTable extends LocalMerchantMccContributions
    with
        TableInfo<
          $LocalMerchantMccContributionsTable,
          LocalMerchantMccContributionRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMerchantMccContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _merchantServerIdMeta = const VerificationMeta(
    'merchantServerId',
  );
  @override
  late final GeneratedColumn<String> merchantServerId = GeneratedColumn<String>(
    'merchant_server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantNameSnapshotMeta =
      const VerificationMeta('merchantNameSnapshot');
  @override
  late final GeneratedColumn<String> merchantNameSnapshot =
      GeneratedColumn<String>(
        'merchant_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _locationTextMeta = const VerificationMeta(
    'locationText',
  );
  @override
  late final GeneratedColumn<String> locationText = GeneratedColumn<String>(
    'location_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mccCodeMeta = const VerificationMeta(
    'mccCode',
  );
  @override
  late final GeneratedColumn<String> mccCode = GeneratedColumn<String>(
    'mcc_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mccDescriptionSnapshotMeta =
      const VerificationMeta('mccDescriptionSnapshot');
  @override
  late final GeneratedColumn<String> mccDescriptionSnapshot =
      GeneratedColumn<String>(
        'mcc_description_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _paymentTypeMeta = const VerificationMeta(
    'paymentType',
  );
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
    'payment_type',
    aliasedName,
    false,
    check: () => paymentType.isIn(const [
      'unknown',
      'in_store',
      'online',
      'shopee_food',
      'grab_food',
      'other',
    ]),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    merchantServerId,
    merchantNameSnapshot,
    locationText,
    mccCode,
    mccDescriptionSnapshot,
    paymentType,
    note,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_merchant_mcc_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalMerchantMccContributionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('merchant_server_id')) {
      context.handle(
        _merchantServerIdMeta,
        merchantServerId.isAcceptableOrUnknown(
          data['merchant_server_id']!,
          _merchantServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantServerIdMeta);
    }
    if (data.containsKey('merchant_name_snapshot')) {
      context.handle(
        _merchantNameSnapshotMeta,
        merchantNameSnapshot.isAcceptableOrUnknown(
          data['merchant_name_snapshot']!,
          _merchantNameSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantNameSnapshotMeta);
    }
    if (data.containsKey('location_text')) {
      context.handle(
        _locationTextMeta,
        locationText.isAcceptableOrUnknown(
          data['location_text']!,
          _locationTextMeta,
        ),
      );
    }
    if (data.containsKey('mcc_code')) {
      context.handle(
        _mccCodeMeta,
        mccCode.isAcceptableOrUnknown(data['mcc_code']!, _mccCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_mccCodeMeta);
    }
    if (data.containsKey('mcc_description_snapshot')) {
      context.handle(
        _mccDescriptionSnapshotMeta,
        mccDescriptionSnapshot.isAcceptableOrUnknown(
          data['mcc_description_snapshot']!,
          _mccDescriptionSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('payment_type')) {
      context.handle(
        _paymentTypeMeta,
        paymentType.isAcceptableOrUnknown(
          data['payment_type']!,
          _paymentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentTypeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {profileId, merchantServerId, mccCode, paymentType},
  ];
  @override
  LocalMerchantMccContributionRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMerchantMccContributionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      merchantServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_server_id'],
      )!,
      merchantNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_name_snapshot'],
      )!,
      locationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_text'],
      ),
      mccCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc_code'],
      )!,
      mccDescriptionSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc_description_snapshot'],
      ),
      paymentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_type'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $LocalMerchantMccContributionsTable createAlias(String alias) {
    return $LocalMerchantMccContributionsTable(attachedDatabase, alias);
  }
}

class LocalMerchantMccContributionRow extends DataClass
    implements Insertable<LocalMerchantMccContributionRow> {
  final String id;
  final String profileId;
  final String merchantServerId;
  final String merchantNameSnapshot;
  final String? locationText;
  final String mccCode;
  final String? mccDescriptionSnapshot;
  final String paymentType;
  final String? note;
  final int createdAtMs;
  final int updatedAtMs;
  const LocalMerchantMccContributionRow({
    required this.id,
    required this.profileId,
    required this.merchantServerId,
    required this.merchantNameSnapshot,
    this.locationText,
    required this.mccCode,
    this.mccDescriptionSnapshot,
    required this.paymentType,
    this.note,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['merchant_server_id'] = Variable<String>(merchantServerId);
    map['merchant_name_snapshot'] = Variable<String>(merchantNameSnapshot);
    if (!nullToAbsent || locationText != null) {
      map['location_text'] = Variable<String>(locationText);
    }
    map['mcc_code'] = Variable<String>(mccCode);
    if (!nullToAbsent || mccDescriptionSnapshot != null) {
      map['mcc_description_snapshot'] = Variable<String>(
        mccDescriptionSnapshot,
      );
    }
    map['payment_type'] = Variable<String>(paymentType);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  LocalMerchantMccContributionsCompanion toCompanion(bool nullToAbsent) {
    return LocalMerchantMccContributionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      merchantServerId: Value(merchantServerId),
      merchantNameSnapshot: Value(merchantNameSnapshot),
      locationText: locationText == null && nullToAbsent
          ? const Value.absent()
          : Value(locationText),
      mccCode: Value(mccCode),
      mccDescriptionSnapshot: mccDescriptionSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(mccDescriptionSnapshot),
      paymentType: Value(paymentType),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory LocalMerchantMccContributionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMerchantMccContributionRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      merchantServerId: serializer.fromJson<String>(json['merchantServerId']),
      merchantNameSnapshot: serializer.fromJson<String>(
        json['merchantNameSnapshot'],
      ),
      locationText: serializer.fromJson<String?>(json['locationText']),
      mccCode: serializer.fromJson<String>(json['mccCode']),
      mccDescriptionSnapshot: serializer.fromJson<String?>(
        json['mccDescriptionSnapshot'],
      ),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      note: serializer.fromJson<String?>(json['note']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'merchantServerId': serializer.toJson<String>(merchantServerId),
      'merchantNameSnapshot': serializer.toJson<String>(merchantNameSnapshot),
      'locationText': serializer.toJson<String?>(locationText),
      'mccCode': serializer.toJson<String>(mccCode),
      'mccDescriptionSnapshot': serializer.toJson<String?>(
        mccDescriptionSnapshot,
      ),
      'paymentType': serializer.toJson<String>(paymentType),
      'note': serializer.toJson<String?>(note),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  LocalMerchantMccContributionRow copyWith({
    String? id,
    String? profileId,
    String? merchantServerId,
    String? merchantNameSnapshot,
    Value<String?> locationText = const Value.absent(),
    String? mccCode,
    Value<String?> mccDescriptionSnapshot = const Value.absent(),
    String? paymentType,
    Value<String?> note = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
  }) => LocalMerchantMccContributionRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    merchantServerId: merchantServerId ?? this.merchantServerId,
    merchantNameSnapshot: merchantNameSnapshot ?? this.merchantNameSnapshot,
    locationText: locationText.present ? locationText.value : this.locationText,
    mccCode: mccCode ?? this.mccCode,
    mccDescriptionSnapshot: mccDescriptionSnapshot.present
        ? mccDescriptionSnapshot.value
        : this.mccDescriptionSnapshot,
    paymentType: paymentType ?? this.paymentType,
    note: note.present ? note.value : this.note,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  LocalMerchantMccContributionRow copyWithCompanion(
    LocalMerchantMccContributionsCompanion data,
  ) {
    return LocalMerchantMccContributionRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      merchantServerId: data.merchantServerId.present
          ? data.merchantServerId.value
          : this.merchantServerId,
      merchantNameSnapshot: data.merchantNameSnapshot.present
          ? data.merchantNameSnapshot.value
          : this.merchantNameSnapshot,
      locationText: data.locationText.present
          ? data.locationText.value
          : this.locationText,
      mccCode: data.mccCode.present ? data.mccCode.value : this.mccCode,
      mccDescriptionSnapshot: data.mccDescriptionSnapshot.present
          ? data.mccDescriptionSnapshot.value
          : this.mccDescriptionSnapshot,
      paymentType: data.paymentType.present
          ? data.paymentType.value
          : this.paymentType,
      note: data.note.present ? data.note.value : this.note,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMerchantMccContributionRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('merchantServerId: $merchantServerId, ')
          ..write('merchantNameSnapshot: $merchantNameSnapshot, ')
          ..write('locationText: $locationText, ')
          ..write('mccCode: $mccCode, ')
          ..write('mccDescriptionSnapshot: $mccDescriptionSnapshot, ')
          ..write('paymentType: $paymentType, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    merchantServerId,
    merchantNameSnapshot,
    locationText,
    mccCode,
    mccDescriptionSnapshot,
    paymentType,
    note,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMerchantMccContributionRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.merchantServerId == this.merchantServerId &&
          other.merchantNameSnapshot == this.merchantNameSnapshot &&
          other.locationText == this.locationText &&
          other.mccCode == this.mccCode &&
          other.mccDescriptionSnapshot == this.mccDescriptionSnapshot &&
          other.paymentType == this.paymentType &&
          other.note == this.note &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class LocalMerchantMccContributionsCompanion
    extends UpdateCompanion<LocalMerchantMccContributionRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> merchantServerId;
  final Value<String> merchantNameSnapshot;
  final Value<String?> locationText;
  final Value<String> mccCode;
  final Value<String?> mccDescriptionSnapshot;
  final Value<String> paymentType;
  final Value<String?> note;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const LocalMerchantMccContributionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.merchantServerId = const Value.absent(),
    this.merchantNameSnapshot = const Value.absent(),
    this.locationText = const Value.absent(),
    this.mccCode = const Value.absent(),
    this.mccDescriptionSnapshot = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalMerchantMccContributionsCompanion.insert({
    required String id,
    required String profileId,
    required String merchantServerId,
    required String merchantNameSnapshot,
    this.locationText = const Value.absent(),
    required String mccCode,
    this.mccDescriptionSnapshot = const Value.absent(),
    required String paymentType,
    this.note = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       merchantServerId = Value(merchantServerId),
       merchantNameSnapshot = Value(merchantNameSnapshot),
       mccCode = Value(mccCode),
       paymentType = Value(paymentType),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LocalMerchantMccContributionRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? merchantServerId,
    Expression<String>? merchantNameSnapshot,
    Expression<String>? locationText,
    Expression<String>? mccCode,
    Expression<String>? mccDescriptionSnapshot,
    Expression<String>? paymentType,
    Expression<String>? note,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (merchantServerId != null) 'merchant_server_id': merchantServerId,
      if (merchantNameSnapshot != null)
        'merchant_name_snapshot': merchantNameSnapshot,
      if (locationText != null) 'location_text': locationText,
      if (mccCode != null) 'mcc_code': mccCode,
      if (mccDescriptionSnapshot != null)
        'mcc_description_snapshot': mccDescriptionSnapshot,
      if (paymentType != null) 'payment_type': paymentType,
      if (note != null) 'note': note,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalMerchantMccContributionsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? merchantServerId,
    Value<String>? merchantNameSnapshot,
    Value<String?>? locationText,
    Value<String>? mccCode,
    Value<String?>? mccDescriptionSnapshot,
    Value<String>? paymentType,
    Value<String?>? note,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return LocalMerchantMccContributionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      merchantServerId: merchantServerId ?? this.merchantServerId,
      merchantNameSnapshot: merchantNameSnapshot ?? this.merchantNameSnapshot,
      locationText: locationText ?? this.locationText,
      mccCode: mccCode ?? this.mccCode,
      mccDescriptionSnapshot:
          mccDescriptionSnapshot ?? this.mccDescriptionSnapshot,
      paymentType: paymentType ?? this.paymentType,
      note: note ?? this.note,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (merchantServerId.present) {
      map['merchant_server_id'] = Variable<String>(merchantServerId.value);
    }
    if (merchantNameSnapshot.present) {
      map['merchant_name_snapshot'] = Variable<String>(
        merchantNameSnapshot.value,
      );
    }
    if (locationText.present) {
      map['location_text'] = Variable<String>(locationText.value);
    }
    if (mccCode.present) {
      map['mcc_code'] = Variable<String>(mccCode.value);
    }
    if (mccDescriptionSnapshot.present) {
      map['mcc_description_snapshot'] = Variable<String>(
        mccDescriptionSnapshot.value,
      );
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMerchantMccContributionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('merchantServerId: $merchantServerId, ')
          ..write('merchantNameSnapshot: $merchantNameSnapshot, ')
          ..write('locationText: $locationText, ')
          ..write('mccCode: $mccCode, ')
          ..write('mccDescriptionSnapshot: $mccDescriptionSnapshot, ')
          ..write('paymentType: $paymentType, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    check: () => operation.isIn(const ['create', 'update', 'delete']),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadVersionMeta = const VerificationMeta(
    'payloadVersion',
  );
  @override
  late final GeneratedColumn<int> payloadVersion = GeneratedColumn<int>(
    'payload_version',
    aliasedName,
    false,
    check: () => ComparableExpr(payloadVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _baseServerVersionMeta = const VerificationMeta(
    'baseServerVersion',
  );
  @override
  late final GeneratedColumn<int> baseServerVersion = GeneratedColumn<int>(
    'base_server_version',
    aliasedName,
    true,
    check: () =>
        baseServerVersion.isNull() |
        ComparableExpr(baseServerVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    check: () => ComparableExpr(attemptCount).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMsMeta = const VerificationMeta(
    'nextAttemptAtMs',
  );
  @override
  late final GeneratedColumn<int> nextAttemptAtMs = GeneratedColumn<int>(
    'next_attempt_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastErrorCodeMeta = const VerificationMeta(
    'lastErrorCode',
  );
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
    'last_error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    entityType,
    entityId,
    operation,
    payloadJson,
    payloadVersion,
    baseServerVersion,
    idempotencyKey,
    attemptCount,
    nextAttemptAtMs,
    lastErrorCode,
    createdAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('payload_version')) {
      context.handle(
        _payloadVersionMeta,
        payloadVersion.isAcceptableOrUnknown(
          data['payload_version']!,
          _payloadVersionMeta,
        ),
      );
    }
    if (data.containsKey('base_server_version')) {
      context.handle(
        _baseServerVersionMeta,
        baseServerVersion.isAcceptableOrUnknown(
          data['base_server_version']!,
          _baseServerVersionMeta,
        ),
      );
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('next_attempt_at_ms')) {
      context.handle(
        _nextAttemptAtMsMeta,
        nextAttemptAtMs.isAcceptableOrUnknown(
          data['next_attempt_at_ms']!,
          _nextAttemptAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextAttemptAtMsMeta);
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
        _lastErrorCodeMeta,
        lastErrorCode.isAcceptableOrUnknown(
          data['last_error_code']!,
          _lastErrorCodeMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      payloadVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payload_version'],
      )!,
      baseServerVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_server_version'],
      ),
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      nextAttemptAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_attempt_at_ms'],
      )!,
      lastErrorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_code'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOutboxRow extends DataClass implements Insertable<SyncOutboxRow> {
  final String id;
  final String profileId;
  final String entityType;
  final String entityId;
  final String operation;
  final String payloadJson;
  final int payloadVersion;
  final int? baseServerVersion;
  final String idempotencyKey;
  final int attemptCount;
  final int nextAttemptAtMs;
  final String? lastErrorCode;
  final int createdAtMs;
  const SyncOutboxRow({
    required this.id,
    required this.profileId,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadJson,
    required this.payloadVersion,
    this.baseServerVersion,
    required this.idempotencyKey,
    required this.attemptCount,
    required this.nextAttemptAtMs,
    this.lastErrorCode,
    required this.createdAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['payload_version'] = Variable<int>(payloadVersion);
    if (!nullToAbsent || baseServerVersion != null) {
      map['base_server_version'] = Variable<int>(baseServerVersion);
    }
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['attempt_count'] = Variable<int>(attemptCount);
    map['next_attempt_at_ms'] = Variable<int>(nextAttemptAtMs);
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      id: Value(id),
      profileId: Value(profileId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      payloadVersion: Value(payloadVersion),
      baseServerVersion: baseServerVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(baseServerVersion),
      idempotencyKey: Value(idempotencyKey),
      attemptCount: Value(attemptCount),
      nextAttemptAtMs: Value(nextAttemptAtMs),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
      createdAtMs: Value(createdAtMs),
    );
  }

  factory SyncOutboxRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      payloadVersion: serializer.fromJson<int>(json['payloadVersion']),
      baseServerVersion: serializer.fromJson<int?>(json['baseServerVersion']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      nextAttemptAtMs: serializer.fromJson<int>(json['nextAttemptAtMs']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'payloadVersion': serializer.toJson<int>(payloadVersion),
      'baseServerVersion': serializer.toJson<int?>(baseServerVersion),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'nextAttemptAtMs': serializer.toJson<int>(nextAttemptAtMs),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
    };
  }

  SyncOutboxRow copyWith({
    String? id,
    String? profileId,
    String? entityType,
    String? entityId,
    String? operation,
    String? payloadJson,
    int? payloadVersion,
    Value<int?> baseServerVersion = const Value.absent(),
    String? idempotencyKey,
    int? attemptCount,
    int? nextAttemptAtMs,
    Value<String?> lastErrorCode = const Value.absent(),
    int? createdAtMs,
  }) => SyncOutboxRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    payloadVersion: payloadVersion ?? this.payloadVersion,
    baseServerVersion: baseServerVersion.present
        ? baseServerVersion.value
        : this.baseServerVersion,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    attemptCount: attemptCount ?? this.attemptCount,
    nextAttemptAtMs: nextAttemptAtMs ?? this.nextAttemptAtMs,
    lastErrorCode: lastErrorCode.present
        ? lastErrorCode.value
        : this.lastErrorCode,
    createdAtMs: createdAtMs ?? this.createdAtMs,
  );
  SyncOutboxRow copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      payloadVersion: data.payloadVersion.present
          ? data.payloadVersion.value
          : this.payloadVersion,
      baseServerVersion: data.baseServerVersion.present
          ? data.baseServerVersion.value
          : this.baseServerVersion,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      nextAttemptAtMs: data.nextAttemptAtMs.present
          ? data.nextAttemptAtMs.value
          : this.nextAttemptAtMs,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('baseServerVersion: $baseServerVersion, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAtMs: $nextAttemptAtMs, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('createdAtMs: $createdAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    entityType,
    entityId,
    operation,
    payloadJson,
    payloadVersion,
    baseServerVersion,
    idempotencyKey,
    attemptCount,
    nextAttemptAtMs,
    lastErrorCode,
    createdAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.payloadVersion == this.payloadVersion &&
          other.baseServerVersion == this.baseServerVersion &&
          other.idempotencyKey == this.idempotencyKey &&
          other.attemptCount == this.attemptCount &&
          other.nextAttemptAtMs == this.nextAttemptAtMs &&
          other.lastErrorCode == this.lastErrorCode &&
          other.createdAtMs == this.createdAtMs);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<int> payloadVersion;
  final Value<int?> baseServerVersion;
  final Value<String> idempotencyKey;
  final Value<int> attemptCount;
  final Value<int> nextAttemptAtMs;
  final Value<String?> lastErrorCode;
  final Value<int> createdAtMs;
  final Value<int> rowid;
  const SyncOutboxCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.payloadVersion = const Value.absent(),
    this.baseServerVersion = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.nextAttemptAtMs = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    required String id,
    required String profileId,
    required String entityType,
    required String entityId,
    required String operation,
    required String payloadJson,
    this.payloadVersion = const Value.absent(),
    this.baseServerVersion = const Value.absent(),
    required String idempotencyKey,
    this.attemptCount = const Value.absent(),
    required int nextAttemptAtMs,
    this.lastErrorCode = const Value.absent(),
    required int createdAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payloadJson = Value(payloadJson),
       idempotencyKey = Value(idempotencyKey),
       nextAttemptAtMs = Value(nextAttemptAtMs),
       createdAtMs = Value(createdAtMs);
  static Insertable<SyncOutboxRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? payloadVersion,
    Expression<int>? baseServerVersion,
    Expression<String>? idempotencyKey,
    Expression<int>? attemptCount,
    Expression<int>? nextAttemptAtMs,
    Expression<String>? lastErrorCode,
    Expression<int>? createdAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (payloadVersion != null) 'payload_version': payloadVersion,
      if (baseServerVersion != null) 'base_server_version': baseServerVersion,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (nextAttemptAtMs != null) 'next_attempt_at_ms': nextAttemptAtMs,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<int>? payloadVersion,
    Value<int?>? baseServerVersion,
    Value<String>? idempotencyKey,
    Value<int>? attemptCount,
    Value<int>? nextAttemptAtMs,
    Value<String?>? lastErrorCode,
    Value<int>? createdAtMs,
    Value<int>? rowid,
  }) {
    return SyncOutboxCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      payloadVersion: payloadVersion ?? this.payloadVersion,
      baseServerVersion: baseServerVersion ?? this.baseServerVersion,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      attemptCount: attemptCount ?? this.attemptCount,
      nextAttemptAtMs: nextAttemptAtMs ?? this.nextAttemptAtMs,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (payloadVersion.present) {
      map['payload_version'] = Variable<int>(payloadVersion.value);
    }
    if (baseServerVersion.present) {
      map['base_server_version'] = Variable<int>(baseServerVersion.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (nextAttemptAtMs.present) {
      map['next_attempt_at_ms'] = Variable<int>(nextAttemptAtMs.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('baseServerVersion: $baseServerVersion, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAtMs: $nextAttemptAtMs, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTable extends SyncState
    with TableInfo<$SyncStateTable, SyncStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cursorMeta = const VerificationMeta('cursor');
  @override
  late final GeneratedColumn<String> cursor = GeneratedColumn<String>(
    'cursor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    true,
    check: () =>
        datasetVersion.isNull() |
        ComparableExpr(datasetVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _etagMeta = const VerificationMeta('etag');
  @override
  late final GeneratedColumn<String> etag = GeneratedColumn<String>(
    'etag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastAttemptAtMsMeta = const VerificationMeta(
    'lastAttemptAtMs',
  );
  @override
  late final GeneratedColumn<int> lastAttemptAtMs = GeneratedColumn<int>(
    'last_attempt_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSuccessAtMsMeta = const VerificationMeta(
    'lastSuccessAtMs',
  );
  @override
  late final GeneratedColumn<int> lastSuccessAtMs = GeneratedColumn<int>(
    'last_success_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextCheckAtMsMeta = const VerificationMeta(
    'nextCheckAtMs',
  );
  @override
  late final GeneratedColumn<int> nextCheckAtMs = GeneratedColumn<int>(
    'next_check_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorCodeMeta = const VerificationMeta(
    'lastErrorCode',
  );
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
    'last_error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    scope,
    cursor,
    datasetVersion,
    etag,
    lastAttemptAtMs,
    lastSuccessAtMs,
    nextCheckAtMs,
    lastErrorCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('cursor')) {
      context.handle(
        _cursorMeta,
        cursor.isAcceptableOrUnknown(data['cursor']!, _cursorMeta),
      );
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    }
    if (data.containsKey('etag')) {
      context.handle(
        _etagMeta,
        etag.isAcceptableOrUnknown(data['etag']!, _etagMeta),
      );
    }
    if (data.containsKey('last_attempt_at_ms')) {
      context.handle(
        _lastAttemptAtMsMeta,
        lastAttemptAtMs.isAcceptableOrUnknown(
          data['last_attempt_at_ms']!,
          _lastAttemptAtMsMeta,
        ),
      );
    }
    if (data.containsKey('last_success_at_ms')) {
      context.handle(
        _lastSuccessAtMsMeta,
        lastSuccessAtMs.isAcceptableOrUnknown(
          data['last_success_at_ms']!,
          _lastSuccessAtMsMeta,
        ),
      );
    }
    if (data.containsKey('next_check_at_ms')) {
      context.handle(
        _nextCheckAtMsMeta,
        nextCheckAtMs.isAcceptableOrUnknown(
          data['next_check_at_ms']!,
          _nextCheckAtMsMeta,
        ),
      );
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
        _lastErrorCodeMeta,
        lastErrorCode.isAcceptableOrUnknown(
          data['last_error_code']!,
          _lastErrorCodeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scope};
  @override
  SyncStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateRow(
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      cursor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cursor'],
      ),
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      ),
      etag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etag'],
      ),
      lastAttemptAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_attempt_at_ms'],
      ),
      lastSuccessAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_success_at_ms'],
      ),
      nextCheckAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_check_at_ms'],
      ),
      lastErrorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_code'],
      ),
    );
  }

  @override
  $SyncStateTable createAlias(String alias) {
    return $SyncStateTable(attachedDatabase, alias);
  }
}

class SyncStateRow extends DataClass implements Insertable<SyncStateRow> {
  final String scope;
  final String? cursor;
  final int? datasetVersion;
  final String? etag;
  final int? lastAttemptAtMs;
  final int? lastSuccessAtMs;
  final int? nextCheckAtMs;
  final String? lastErrorCode;
  const SyncStateRow({
    required this.scope,
    this.cursor,
    this.datasetVersion,
    this.etag,
    this.lastAttemptAtMs,
    this.lastSuccessAtMs,
    this.nextCheckAtMs,
    this.lastErrorCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scope'] = Variable<String>(scope);
    if (!nullToAbsent || cursor != null) {
      map['cursor'] = Variable<String>(cursor);
    }
    if (!nullToAbsent || datasetVersion != null) {
      map['dataset_version'] = Variable<int>(datasetVersion);
    }
    if (!nullToAbsent || etag != null) {
      map['etag'] = Variable<String>(etag);
    }
    if (!nullToAbsent || lastAttemptAtMs != null) {
      map['last_attempt_at_ms'] = Variable<int>(lastAttemptAtMs);
    }
    if (!nullToAbsent || lastSuccessAtMs != null) {
      map['last_success_at_ms'] = Variable<int>(lastSuccessAtMs);
    }
    if (!nullToAbsent || nextCheckAtMs != null) {
      map['next_check_at_ms'] = Variable<int>(nextCheckAtMs);
    }
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    return map;
  }

  SyncStateCompanion toCompanion(bool nullToAbsent) {
    return SyncStateCompanion(
      scope: Value(scope),
      cursor: cursor == null && nullToAbsent
          ? const Value.absent()
          : Value(cursor),
      datasetVersion: datasetVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(datasetVersion),
      etag: etag == null && nullToAbsent ? const Value.absent() : Value(etag),
      lastAttemptAtMs: lastAttemptAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAtMs),
      lastSuccessAtMs: lastSuccessAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAtMs),
      nextCheckAtMs: nextCheckAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(nextCheckAtMs),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
    );
  }

  factory SyncStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateRow(
      scope: serializer.fromJson<String>(json['scope']),
      cursor: serializer.fromJson<String?>(json['cursor']),
      datasetVersion: serializer.fromJson<int?>(json['datasetVersion']),
      etag: serializer.fromJson<String?>(json['etag']),
      lastAttemptAtMs: serializer.fromJson<int?>(json['lastAttemptAtMs']),
      lastSuccessAtMs: serializer.fromJson<int?>(json['lastSuccessAtMs']),
      nextCheckAtMs: serializer.fromJson<int?>(json['nextCheckAtMs']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scope': serializer.toJson<String>(scope),
      'cursor': serializer.toJson<String?>(cursor),
      'datasetVersion': serializer.toJson<int?>(datasetVersion),
      'etag': serializer.toJson<String?>(etag),
      'lastAttemptAtMs': serializer.toJson<int?>(lastAttemptAtMs),
      'lastSuccessAtMs': serializer.toJson<int?>(lastSuccessAtMs),
      'nextCheckAtMs': serializer.toJson<int?>(nextCheckAtMs),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
    };
  }

  SyncStateRow copyWith({
    String? scope,
    Value<String?> cursor = const Value.absent(),
    Value<int?> datasetVersion = const Value.absent(),
    Value<String?> etag = const Value.absent(),
    Value<int?> lastAttemptAtMs = const Value.absent(),
    Value<int?> lastSuccessAtMs = const Value.absent(),
    Value<int?> nextCheckAtMs = const Value.absent(),
    Value<String?> lastErrorCode = const Value.absent(),
  }) => SyncStateRow(
    scope: scope ?? this.scope,
    cursor: cursor.present ? cursor.value : this.cursor,
    datasetVersion: datasetVersion.present
        ? datasetVersion.value
        : this.datasetVersion,
    etag: etag.present ? etag.value : this.etag,
    lastAttemptAtMs: lastAttemptAtMs.present
        ? lastAttemptAtMs.value
        : this.lastAttemptAtMs,
    lastSuccessAtMs: lastSuccessAtMs.present
        ? lastSuccessAtMs.value
        : this.lastSuccessAtMs,
    nextCheckAtMs: nextCheckAtMs.present
        ? nextCheckAtMs.value
        : this.nextCheckAtMs,
    lastErrorCode: lastErrorCode.present
        ? lastErrorCode.value
        : this.lastErrorCode,
  );
  SyncStateRow copyWithCompanion(SyncStateCompanion data) {
    return SyncStateRow(
      scope: data.scope.present ? data.scope.value : this.scope,
      cursor: data.cursor.present ? data.cursor.value : this.cursor,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
      etag: data.etag.present ? data.etag.value : this.etag,
      lastAttemptAtMs: data.lastAttemptAtMs.present
          ? data.lastAttemptAtMs.value
          : this.lastAttemptAtMs,
      lastSuccessAtMs: data.lastSuccessAtMs.present
          ? data.lastSuccessAtMs.value
          : this.lastSuccessAtMs,
      nextCheckAtMs: data.nextCheckAtMs.present
          ? data.nextCheckAtMs.value
          : this.nextCheckAtMs,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateRow(')
          ..write('scope: $scope, ')
          ..write('cursor: $cursor, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('etag: $etag, ')
          ..write('lastAttemptAtMs: $lastAttemptAtMs, ')
          ..write('lastSuccessAtMs: $lastSuccessAtMs, ')
          ..write('nextCheckAtMs: $nextCheckAtMs, ')
          ..write('lastErrorCode: $lastErrorCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    scope,
    cursor,
    datasetVersion,
    etag,
    lastAttemptAtMs,
    lastSuccessAtMs,
    nextCheckAtMs,
    lastErrorCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateRow &&
          other.scope == this.scope &&
          other.cursor == this.cursor &&
          other.datasetVersion == this.datasetVersion &&
          other.etag == this.etag &&
          other.lastAttemptAtMs == this.lastAttemptAtMs &&
          other.lastSuccessAtMs == this.lastSuccessAtMs &&
          other.nextCheckAtMs == this.nextCheckAtMs &&
          other.lastErrorCode == this.lastErrorCode);
}

class SyncStateCompanion extends UpdateCompanion<SyncStateRow> {
  final Value<String> scope;
  final Value<String?> cursor;
  final Value<int?> datasetVersion;
  final Value<String?> etag;
  final Value<int?> lastAttemptAtMs;
  final Value<int?> lastSuccessAtMs;
  final Value<int?> nextCheckAtMs;
  final Value<String?> lastErrorCode;
  final Value<int> rowid;
  const SyncStateCompanion({
    this.scope = const Value.absent(),
    this.cursor = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.etag = const Value.absent(),
    this.lastAttemptAtMs = const Value.absent(),
    this.lastSuccessAtMs = const Value.absent(),
    this.nextCheckAtMs = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateCompanion.insert({
    required String scope,
    this.cursor = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.etag = const Value.absent(),
    this.lastAttemptAtMs = const Value.absent(),
    this.lastSuccessAtMs = const Value.absent(),
    this.nextCheckAtMs = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : scope = Value(scope);
  static Insertable<SyncStateRow> custom({
    Expression<String>? scope,
    Expression<String>? cursor,
    Expression<int>? datasetVersion,
    Expression<String>? etag,
    Expression<int>? lastAttemptAtMs,
    Expression<int>? lastSuccessAtMs,
    Expression<int>? nextCheckAtMs,
    Expression<String>? lastErrorCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (scope != null) 'scope': scope,
      if (cursor != null) 'cursor': cursor,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (etag != null) 'etag': etag,
      if (lastAttemptAtMs != null) 'last_attempt_at_ms': lastAttemptAtMs,
      if (lastSuccessAtMs != null) 'last_success_at_ms': lastSuccessAtMs,
      if (nextCheckAtMs != null) 'next_check_at_ms': nextCheckAtMs,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateCompanion copyWith({
    Value<String>? scope,
    Value<String?>? cursor,
    Value<int?>? datasetVersion,
    Value<String?>? etag,
    Value<int?>? lastAttemptAtMs,
    Value<int?>? lastSuccessAtMs,
    Value<int?>? nextCheckAtMs,
    Value<String?>? lastErrorCode,
    Value<int>? rowid,
  }) {
    return SyncStateCompanion(
      scope: scope ?? this.scope,
      cursor: cursor ?? this.cursor,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      etag: etag ?? this.etag,
      lastAttemptAtMs: lastAttemptAtMs ?? this.lastAttemptAtMs,
      lastSuccessAtMs: lastSuccessAtMs ?? this.lastSuccessAtMs,
      nextCheckAtMs: nextCheckAtMs ?? this.nextCheckAtMs,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (cursor.present) {
      map['cursor'] = Variable<String>(cursor.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (etag.present) {
      map['etag'] = Variable<String>(etag.value);
    }
    if (lastAttemptAtMs.present) {
      map['last_attempt_at_ms'] = Variable<int>(lastAttemptAtMs.value);
    }
    if (lastSuccessAtMs.present) {
      map['last_success_at_ms'] = Variable<int>(lastSuccessAtMs.value);
    }
    if (nextCheckAtMs.present) {
      map['next_check_at_ms'] = Variable<int>(nextCheckAtMs.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateCompanion(')
          ..write('scope: $scope, ')
          ..write('cursor: $cursor, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('etag: $etag, ')
          ..write('lastAttemptAtMs: $lastAttemptAtMs, ')
          ..write('lastSuccessAtMs: $lastSuccessAtMs, ')
          ..write('nextCheckAtMs: $nextCheckAtMs, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalMerchantsTable extends LocalMerchants
    with TableInfo<$LocalMerchantsTable, LocalMerchantRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMerchantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _serverMerchantIdMeta = const VerificationMeta(
    'serverMerchantId',
  );
  @override
  late final GeneratedColumn<String> serverMerchantId = GeneratedColumn<String>(
    'server_merchant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameRawMeta = const VerificationMeta(
    'nameRaw',
  );
  @override
  late final GeneratedColumn<String> nameRaw = GeneratedColumn<String>(
    'name_raw',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameNormalizedMeta = const VerificationMeta(
    'nameNormalized',
  );
  @override
  late final GeneratedColumn<String> nameNormalized = GeneratedColumn<String>(
    'name_normalized',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationTextMeta = const VerificationMeta(
    'locationText',
  );
  @override
  late final GeneratedColumn<String> locationText = GeneratedColumn<String>(
    'location_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    false,
    check: () => countryCode.length.equals(2),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('VN'),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMsMeta = const VerificationMeta(
    'deletedAtMs',
  );
  @override
  late final GeneratedColumn<int> deletedAtMs = GeneratedColumn<int>(
    'deleted_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    check: () => syncStatus.isIn(const [
      'local_only',
      'pending',
      'synced',
      'failed',
      'conflict',
    ]),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local_only'),
  );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<int> serverVersion = GeneratedColumn<int>(
    'server_version',
    aliasedName,
    true,
    check: () =>
        serverVersion.isNull() |
        ComparableExpr(serverVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMsMeta = const VerificationMeta(
    'lastSyncedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAtMs = GeneratedColumn<int>(
    'last_synced_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    serverMerchantId,
    nameRaw,
    nameNormalized,
    locationText,
    countryCode,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_merchants';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalMerchantRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('server_merchant_id')) {
      context.handle(
        _serverMerchantIdMeta,
        serverMerchantId.isAcceptableOrUnknown(
          data['server_merchant_id']!,
          _serverMerchantIdMeta,
        ),
      );
    }
    if (data.containsKey('name_raw')) {
      context.handle(
        _nameRawMeta,
        nameRaw.isAcceptableOrUnknown(data['name_raw']!, _nameRawMeta),
      );
    } else if (isInserting) {
      context.missing(_nameRawMeta);
    }
    if (data.containsKey('name_normalized')) {
      context.handle(
        _nameNormalizedMeta,
        nameNormalized.isAcceptableOrUnknown(
          data['name_normalized']!,
          _nameNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameNormalizedMeta);
    }
    if (data.containsKey('location_text')) {
      context.handle(
        _locationTextMeta,
        locationText.isAcceptableOrUnknown(
          data['location_text']!,
          _locationTextMeta,
        ),
      );
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('deleted_at_ms')) {
      context.handle(
        _deletedAtMsMeta,
        deletedAtMs.isAcceptableOrUnknown(
          data['deleted_at_ms']!,
          _deletedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at_ms')) {
      context.handle(
        _lastSyncedAtMsMeta,
        lastSyncedAtMs.isAcceptableOrUnknown(
          data['last_synced_at_ms']!,
          _lastSyncedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalMerchantRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMerchantRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      serverMerchantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_merchant_id'],
      ),
      nameRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_raw'],
      )!,
      nameNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_normalized'],
      )!,
      locationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_text'],
      ),
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      deletedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_ms'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version'],
      ),
      lastSyncedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at_ms'],
      ),
    );
  }

  @override
  $LocalMerchantsTable createAlias(String alias) {
    return $LocalMerchantsTable(attachedDatabase, alias);
  }
}

class LocalMerchantRow extends DataClass
    implements Insertable<LocalMerchantRow> {
  final String id;
  final String profileId;
  final String? serverMerchantId;
  final String nameRaw;
  final String nameNormalized;
  final String? locationText;
  final String countryCode;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  final String syncStatus;
  final int? serverVersion;
  final int? lastSyncedAtMs;
  const LocalMerchantRow({
    required this.id,
    required this.profileId,
    this.serverMerchantId,
    required this.nameRaw,
    required this.nameNormalized,
    this.locationText,
    required this.countryCode,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
    required this.syncStatus,
    this.serverVersion,
    this.lastSyncedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || serverMerchantId != null) {
      map['server_merchant_id'] = Variable<String>(serverMerchantId);
    }
    map['name_raw'] = Variable<String>(nameRaw);
    map['name_normalized'] = Variable<String>(nameNormalized);
    if (!nullToAbsent || locationText != null) {
      map['location_text'] = Variable<String>(locationText);
    }
    map['country_code'] = Variable<String>(countryCode);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    if (!nullToAbsent || deletedAtMs != null) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || serverVersion != null) {
      map['server_version'] = Variable<int>(serverVersion);
    }
    if (!nullToAbsent || lastSyncedAtMs != null) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs);
    }
    return map;
  }

  LocalMerchantsCompanion toCompanion(bool nullToAbsent) {
    return LocalMerchantsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      serverMerchantId: serverMerchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverMerchantId),
      nameRaw: Value(nameRaw),
      nameNormalized: Value(nameNormalized),
      locationText: locationText == null && nullToAbsent
          ? const Value.absent()
          : Value(locationText),
      countryCode: Value(countryCode),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      deletedAtMs: deletedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtMs),
      syncStatus: Value(syncStatus),
      serverVersion: serverVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(serverVersion),
      lastSyncedAtMs: lastSyncedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAtMs),
    );
  }

  factory LocalMerchantRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMerchantRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      serverMerchantId: serializer.fromJson<String?>(json['serverMerchantId']),
      nameRaw: serializer.fromJson<String>(json['nameRaw']),
      nameNormalized: serializer.fromJson<String>(json['nameNormalized']),
      locationText: serializer.fromJson<String?>(json['locationText']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      deletedAtMs: serializer.fromJson<int?>(json['deletedAtMs']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      serverVersion: serializer.fromJson<int?>(json['serverVersion']),
      lastSyncedAtMs: serializer.fromJson<int?>(json['lastSyncedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'serverMerchantId': serializer.toJson<String?>(serverMerchantId),
      'nameRaw': serializer.toJson<String>(nameRaw),
      'nameNormalized': serializer.toJson<String>(nameNormalized),
      'locationText': serializer.toJson<String?>(locationText),
      'countryCode': serializer.toJson<String>(countryCode),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'deletedAtMs': serializer.toJson<int?>(deletedAtMs),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'serverVersion': serializer.toJson<int?>(serverVersion),
      'lastSyncedAtMs': serializer.toJson<int?>(lastSyncedAtMs),
    };
  }

  LocalMerchantRow copyWith({
    String? id,
    String? profileId,
    Value<String?> serverMerchantId = const Value.absent(),
    String? nameRaw,
    String? nameNormalized,
    Value<String?> locationText = const Value.absent(),
    String? countryCode,
    int? createdAtMs,
    int? updatedAtMs,
    Value<int?> deletedAtMs = const Value.absent(),
    String? syncStatus,
    Value<int?> serverVersion = const Value.absent(),
    Value<int?> lastSyncedAtMs = const Value.absent(),
  }) => LocalMerchantRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    serverMerchantId: serverMerchantId.present
        ? serverMerchantId.value
        : this.serverMerchantId,
    nameRaw: nameRaw ?? this.nameRaw,
    nameNormalized: nameNormalized ?? this.nameNormalized,
    locationText: locationText.present ? locationText.value : this.locationText,
    countryCode: countryCode ?? this.countryCode,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    deletedAtMs: deletedAtMs.present ? deletedAtMs.value : this.deletedAtMs,
    syncStatus: syncStatus ?? this.syncStatus,
    serverVersion: serverVersion.present
        ? serverVersion.value
        : this.serverVersion,
    lastSyncedAtMs: lastSyncedAtMs.present
        ? lastSyncedAtMs.value
        : this.lastSyncedAtMs,
  );
  LocalMerchantRow copyWithCompanion(LocalMerchantsCompanion data) {
    return LocalMerchantRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      serverMerchantId: data.serverMerchantId.present
          ? data.serverMerchantId.value
          : this.serverMerchantId,
      nameRaw: data.nameRaw.present ? data.nameRaw.value : this.nameRaw,
      nameNormalized: data.nameNormalized.present
          ? data.nameNormalized.value
          : this.nameNormalized,
      locationText: data.locationText.present
          ? data.locationText.value
          : this.locationText,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      deletedAtMs: data.deletedAtMs.present
          ? data.deletedAtMs.value
          : this.deletedAtMs,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      lastSyncedAtMs: data.lastSyncedAtMs.present
          ? data.lastSyncedAtMs.value
          : this.lastSyncedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMerchantRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('serverMerchantId: $serverMerchantId, ')
          ..write('nameRaw: $nameRaw, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('locationText: $locationText, ')
          ..write('countryCode: $countryCode, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    serverMerchantId,
    nameRaw,
    nameNormalized,
    locationText,
    countryCode,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMerchantRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.serverMerchantId == this.serverMerchantId &&
          other.nameRaw == this.nameRaw &&
          other.nameNormalized == this.nameNormalized &&
          other.locationText == this.locationText &&
          other.countryCode == this.countryCode &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.deletedAtMs == this.deletedAtMs &&
          other.syncStatus == this.syncStatus &&
          other.serverVersion == this.serverVersion &&
          other.lastSyncedAtMs == this.lastSyncedAtMs);
}

class LocalMerchantsCompanion extends UpdateCompanion<LocalMerchantRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String?> serverMerchantId;
  final Value<String> nameRaw;
  final Value<String> nameNormalized;
  final Value<String?> locationText;
  final Value<String> countryCode;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int?> deletedAtMs;
  final Value<String> syncStatus;
  final Value<int?> serverVersion;
  final Value<int?> lastSyncedAtMs;
  final Value<int> rowid;
  const LocalMerchantsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.serverMerchantId = const Value.absent(),
    this.nameRaw = const Value.absent(),
    this.nameNormalized = const Value.absent(),
    this.locationText = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalMerchantsCompanion.insert({
    required String id,
    required String profileId,
    this.serverMerchantId = const Value.absent(),
    required String nameRaw,
    required String nameNormalized,
    this.locationText = const Value.absent(),
    this.countryCode = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       nameRaw = Value(nameRaw),
       nameNormalized = Value(nameNormalized),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LocalMerchantRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? serverMerchantId,
    Expression<String>? nameRaw,
    Expression<String>? nameNormalized,
    Expression<String>? locationText,
    Expression<String>? countryCode,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? deletedAtMs,
    Expression<String>? syncStatus,
    Expression<int>? serverVersion,
    Expression<int>? lastSyncedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (serverMerchantId != null) 'server_merchant_id': serverMerchantId,
      if (nameRaw != null) 'name_raw': nameRaw,
      if (nameNormalized != null) 'name_normalized': nameNormalized,
      if (locationText != null) 'location_text': locationText,
      if (countryCode != null) 'country_code': countryCode,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (deletedAtMs != null) 'deleted_at_ms': deletedAtMs,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (serverVersion != null) 'server_version': serverVersion,
      if (lastSyncedAtMs != null) 'last_synced_at_ms': lastSyncedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalMerchantsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String?>? serverMerchantId,
    Value<String>? nameRaw,
    Value<String>? nameNormalized,
    Value<String?>? locationText,
    Value<String>? countryCode,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int?>? deletedAtMs,
    Value<String>? syncStatus,
    Value<int?>? serverVersion,
    Value<int?>? lastSyncedAtMs,
    Value<int>? rowid,
  }) {
    return LocalMerchantsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      serverMerchantId: serverMerchantId ?? this.serverMerchantId,
      nameRaw: nameRaw ?? this.nameRaw,
      nameNormalized: nameNormalized ?? this.nameNormalized,
      locationText: locationText ?? this.locationText,
      countryCode: countryCode ?? this.countryCode,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      deletedAtMs: deletedAtMs ?? this.deletedAtMs,
      syncStatus: syncStatus ?? this.syncStatus,
      serverVersion: serverVersion ?? this.serverVersion,
      lastSyncedAtMs: lastSyncedAtMs ?? this.lastSyncedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (serverMerchantId.present) {
      map['server_merchant_id'] = Variable<String>(serverMerchantId.value);
    }
    if (nameRaw.present) {
      map['name_raw'] = Variable<String>(nameRaw.value);
    }
    if (nameNormalized.present) {
      map['name_normalized'] = Variable<String>(nameNormalized.value);
    }
    if (locationText.present) {
      map['location_text'] = Variable<String>(locationText.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (deletedAtMs.present) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<int>(serverVersion.value);
    }
    if (lastSyncedAtMs.present) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMerchantsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('serverMerchantId: $serverMerchantId, ')
          ..write('nameRaw: $nameRaw, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('locationText: $locationText, ')
          ..write('countryCode: $countryCode, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalTransactionsTable extends LocalTransactions
    with TableInfo<$LocalTransactionsTable, LocalTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userCardIdMeta = const VerificationMeta(
    'userCardId',
  );
  @override
  late final GeneratedColumn<String> userCardId = GeneratedColumn<String>(
    'user_card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_user_cards (id)',
    ),
  );
  static const VerificationMeta _merchantIdMeta = const VerificationMeta(
    'merchantId',
  );
  @override
  late final GeneratedColumn<String> merchantId = GeneratedColumn<String>(
    'merchant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_merchants (id)',
    ),
  );
  static const VerificationMeta _transactionAtMsMeta = const VerificationMeta(
    'transactionAtMs',
  );
  @override
  late final GeneratedColumn<int> transactionAtMs = GeneratedColumn<int>(
    'transaction_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    check: () => ComparableExpr(amountMinor).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    check: () => currency.length.equals(3),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('VND'),
  );
  static const VerificationMeta _mccCodeMeta = const VerificationMeta(
    'mccCode',
  );
  @override
  late final GeneratedColumn<String> mccCode = GeneratedColumn<String>(
    'mcc_code',
    aliasedName,
    true,
    check: () => mccCode.isNull() | mccCode.length.equals(4),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mccSourceMeta = const VerificationMeta(
    'mccSource',
  );
  @override
  late final GeneratedColumn<String> mccSource = GeneratedColumn<String>(
    'mcc_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cashbackEstimatedMinorMeta =
      const VerificationMeta('cashbackEstimatedMinor');
  @override
  late final GeneratedColumn<int> cashbackEstimatedMinor = GeneratedColumn<int>(
    'cashback_estimated_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cashbackConfidencePpmMeta =
      const VerificationMeta('cashbackConfidencePpm');
  @override
  late final GeneratedColumn<int> cashbackConfidencePpm = GeneratedColumn<int>(
    'cashback_confidence_ppm',
    aliasedName,
    true,
    check: () =>
        cashbackConfidencePpm.isNull() |
        ComparableExpr(cashbackConfidencePpm).isBetweenValues(0, 1000000),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMsMeta = const VerificationMeta(
    'deletedAtMs',
  );
  @override
  late final GeneratedColumn<int> deletedAtMs = GeneratedColumn<int>(
    'deleted_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    check: () => syncStatus.isIn(const [
      'local_only',
      'pending',
      'synced',
      'failed',
      'conflict',
    ]),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local_only'),
  );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<int> serverVersion = GeneratedColumn<int>(
    'server_version',
    aliasedName,
    true,
    check: () =>
        serverVersion.isNull() |
        ComparableExpr(serverVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMsMeta = const VerificationMeta(
    'lastSyncedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAtMs = GeneratedColumn<int>(
    'last_synced_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    userCardId,
    merchantId,
    transactionAtMs,
    amountMinor,
    currency,
    mccCode,
    mccSource,
    category,
    cashbackEstimatedMinor,
    cashbackConfidencePpm,
    source,
    note,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('user_card_id')) {
      context.handle(
        _userCardIdMeta,
        userCardId.isAcceptableOrUnknown(
          data['user_card_id']!,
          _userCardIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userCardIdMeta);
    }
    if (data.containsKey('merchant_id')) {
      context.handle(
        _merchantIdMeta,
        merchantId.isAcceptableOrUnknown(data['merchant_id']!, _merchantIdMeta),
      );
    }
    if (data.containsKey('transaction_at_ms')) {
      context.handle(
        _transactionAtMsMeta,
        transactionAtMs.isAcceptableOrUnknown(
          data['transaction_at_ms']!,
          _transactionAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionAtMsMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('mcc_code')) {
      context.handle(
        _mccCodeMeta,
        mccCode.isAcceptableOrUnknown(data['mcc_code']!, _mccCodeMeta),
      );
    }
    if (data.containsKey('mcc_source')) {
      context.handle(
        _mccSourceMeta,
        mccSource.isAcceptableOrUnknown(data['mcc_source']!, _mccSourceMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('cashback_estimated_minor')) {
      context.handle(
        _cashbackEstimatedMinorMeta,
        cashbackEstimatedMinor.isAcceptableOrUnknown(
          data['cashback_estimated_minor']!,
          _cashbackEstimatedMinorMeta,
        ),
      );
    }
    if (data.containsKey('cashback_confidence_ppm')) {
      context.handle(
        _cashbackConfidencePpmMeta,
        cashbackConfidencePpm.isAcceptableOrUnknown(
          data['cashback_confidence_ppm']!,
          _cashbackConfidencePpmMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('deleted_at_ms')) {
      context.handle(
        _deletedAtMsMeta,
        deletedAtMs.isAcceptableOrUnknown(
          data['deleted_at_ms']!,
          _deletedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at_ms')) {
      context.handle(
        _lastSyncedAtMsMeta,
        lastSyncedAtMs.isAcceptableOrUnknown(
          data['last_synced_at_ms']!,
          _lastSyncedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      userCardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_card_id'],
      )!,
      merchantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_id'],
      ),
      transactionAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_at_ms'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      mccCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc_code'],
      ),
      mccSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc_source'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      cashbackEstimatedMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cashback_estimated_minor'],
      ),
      cashbackConfidencePpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cashback_confidence_ppm'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      deletedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_ms'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version'],
      ),
      lastSyncedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at_ms'],
      ),
    );
  }

  @override
  $LocalTransactionsTable createAlias(String alias) {
    return $LocalTransactionsTable(attachedDatabase, alias);
  }
}

class LocalTransactionRow extends DataClass
    implements Insertable<LocalTransactionRow> {
  final String id;
  final String profileId;
  final String userCardId;
  final String? merchantId;
  final int transactionAtMs;
  final int amountMinor;
  final String currency;
  final String? mccCode;
  final String? mccSource;
  final String? category;
  final int? cashbackEstimatedMinor;
  final int? cashbackConfidencePpm;
  final String source;
  final String? note;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  final String syncStatus;
  final int? serverVersion;
  final int? lastSyncedAtMs;
  const LocalTransactionRow({
    required this.id,
    required this.profileId,
    required this.userCardId,
    this.merchantId,
    required this.transactionAtMs,
    required this.amountMinor,
    required this.currency,
    this.mccCode,
    this.mccSource,
    this.category,
    this.cashbackEstimatedMinor,
    this.cashbackConfidencePpm,
    required this.source,
    this.note,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
    required this.syncStatus,
    this.serverVersion,
    this.lastSyncedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['user_card_id'] = Variable<String>(userCardId);
    if (!nullToAbsent || merchantId != null) {
      map['merchant_id'] = Variable<String>(merchantId);
    }
    map['transaction_at_ms'] = Variable<int>(transactionAtMs);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || mccCode != null) {
      map['mcc_code'] = Variable<String>(mccCode);
    }
    if (!nullToAbsent || mccSource != null) {
      map['mcc_source'] = Variable<String>(mccSource);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || cashbackEstimatedMinor != null) {
      map['cashback_estimated_minor'] = Variable<int>(cashbackEstimatedMinor);
    }
    if (!nullToAbsent || cashbackConfidencePpm != null) {
      map['cashback_confidence_ppm'] = Variable<int>(cashbackConfidencePpm);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    if (!nullToAbsent || deletedAtMs != null) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || serverVersion != null) {
      map['server_version'] = Variable<int>(serverVersion);
    }
    if (!nullToAbsent || lastSyncedAtMs != null) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs);
    }
    return map;
  }

  LocalTransactionsCompanion toCompanion(bool nullToAbsent) {
    return LocalTransactionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      userCardId: Value(userCardId),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      transactionAtMs: Value(transactionAtMs),
      amountMinor: Value(amountMinor),
      currency: Value(currency),
      mccCode: mccCode == null && nullToAbsent
          ? const Value.absent()
          : Value(mccCode),
      mccSource: mccSource == null && nullToAbsent
          ? const Value.absent()
          : Value(mccSource),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      cashbackEstimatedMinor: cashbackEstimatedMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(cashbackEstimatedMinor),
      cashbackConfidencePpm: cashbackConfidencePpm == null && nullToAbsent
          ? const Value.absent()
          : Value(cashbackConfidencePpm),
      source: Value(source),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      deletedAtMs: deletedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtMs),
      syncStatus: Value(syncStatus),
      serverVersion: serverVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(serverVersion),
      lastSyncedAtMs: lastSyncedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAtMs),
    );
  }

  factory LocalTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTransactionRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      userCardId: serializer.fromJson<String>(json['userCardId']),
      merchantId: serializer.fromJson<String?>(json['merchantId']),
      transactionAtMs: serializer.fromJson<int>(json['transactionAtMs']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      currency: serializer.fromJson<String>(json['currency']),
      mccCode: serializer.fromJson<String?>(json['mccCode']),
      mccSource: serializer.fromJson<String?>(json['mccSource']),
      category: serializer.fromJson<String?>(json['category']),
      cashbackEstimatedMinor: serializer.fromJson<int?>(
        json['cashbackEstimatedMinor'],
      ),
      cashbackConfidencePpm: serializer.fromJson<int?>(
        json['cashbackConfidencePpm'],
      ),
      source: serializer.fromJson<String>(json['source']),
      note: serializer.fromJson<String?>(json['note']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      deletedAtMs: serializer.fromJson<int?>(json['deletedAtMs']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      serverVersion: serializer.fromJson<int?>(json['serverVersion']),
      lastSyncedAtMs: serializer.fromJson<int?>(json['lastSyncedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'userCardId': serializer.toJson<String>(userCardId),
      'merchantId': serializer.toJson<String?>(merchantId),
      'transactionAtMs': serializer.toJson<int>(transactionAtMs),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'currency': serializer.toJson<String>(currency),
      'mccCode': serializer.toJson<String?>(mccCode),
      'mccSource': serializer.toJson<String?>(mccSource),
      'category': serializer.toJson<String?>(category),
      'cashbackEstimatedMinor': serializer.toJson<int?>(cashbackEstimatedMinor),
      'cashbackConfidencePpm': serializer.toJson<int?>(cashbackConfidencePpm),
      'source': serializer.toJson<String>(source),
      'note': serializer.toJson<String?>(note),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'deletedAtMs': serializer.toJson<int?>(deletedAtMs),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'serverVersion': serializer.toJson<int?>(serverVersion),
      'lastSyncedAtMs': serializer.toJson<int?>(lastSyncedAtMs),
    };
  }

  LocalTransactionRow copyWith({
    String? id,
    String? profileId,
    String? userCardId,
    Value<String?> merchantId = const Value.absent(),
    int? transactionAtMs,
    int? amountMinor,
    String? currency,
    Value<String?> mccCode = const Value.absent(),
    Value<String?> mccSource = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<int?> cashbackEstimatedMinor = const Value.absent(),
    Value<int?> cashbackConfidencePpm = const Value.absent(),
    String? source,
    Value<String?> note = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    Value<int?> deletedAtMs = const Value.absent(),
    String? syncStatus,
    Value<int?> serverVersion = const Value.absent(),
    Value<int?> lastSyncedAtMs = const Value.absent(),
  }) => LocalTransactionRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    userCardId: userCardId ?? this.userCardId,
    merchantId: merchantId.present ? merchantId.value : this.merchantId,
    transactionAtMs: transactionAtMs ?? this.transactionAtMs,
    amountMinor: amountMinor ?? this.amountMinor,
    currency: currency ?? this.currency,
    mccCode: mccCode.present ? mccCode.value : this.mccCode,
    mccSource: mccSource.present ? mccSource.value : this.mccSource,
    category: category.present ? category.value : this.category,
    cashbackEstimatedMinor: cashbackEstimatedMinor.present
        ? cashbackEstimatedMinor.value
        : this.cashbackEstimatedMinor,
    cashbackConfidencePpm: cashbackConfidencePpm.present
        ? cashbackConfidencePpm.value
        : this.cashbackConfidencePpm,
    source: source ?? this.source,
    note: note.present ? note.value : this.note,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    deletedAtMs: deletedAtMs.present ? deletedAtMs.value : this.deletedAtMs,
    syncStatus: syncStatus ?? this.syncStatus,
    serverVersion: serverVersion.present
        ? serverVersion.value
        : this.serverVersion,
    lastSyncedAtMs: lastSyncedAtMs.present
        ? lastSyncedAtMs.value
        : this.lastSyncedAtMs,
  );
  LocalTransactionRow copyWithCompanion(LocalTransactionsCompanion data) {
    return LocalTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      userCardId: data.userCardId.present
          ? data.userCardId.value
          : this.userCardId,
      merchantId: data.merchantId.present
          ? data.merchantId.value
          : this.merchantId,
      transactionAtMs: data.transactionAtMs.present
          ? data.transactionAtMs.value
          : this.transactionAtMs,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      currency: data.currency.present ? data.currency.value : this.currency,
      mccCode: data.mccCode.present ? data.mccCode.value : this.mccCode,
      mccSource: data.mccSource.present ? data.mccSource.value : this.mccSource,
      category: data.category.present ? data.category.value : this.category,
      cashbackEstimatedMinor: data.cashbackEstimatedMinor.present
          ? data.cashbackEstimatedMinor.value
          : this.cashbackEstimatedMinor,
      cashbackConfidencePpm: data.cashbackConfidencePpm.present
          ? data.cashbackConfidencePpm.value
          : this.cashbackConfidencePpm,
      source: data.source.present ? data.source.value : this.source,
      note: data.note.present ? data.note.value : this.note,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      deletedAtMs: data.deletedAtMs.present
          ? data.deletedAtMs.value
          : this.deletedAtMs,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      lastSyncedAtMs: data.lastSyncedAtMs.present
          ? data.lastSyncedAtMs.value
          : this.lastSyncedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('userCardId: $userCardId, ')
          ..write('merchantId: $merchantId, ')
          ..write('transactionAtMs: $transactionAtMs, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currency: $currency, ')
          ..write('mccCode: $mccCode, ')
          ..write('mccSource: $mccSource, ')
          ..write('category: $category, ')
          ..write('cashbackEstimatedMinor: $cashbackEstimatedMinor, ')
          ..write('cashbackConfidencePpm: $cashbackConfidencePpm, ')
          ..write('source: $source, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    userCardId,
    merchantId,
    transactionAtMs,
    amountMinor,
    currency,
    mccCode,
    mccSource,
    category,
    cashbackEstimatedMinor,
    cashbackConfidencePpm,
    source,
    note,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
    syncStatus,
    serverVersion,
    lastSyncedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTransactionRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.userCardId == this.userCardId &&
          other.merchantId == this.merchantId &&
          other.transactionAtMs == this.transactionAtMs &&
          other.amountMinor == this.amountMinor &&
          other.currency == this.currency &&
          other.mccCode == this.mccCode &&
          other.mccSource == this.mccSource &&
          other.category == this.category &&
          other.cashbackEstimatedMinor == this.cashbackEstimatedMinor &&
          other.cashbackConfidencePpm == this.cashbackConfidencePpm &&
          other.source == this.source &&
          other.note == this.note &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.deletedAtMs == this.deletedAtMs &&
          other.syncStatus == this.syncStatus &&
          other.serverVersion == this.serverVersion &&
          other.lastSyncedAtMs == this.lastSyncedAtMs);
}

class LocalTransactionsCompanion extends UpdateCompanion<LocalTransactionRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> userCardId;
  final Value<String?> merchantId;
  final Value<int> transactionAtMs;
  final Value<int> amountMinor;
  final Value<String> currency;
  final Value<String?> mccCode;
  final Value<String?> mccSource;
  final Value<String?> category;
  final Value<int?> cashbackEstimatedMinor;
  final Value<int?> cashbackConfidencePpm;
  final Value<String> source;
  final Value<String?> note;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int?> deletedAtMs;
  final Value<String> syncStatus;
  final Value<int?> serverVersion;
  final Value<int?> lastSyncedAtMs;
  final Value<int> rowid;
  const LocalTransactionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.userCardId = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.transactionAtMs = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.mccCode = const Value.absent(),
    this.mccSource = const Value.absent(),
    this.category = const Value.absent(),
    this.cashbackEstimatedMinor = const Value.absent(),
    this.cashbackConfidencePpm = const Value.absent(),
    this.source = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalTransactionsCompanion.insert({
    required String id,
    required String profileId,
    required String userCardId,
    this.merchantId = const Value.absent(),
    required int transactionAtMs,
    required int amountMinor,
    this.currency = const Value.absent(),
    this.mccCode = const Value.absent(),
    this.mccSource = const Value.absent(),
    this.category = const Value.absent(),
    this.cashbackEstimatedMinor = const Value.absent(),
    this.cashbackConfidencePpm = const Value.absent(),
    this.source = const Value.absent(),
    this.note = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.deletedAtMs = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       userCardId = Value(userCardId),
       transactionAtMs = Value(transactionAtMs),
       amountMinor = Value(amountMinor),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LocalTransactionRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? userCardId,
    Expression<String>? merchantId,
    Expression<int>? transactionAtMs,
    Expression<int>? amountMinor,
    Expression<String>? currency,
    Expression<String>? mccCode,
    Expression<String>? mccSource,
    Expression<String>? category,
    Expression<int>? cashbackEstimatedMinor,
    Expression<int>? cashbackConfidencePpm,
    Expression<String>? source,
    Expression<String>? note,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? deletedAtMs,
    Expression<String>? syncStatus,
    Expression<int>? serverVersion,
    Expression<int>? lastSyncedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (userCardId != null) 'user_card_id': userCardId,
      if (merchantId != null) 'merchant_id': merchantId,
      if (transactionAtMs != null) 'transaction_at_ms': transactionAtMs,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (currency != null) 'currency': currency,
      if (mccCode != null) 'mcc_code': mccCode,
      if (mccSource != null) 'mcc_source': mccSource,
      if (category != null) 'category': category,
      if (cashbackEstimatedMinor != null)
        'cashback_estimated_minor': cashbackEstimatedMinor,
      if (cashbackConfidencePpm != null)
        'cashback_confidence_ppm': cashbackConfidencePpm,
      if (source != null) 'source': source,
      if (note != null) 'note': note,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (deletedAtMs != null) 'deleted_at_ms': deletedAtMs,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (serverVersion != null) 'server_version': serverVersion,
      if (lastSyncedAtMs != null) 'last_synced_at_ms': lastSyncedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? userCardId,
    Value<String?>? merchantId,
    Value<int>? transactionAtMs,
    Value<int>? amountMinor,
    Value<String>? currency,
    Value<String?>? mccCode,
    Value<String?>? mccSource,
    Value<String?>? category,
    Value<int?>? cashbackEstimatedMinor,
    Value<int?>? cashbackConfidencePpm,
    Value<String>? source,
    Value<String?>? note,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int?>? deletedAtMs,
    Value<String>? syncStatus,
    Value<int?>? serverVersion,
    Value<int?>? lastSyncedAtMs,
    Value<int>? rowid,
  }) {
    return LocalTransactionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      userCardId: userCardId ?? this.userCardId,
      merchantId: merchantId ?? this.merchantId,
      transactionAtMs: transactionAtMs ?? this.transactionAtMs,
      amountMinor: amountMinor ?? this.amountMinor,
      currency: currency ?? this.currency,
      mccCode: mccCode ?? this.mccCode,
      mccSource: mccSource ?? this.mccSource,
      category: category ?? this.category,
      cashbackEstimatedMinor:
          cashbackEstimatedMinor ?? this.cashbackEstimatedMinor,
      cashbackConfidencePpm:
          cashbackConfidencePpm ?? this.cashbackConfidencePpm,
      source: source ?? this.source,
      note: note ?? this.note,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      deletedAtMs: deletedAtMs ?? this.deletedAtMs,
      syncStatus: syncStatus ?? this.syncStatus,
      serverVersion: serverVersion ?? this.serverVersion,
      lastSyncedAtMs: lastSyncedAtMs ?? this.lastSyncedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (userCardId.present) {
      map['user_card_id'] = Variable<String>(userCardId.value);
    }
    if (merchantId.present) {
      map['merchant_id'] = Variable<String>(merchantId.value);
    }
    if (transactionAtMs.present) {
      map['transaction_at_ms'] = Variable<int>(transactionAtMs.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (mccCode.present) {
      map['mcc_code'] = Variable<String>(mccCode.value);
    }
    if (mccSource.present) {
      map['mcc_source'] = Variable<String>(mccSource.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (cashbackEstimatedMinor.present) {
      map['cashback_estimated_minor'] = Variable<int>(
        cashbackEstimatedMinor.value,
      );
    }
    if (cashbackConfidencePpm.present) {
      map['cashback_confidence_ppm'] = Variable<int>(
        cashbackConfidencePpm.value,
      );
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (deletedAtMs.present) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<int>(serverVersion.value);
    }
    if (lastSyncedAtMs.present) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('userCardId: $userCardId, ')
          ..write('merchantId: $merchantId, ')
          ..write('transactionAtMs: $transactionAtMs, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currency: $currency, ')
          ..write('mccCode: $mccCode, ')
          ..write('mccSource: $mccSource, ')
          ..write('category: $category, ')
          ..write('cashbackEstimatedMinor: $cashbackEstimatedMinor, ')
          ..write('cashbackConfidencePpm: $cashbackConfidencePpm, ')
          ..write('source: $source, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCashbackCalculationsTable extends LocalCashbackCalculations
    with
        TableInfo<
          $LocalCashbackCalculationsTable,
          LocalCashbackCalculationRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCashbackCalculationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_transactions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _userCardIdMeta = const VerificationMeta(
    'userCardId',
  );
  @override
  late final GeneratedColumn<String> userCardId = GeneratedColumn<String>(
    'user_card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_user_cards (id)',
    ),
  );
  static const VerificationMeta _rewardRuleIdMeta = const VerificationMeta(
    'rewardRuleId',
  );
  @override
  late final GeneratedColumn<String> rewardRuleId = GeneratedColumn<String>(
    'reward_rule_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCashbackMinorMeta =
      const VerificationMeta('estimatedCashbackMinor');
  @override
  late final GeneratedColumn<int> estimatedCashbackMinor = GeneratedColumn<int>(
    'estimated_cashback_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appliedRatePpmMeta = const VerificationMeta(
    'appliedRatePpm',
  );
  @override
  late final GeneratedColumn<int> appliedRatePpm = GeneratedColumn<int>(
    'applied_rate_ppm',
    aliasedName,
    true,
    check: () =>
        appliedRatePpm.isNull() |
        ComparableExpr(appliedRatePpm).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidencePpmMeta = const VerificationMeta(
    'confidencePpm',
  );
  @override
  late final GeneratedColumn<int> confidencePpm = GeneratedColumn<int>(
    'confidence_ppm',
    aliasedName,
    true,
    check: () =>
        confidencePpm.isNull() |
        ComparableExpr(confidencePpm).isBetweenValues(0, 1000000),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('estimated'),
  );
  static const VerificationMeta _calculationSourceMeta = const VerificationMeta(
    'calculationSource',
  );
  @override
  late final GeneratedColumn<String> calculationSource =
      GeneratedColumn<String>(
        'calculation_source',
        aliasedName,
        false,
        check: () => calculationSource.isIn(const ['local', 'server']),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('local'),
      );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    transactionId,
    userCardId,
    rewardRuleId,
    estimatedCashbackMinor,
    appliedRatePpm,
    confidencePpm,
    explanation,
    status,
    calculationSource,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cashback_calculations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCashbackCalculationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('user_card_id')) {
      context.handle(
        _userCardIdMeta,
        userCardId.isAcceptableOrUnknown(
          data['user_card_id']!,
          _userCardIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userCardIdMeta);
    }
    if (data.containsKey('reward_rule_id')) {
      context.handle(
        _rewardRuleIdMeta,
        rewardRuleId.isAcceptableOrUnknown(
          data['reward_rule_id']!,
          _rewardRuleIdMeta,
        ),
      );
    }
    if (data.containsKey('estimated_cashback_minor')) {
      context.handle(
        _estimatedCashbackMinorMeta,
        estimatedCashbackMinor.isAcceptableOrUnknown(
          data['estimated_cashback_minor']!,
          _estimatedCashbackMinorMeta,
        ),
      );
    }
    if (data.containsKey('applied_rate_ppm')) {
      context.handle(
        _appliedRatePpmMeta,
        appliedRatePpm.isAcceptableOrUnknown(
          data['applied_rate_ppm']!,
          _appliedRatePpmMeta,
        ),
      );
    }
    if (data.containsKey('confidence_ppm')) {
      context.handle(
        _confidencePpmMeta,
        confidencePpm.isAcceptableOrUnknown(
          data['confidence_ppm']!,
          _confidencePpmMeta,
        ),
      );
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('calculation_source')) {
      context.handle(
        _calculationSourceMeta,
        calculationSource.isAcceptableOrUnknown(
          data['calculation_source']!,
          _calculationSourceMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {transactionId, calculationSource},
  ];
  @override
  LocalCashbackCalculationRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashbackCalculationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      userCardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_card_id'],
      )!,
      rewardRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reward_rule_id'],
      ),
      estimatedCashbackMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_cashback_minor'],
      ),
      appliedRatePpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}applied_rate_ppm'],
      ),
      confidencePpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence_ppm'],
      ),
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      calculationSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calculation_source'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $LocalCashbackCalculationsTable createAlias(String alias) {
    return $LocalCashbackCalculationsTable(attachedDatabase, alias);
  }
}

class LocalCashbackCalculationRow extends DataClass
    implements Insertable<LocalCashbackCalculationRow> {
  final String id;
  final String profileId;
  final String transactionId;
  final String userCardId;
  final String? rewardRuleId;
  final int? estimatedCashbackMinor;
  final int? appliedRatePpm;
  final int? confidencePpm;
  final String? explanation;
  final String status;
  final String calculationSource;
  final int createdAtMs;
  final int updatedAtMs;
  const LocalCashbackCalculationRow({
    required this.id,
    required this.profileId,
    required this.transactionId,
    required this.userCardId,
    this.rewardRuleId,
    this.estimatedCashbackMinor,
    this.appliedRatePpm,
    this.confidencePpm,
    this.explanation,
    required this.status,
    required this.calculationSource,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['transaction_id'] = Variable<String>(transactionId);
    map['user_card_id'] = Variable<String>(userCardId);
    if (!nullToAbsent || rewardRuleId != null) {
      map['reward_rule_id'] = Variable<String>(rewardRuleId);
    }
    if (!nullToAbsent || estimatedCashbackMinor != null) {
      map['estimated_cashback_minor'] = Variable<int>(estimatedCashbackMinor);
    }
    if (!nullToAbsent || appliedRatePpm != null) {
      map['applied_rate_ppm'] = Variable<int>(appliedRatePpm);
    }
    if (!nullToAbsent || confidencePpm != null) {
      map['confidence_ppm'] = Variable<int>(confidencePpm);
    }
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    map['status'] = Variable<String>(status);
    map['calculation_source'] = Variable<String>(calculationSource);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  LocalCashbackCalculationsCompanion toCompanion(bool nullToAbsent) {
    return LocalCashbackCalculationsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      transactionId: Value(transactionId),
      userCardId: Value(userCardId),
      rewardRuleId: rewardRuleId == null && nullToAbsent
          ? const Value.absent()
          : Value(rewardRuleId),
      estimatedCashbackMinor: estimatedCashbackMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCashbackMinor),
      appliedRatePpm: appliedRatePpm == null && nullToAbsent
          ? const Value.absent()
          : Value(appliedRatePpm),
      confidencePpm: confidencePpm == null && nullToAbsent
          ? const Value.absent()
          : Value(confidencePpm),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      status: Value(status),
      calculationSource: Value(calculationSource),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory LocalCashbackCalculationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashbackCalculationRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      userCardId: serializer.fromJson<String>(json['userCardId']),
      rewardRuleId: serializer.fromJson<String?>(json['rewardRuleId']),
      estimatedCashbackMinor: serializer.fromJson<int?>(
        json['estimatedCashbackMinor'],
      ),
      appliedRatePpm: serializer.fromJson<int?>(json['appliedRatePpm']),
      confidencePpm: serializer.fromJson<int?>(json['confidencePpm']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      status: serializer.fromJson<String>(json['status']),
      calculationSource: serializer.fromJson<String>(json['calculationSource']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'transactionId': serializer.toJson<String>(transactionId),
      'userCardId': serializer.toJson<String>(userCardId),
      'rewardRuleId': serializer.toJson<String?>(rewardRuleId),
      'estimatedCashbackMinor': serializer.toJson<int?>(estimatedCashbackMinor),
      'appliedRatePpm': serializer.toJson<int?>(appliedRatePpm),
      'confidencePpm': serializer.toJson<int?>(confidencePpm),
      'explanation': serializer.toJson<String?>(explanation),
      'status': serializer.toJson<String>(status),
      'calculationSource': serializer.toJson<String>(calculationSource),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  LocalCashbackCalculationRow copyWith({
    String? id,
    String? profileId,
    String? transactionId,
    String? userCardId,
    Value<String?> rewardRuleId = const Value.absent(),
    Value<int?> estimatedCashbackMinor = const Value.absent(),
    Value<int?> appliedRatePpm = const Value.absent(),
    Value<int?> confidencePpm = const Value.absent(),
    Value<String?> explanation = const Value.absent(),
    String? status,
    String? calculationSource,
    int? createdAtMs,
    int? updatedAtMs,
  }) => LocalCashbackCalculationRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    transactionId: transactionId ?? this.transactionId,
    userCardId: userCardId ?? this.userCardId,
    rewardRuleId: rewardRuleId.present ? rewardRuleId.value : this.rewardRuleId,
    estimatedCashbackMinor: estimatedCashbackMinor.present
        ? estimatedCashbackMinor.value
        : this.estimatedCashbackMinor,
    appliedRatePpm: appliedRatePpm.present
        ? appliedRatePpm.value
        : this.appliedRatePpm,
    confidencePpm: confidencePpm.present
        ? confidencePpm.value
        : this.confidencePpm,
    explanation: explanation.present ? explanation.value : this.explanation,
    status: status ?? this.status,
    calculationSource: calculationSource ?? this.calculationSource,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  LocalCashbackCalculationRow copyWithCompanion(
    LocalCashbackCalculationsCompanion data,
  ) {
    return LocalCashbackCalculationRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      userCardId: data.userCardId.present
          ? data.userCardId.value
          : this.userCardId,
      rewardRuleId: data.rewardRuleId.present
          ? data.rewardRuleId.value
          : this.rewardRuleId,
      estimatedCashbackMinor: data.estimatedCashbackMinor.present
          ? data.estimatedCashbackMinor.value
          : this.estimatedCashbackMinor,
      appliedRatePpm: data.appliedRatePpm.present
          ? data.appliedRatePpm.value
          : this.appliedRatePpm,
      confidencePpm: data.confidencePpm.present
          ? data.confidencePpm.value
          : this.confidencePpm,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      status: data.status.present ? data.status.value : this.status,
      calculationSource: data.calculationSource.present
          ? data.calculationSource.value
          : this.calculationSource,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashbackCalculationRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('transactionId: $transactionId, ')
          ..write('userCardId: $userCardId, ')
          ..write('rewardRuleId: $rewardRuleId, ')
          ..write('estimatedCashbackMinor: $estimatedCashbackMinor, ')
          ..write('appliedRatePpm: $appliedRatePpm, ')
          ..write('confidencePpm: $confidencePpm, ')
          ..write('explanation: $explanation, ')
          ..write('status: $status, ')
          ..write('calculationSource: $calculationSource, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    transactionId,
    userCardId,
    rewardRuleId,
    estimatedCashbackMinor,
    appliedRatePpm,
    confidencePpm,
    explanation,
    status,
    calculationSource,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashbackCalculationRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.transactionId == this.transactionId &&
          other.userCardId == this.userCardId &&
          other.rewardRuleId == this.rewardRuleId &&
          other.estimatedCashbackMinor == this.estimatedCashbackMinor &&
          other.appliedRatePpm == this.appliedRatePpm &&
          other.confidencePpm == this.confidencePpm &&
          other.explanation == this.explanation &&
          other.status == this.status &&
          other.calculationSource == this.calculationSource &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class LocalCashbackCalculationsCompanion
    extends UpdateCompanion<LocalCashbackCalculationRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> transactionId;
  final Value<String> userCardId;
  final Value<String?> rewardRuleId;
  final Value<int?> estimatedCashbackMinor;
  final Value<int?> appliedRatePpm;
  final Value<int?> confidencePpm;
  final Value<String?> explanation;
  final Value<String> status;
  final Value<String> calculationSource;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const LocalCashbackCalculationsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.userCardId = const Value.absent(),
    this.rewardRuleId = const Value.absent(),
    this.estimatedCashbackMinor = const Value.absent(),
    this.appliedRatePpm = const Value.absent(),
    this.confidencePpm = const Value.absent(),
    this.explanation = const Value.absent(),
    this.status = const Value.absent(),
    this.calculationSource = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCashbackCalculationsCompanion.insert({
    required String id,
    required String profileId,
    required String transactionId,
    required String userCardId,
    this.rewardRuleId = const Value.absent(),
    this.estimatedCashbackMinor = const Value.absent(),
    this.appliedRatePpm = const Value.absent(),
    this.confidencePpm = const Value.absent(),
    this.explanation = const Value.absent(),
    this.status = const Value.absent(),
    this.calculationSource = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       transactionId = Value(transactionId),
       userCardId = Value(userCardId),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LocalCashbackCalculationRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? transactionId,
    Expression<String>? userCardId,
    Expression<String>? rewardRuleId,
    Expression<int>? estimatedCashbackMinor,
    Expression<int>? appliedRatePpm,
    Expression<int>? confidencePpm,
    Expression<String>? explanation,
    Expression<String>? status,
    Expression<String>? calculationSource,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (userCardId != null) 'user_card_id': userCardId,
      if (rewardRuleId != null) 'reward_rule_id': rewardRuleId,
      if (estimatedCashbackMinor != null)
        'estimated_cashback_minor': estimatedCashbackMinor,
      if (appliedRatePpm != null) 'applied_rate_ppm': appliedRatePpm,
      if (confidencePpm != null) 'confidence_ppm': confidencePpm,
      if (explanation != null) 'explanation': explanation,
      if (status != null) 'status': status,
      if (calculationSource != null) 'calculation_source': calculationSource,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashbackCalculationsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? transactionId,
    Value<String>? userCardId,
    Value<String?>? rewardRuleId,
    Value<int?>? estimatedCashbackMinor,
    Value<int?>? appliedRatePpm,
    Value<int?>? confidencePpm,
    Value<String?>? explanation,
    Value<String>? status,
    Value<String>? calculationSource,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return LocalCashbackCalculationsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      transactionId: transactionId ?? this.transactionId,
      userCardId: userCardId ?? this.userCardId,
      rewardRuleId: rewardRuleId ?? this.rewardRuleId,
      estimatedCashbackMinor:
          estimatedCashbackMinor ?? this.estimatedCashbackMinor,
      appliedRatePpm: appliedRatePpm ?? this.appliedRatePpm,
      confidencePpm: confidencePpm ?? this.confidencePpm,
      explanation: explanation ?? this.explanation,
      status: status ?? this.status,
      calculationSource: calculationSource ?? this.calculationSource,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (userCardId.present) {
      map['user_card_id'] = Variable<String>(userCardId.value);
    }
    if (rewardRuleId.present) {
      map['reward_rule_id'] = Variable<String>(rewardRuleId.value);
    }
    if (estimatedCashbackMinor.present) {
      map['estimated_cashback_minor'] = Variable<int>(
        estimatedCashbackMinor.value,
      );
    }
    if (appliedRatePpm.present) {
      map['applied_rate_ppm'] = Variable<int>(appliedRatePpm.value);
    }
    if (confidencePpm.present) {
      map['confidence_ppm'] = Variable<int>(confidencePpm.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (calculationSource.present) {
      map['calculation_source'] = Variable<String>(calculationSource.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashbackCalculationsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('transactionId: $transactionId, ')
          ..write('userCardId: $userCardId, ')
          ..write('rewardRuleId: $rewardRuleId, ')
          ..write('estimatedCashbackMinor: $estimatedCashbackMinor, ')
          ..write('appliedRatePpm: $appliedRatePpm, ')
          ..write('confidencePpm: $confidencePpm, ')
          ..write('explanation: $explanation, ')
          ..write('status: $status, ')
          ..write('calculationSource: $calculationSource, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncConflictsTable extends SyncConflicts
    with TableInfo<$SyncConflictsTable, SyncConflictRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncConflictsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _mutationIdMeta = const VerificationMeta(
    'mutationId',
  );
  @override
  late final GeneratedColumn<String> mutationId = GeneratedColumn<String>(
    'mutation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPayloadJsonMeta = const VerificationMeta(
    'localPayloadJson',
  );
  @override
  late final GeneratedColumn<String> localPayloadJson = GeneratedColumn<String>(
    'local_payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverPayloadJsonMeta = const VerificationMeta(
    'serverPayloadJson',
  );
  @override
  late final GeneratedColumn<String> serverPayloadJson =
      GeneratedColumn<String>(
        'server_payload_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _serverVersionMeta = const VerificationMeta(
    'serverVersion',
  );
  @override
  late final GeneratedColumn<int> serverVersion = GeneratedColumn<int>(
    'server_version',
    aliasedName,
    false,
    check: () => ComparableExpr(serverVersion).isBiggerOrEqualValue(1),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detectedAtMsMeta = const VerificationMeta(
    'detectedAtMs',
  );
  @override
  late final GeneratedColumn<int> detectedAtMs = GeneratedColumn<int>(
    'detected_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolvedAtMsMeta = const VerificationMeta(
    'resolvedAtMs',
  );
  @override
  late final GeneratedColumn<int> resolvedAtMs = GeneratedColumn<int>(
    'resolved_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resolutionMeta = const VerificationMeta(
    'resolution',
  );
  @override
  late final GeneratedColumn<String> resolution = GeneratedColumn<String>(
    'resolution',
    aliasedName,
    true,
    check: () =>
        resolution.isNull() |
        resolution.isIn(const ['keep_local', 'keep_server', 'merged']),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    mutationId,
    entityType,
    entityId,
    localPayloadJson,
    serverPayloadJson,
    serverVersion,
    detectedAtMs,
    resolvedAtMs,
    resolution,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_conflicts';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncConflictRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('mutation_id')) {
      context.handle(
        _mutationIdMeta,
        mutationId.isAcceptableOrUnknown(data['mutation_id']!, _mutationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mutationIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('local_payload_json')) {
      context.handle(
        _localPayloadJsonMeta,
        localPayloadJson.isAcceptableOrUnknown(
          data['local_payload_json']!,
          _localPayloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localPayloadJsonMeta);
    }
    if (data.containsKey('server_payload_json')) {
      context.handle(
        _serverPayloadJsonMeta,
        serverPayloadJson.isAcceptableOrUnknown(
          data['server_payload_json']!,
          _serverPayloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serverPayloadJsonMeta);
    }
    if (data.containsKey('server_version')) {
      context.handle(
        _serverVersionMeta,
        serverVersion.isAcceptableOrUnknown(
          data['server_version']!,
          _serverVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serverVersionMeta);
    }
    if (data.containsKey('detected_at_ms')) {
      context.handle(
        _detectedAtMsMeta,
        detectedAtMs.isAcceptableOrUnknown(
          data['detected_at_ms']!,
          _detectedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detectedAtMsMeta);
    }
    if (data.containsKey('resolved_at_ms')) {
      context.handle(
        _resolvedAtMsMeta,
        resolvedAtMs.isAcceptableOrUnknown(
          data['resolved_at_ms']!,
          _resolvedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('resolution')) {
      context.handle(
        _resolutionMeta,
        resolution.isAcceptableOrUnknown(data['resolution']!, _resolutionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncConflictRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncConflictRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      mutationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mutation_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      localPayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_payload_json'],
      )!,
      serverPayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_payload_json'],
      )!,
      serverVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_version'],
      )!,
      detectedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}detected_at_ms'],
      )!,
      resolvedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resolved_at_ms'],
      ),
      resolution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolution'],
      ),
    );
  }

  @override
  $SyncConflictsTable createAlias(String alias) {
    return $SyncConflictsTable(attachedDatabase, alias);
  }
}

class SyncConflictRow extends DataClass implements Insertable<SyncConflictRow> {
  final String id;
  final String profileId;
  final String mutationId;
  final String entityType;
  final String entityId;
  final String localPayloadJson;
  final String serverPayloadJson;
  final int serverVersion;
  final int detectedAtMs;
  final int? resolvedAtMs;
  final String? resolution;
  const SyncConflictRow({
    required this.id,
    required this.profileId,
    required this.mutationId,
    required this.entityType,
    required this.entityId,
    required this.localPayloadJson,
    required this.serverPayloadJson,
    required this.serverVersion,
    required this.detectedAtMs,
    this.resolvedAtMs,
    this.resolution,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['mutation_id'] = Variable<String>(mutationId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['local_payload_json'] = Variable<String>(localPayloadJson);
    map['server_payload_json'] = Variable<String>(serverPayloadJson);
    map['server_version'] = Variable<int>(serverVersion);
    map['detected_at_ms'] = Variable<int>(detectedAtMs);
    if (!nullToAbsent || resolvedAtMs != null) {
      map['resolved_at_ms'] = Variable<int>(resolvedAtMs);
    }
    if (!nullToAbsent || resolution != null) {
      map['resolution'] = Variable<String>(resolution);
    }
    return map;
  }

  SyncConflictsCompanion toCompanion(bool nullToAbsent) {
    return SyncConflictsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      mutationId: Value(mutationId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      localPayloadJson: Value(localPayloadJson),
      serverPayloadJson: Value(serverPayloadJson),
      serverVersion: Value(serverVersion),
      detectedAtMs: Value(detectedAtMs),
      resolvedAtMs: resolvedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAtMs),
      resolution: resolution == null && nullToAbsent
          ? const Value.absent()
          : Value(resolution),
    );
  }

  factory SyncConflictRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncConflictRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      mutationId: serializer.fromJson<String>(json['mutationId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      localPayloadJson: serializer.fromJson<String>(json['localPayloadJson']),
      serverPayloadJson: serializer.fromJson<String>(json['serverPayloadJson']),
      serverVersion: serializer.fromJson<int>(json['serverVersion']),
      detectedAtMs: serializer.fromJson<int>(json['detectedAtMs']),
      resolvedAtMs: serializer.fromJson<int?>(json['resolvedAtMs']),
      resolution: serializer.fromJson<String?>(json['resolution']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'mutationId': serializer.toJson<String>(mutationId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'localPayloadJson': serializer.toJson<String>(localPayloadJson),
      'serverPayloadJson': serializer.toJson<String>(serverPayloadJson),
      'serverVersion': serializer.toJson<int>(serverVersion),
      'detectedAtMs': serializer.toJson<int>(detectedAtMs),
      'resolvedAtMs': serializer.toJson<int?>(resolvedAtMs),
      'resolution': serializer.toJson<String?>(resolution),
    };
  }

  SyncConflictRow copyWith({
    String? id,
    String? profileId,
    String? mutationId,
    String? entityType,
    String? entityId,
    String? localPayloadJson,
    String? serverPayloadJson,
    int? serverVersion,
    int? detectedAtMs,
    Value<int?> resolvedAtMs = const Value.absent(),
    Value<String?> resolution = const Value.absent(),
  }) => SyncConflictRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    mutationId: mutationId ?? this.mutationId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    localPayloadJson: localPayloadJson ?? this.localPayloadJson,
    serverPayloadJson: serverPayloadJson ?? this.serverPayloadJson,
    serverVersion: serverVersion ?? this.serverVersion,
    detectedAtMs: detectedAtMs ?? this.detectedAtMs,
    resolvedAtMs: resolvedAtMs.present ? resolvedAtMs.value : this.resolvedAtMs,
    resolution: resolution.present ? resolution.value : this.resolution,
  );
  SyncConflictRow copyWithCompanion(SyncConflictsCompanion data) {
    return SyncConflictRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      mutationId: data.mutationId.present
          ? data.mutationId.value
          : this.mutationId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      localPayloadJson: data.localPayloadJson.present
          ? data.localPayloadJson.value
          : this.localPayloadJson,
      serverPayloadJson: data.serverPayloadJson.present
          ? data.serverPayloadJson.value
          : this.serverPayloadJson,
      serverVersion: data.serverVersion.present
          ? data.serverVersion.value
          : this.serverVersion,
      detectedAtMs: data.detectedAtMs.present
          ? data.detectedAtMs.value
          : this.detectedAtMs,
      resolvedAtMs: data.resolvedAtMs.present
          ? data.resolvedAtMs.value
          : this.resolvedAtMs,
      resolution: data.resolution.present
          ? data.resolution.value
          : this.resolution,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncConflictRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('mutationId: $mutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('localPayloadJson: $localPayloadJson, ')
          ..write('serverPayloadJson: $serverPayloadJson, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('detectedAtMs: $detectedAtMs, ')
          ..write('resolvedAtMs: $resolvedAtMs, ')
          ..write('resolution: $resolution')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    mutationId,
    entityType,
    entityId,
    localPayloadJson,
    serverPayloadJson,
    serverVersion,
    detectedAtMs,
    resolvedAtMs,
    resolution,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncConflictRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.mutationId == this.mutationId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.localPayloadJson == this.localPayloadJson &&
          other.serverPayloadJson == this.serverPayloadJson &&
          other.serverVersion == this.serverVersion &&
          other.detectedAtMs == this.detectedAtMs &&
          other.resolvedAtMs == this.resolvedAtMs &&
          other.resolution == this.resolution);
}

class SyncConflictsCompanion extends UpdateCompanion<SyncConflictRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> mutationId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> localPayloadJson;
  final Value<String> serverPayloadJson;
  final Value<int> serverVersion;
  final Value<int> detectedAtMs;
  final Value<int?> resolvedAtMs;
  final Value<String?> resolution;
  final Value<int> rowid;
  const SyncConflictsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.mutationId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.localPayloadJson = const Value.absent(),
    this.serverPayloadJson = const Value.absent(),
    this.serverVersion = const Value.absent(),
    this.detectedAtMs = const Value.absent(),
    this.resolvedAtMs = const Value.absent(),
    this.resolution = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncConflictsCompanion.insert({
    required String id,
    required String profileId,
    required String mutationId,
    required String entityType,
    required String entityId,
    required String localPayloadJson,
    required String serverPayloadJson,
    required int serverVersion,
    required int detectedAtMs,
    this.resolvedAtMs = const Value.absent(),
    this.resolution = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       mutationId = Value(mutationId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       localPayloadJson = Value(localPayloadJson),
       serverPayloadJson = Value(serverPayloadJson),
       serverVersion = Value(serverVersion),
       detectedAtMs = Value(detectedAtMs);
  static Insertable<SyncConflictRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? mutationId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? localPayloadJson,
    Expression<String>? serverPayloadJson,
    Expression<int>? serverVersion,
    Expression<int>? detectedAtMs,
    Expression<int>? resolvedAtMs,
    Expression<String>? resolution,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (mutationId != null) 'mutation_id': mutationId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (localPayloadJson != null) 'local_payload_json': localPayloadJson,
      if (serverPayloadJson != null) 'server_payload_json': serverPayloadJson,
      if (serverVersion != null) 'server_version': serverVersion,
      if (detectedAtMs != null) 'detected_at_ms': detectedAtMs,
      if (resolvedAtMs != null) 'resolved_at_ms': resolvedAtMs,
      if (resolution != null) 'resolution': resolution,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncConflictsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? mutationId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? localPayloadJson,
    Value<String>? serverPayloadJson,
    Value<int>? serverVersion,
    Value<int>? detectedAtMs,
    Value<int?>? resolvedAtMs,
    Value<String?>? resolution,
    Value<int>? rowid,
  }) {
    return SyncConflictsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      mutationId: mutationId ?? this.mutationId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      localPayloadJson: localPayloadJson ?? this.localPayloadJson,
      serverPayloadJson: serverPayloadJson ?? this.serverPayloadJson,
      serverVersion: serverVersion ?? this.serverVersion,
      detectedAtMs: detectedAtMs ?? this.detectedAtMs,
      resolvedAtMs: resolvedAtMs ?? this.resolvedAtMs,
      resolution: resolution ?? this.resolution,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (mutationId.present) {
      map['mutation_id'] = Variable<String>(mutationId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (localPayloadJson.present) {
      map['local_payload_json'] = Variable<String>(localPayloadJson.value);
    }
    if (serverPayloadJson.present) {
      map['server_payload_json'] = Variable<String>(serverPayloadJson.value);
    }
    if (serverVersion.present) {
      map['server_version'] = Variable<int>(serverVersion.value);
    }
    if (detectedAtMs.present) {
      map['detected_at_ms'] = Variable<int>(detectedAtMs.value);
    }
    if (resolvedAtMs.present) {
      map['resolved_at_ms'] = Variable<int>(resolvedAtMs.value);
    }
    if (resolution.present) {
      map['resolution'] = Variable<String>(resolution.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncConflictsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('mutationId: $mutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('localPayloadJson: $localPayloadJson, ')
          ..write('serverPayloadJson: $serverPayloadJson, ')
          ..write('serverVersion: $serverVersion, ')
          ..write('detectedAtMs: $detectedAtMs, ')
          ..write('resolvedAtMs: $resolvedAtMs, ')
          ..write('resolution: $resolution, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalProfilesTable localProfiles = $LocalProfilesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $MembershipsCacheTable membershipsCache = $MembershipsCacheTable(
    this,
  );
  late final $BanksCacheTable banksCache = $BanksCacheTable(this);
  late final $CreditCardsCacheTable creditCardsCache = $CreditCardsCacheTable(
    this,
  );
  late final $MerchantCategoryCodesCacheTable merchantCategoryCodesCache =
      $MerchantCategoryCodesCacheTable(this);
  late final $RewardRulesCacheTable rewardRulesCache = $RewardRulesCacheTable(
    this,
  );
  late final $RewardRuleMccsCacheTable rewardRuleMccsCache =
      $RewardRuleMccsCacheTable(this);
  late final $MerchantMccCandidatesCacheTable merchantMccCandidatesCache =
      $MerchantMccCandidatesCacheTable(this);
  late final $MerchantBranchesCacheTable merchantBranchesCache =
      $MerchantBranchesCacheTable(this);
  late final $LocalUserCardsTable localUserCards = $LocalUserCardsTable(this);
  late final $LocalMerchantMccContributionsTable localMerchantMccContributions =
      $LocalMerchantMccContributionsTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $SyncStateTable syncState = $SyncStateTable(this);
  late final $LocalMerchantsTable localMerchants = $LocalMerchantsTable(this);
  late final $LocalTransactionsTable localTransactions =
      $LocalTransactionsTable(this);
  late final $LocalCashbackCalculationsTable localCashbackCalculations =
      $LocalCashbackCalculationsTable(this);
  late final $SyncConflictsTable syncConflicts = $SyncConflictsTable(this);
  late final Index idxLocalProfilesSyncStatus = Index(
    'idx_local_profiles_sync_status',
    'CREATE INDEX idx_local_profiles_sync_status ON local_profiles (sync_status, updated_at_ms)',
  );
  late final Index uqLocalProfilesAuthUser = Index(
    'uq_local_profiles_auth_user',
    'CREATE UNIQUE INDEX uq_local_profiles_auth_user ON local_profiles (auth_user_id) WHERE auth_user_id IS NOT NULL AND deleted_at_ms IS NULL',
  );
  late final Index uqLocalProfilesServerUser = Index(
    'uq_local_profiles_server_user',
    'CREATE UNIQUE INDEX uq_local_profiles_server_user ON local_profiles (server_user_id) WHERE server_user_id IS NOT NULL AND deleted_at_ms IS NULL',
  );
  late final Index uqLocalProfilesSingleGuest = Index(
    'uq_local_profiles_single_guest',
    'CREATE UNIQUE INDEX uq_local_profiles_single_guest ON local_profiles (access_mode) WHERE access_mode = \'guest\' AND deleted_at_ms IS NULL',
  );
  late final Index uqAppSettingsInstallation = Index(
    'uq_app_settings_installation',
    'CREATE UNIQUE INDEX uq_app_settings_installation ON app_settings (installation_id)',
  );
  late final Index idxBanksCacheName = Index(
    'idx_banks_cache_name',
    'CREATE INDEX idx_banks_cache_name ON banks_cache (name)',
  );
  late final Index idxBanksCacheShortName = Index(
    'idx_banks_cache_short_name',
    'CREATE INDEX idx_banks_cache_short_name ON banks_cache (short_name)',
  );
  late final Index uqBanksCacheSwiftCode = Index(
    'uq_banks_cache_swift_code',
    'CREATE UNIQUE INDEX uq_banks_cache_swift_code ON banks_cache (swift_code) WHERE swift_code IS NOT NULL',
  );
  late final Index idxCreditCardsCacheBankActive = Index(
    'idx_credit_cards_cache_bank_active',
    'CREATE INDEX idx_credit_cards_cache_bank_active ON credit_cards_cache (bank_id, is_active)',
  );
  late final Index idxCreditCardsCacheName = Index(
    'idx_credit_cards_cache_name',
    'CREATE INDEX idx_credit_cards_cache_name ON credit_cards_cache (name)',
  );
  late final Index idxMccCacheCategoryActive = Index(
    'idx_mcc_cache_category_active',
    'CREATE INDEX idx_mcc_cache_category_active ON merchant_category_codes_cache (category, is_active)',
  );
  late final Index idxRewardRulesCacheCardActive = Index(
    'idx_reward_rules_cache_card_active',
    'CREATE INDEX idx_reward_rules_cache_card_active ON reward_rules_cache (credit_card_id, is_active)',
  );
  late final Index idxRewardRuleMccsCacheMcc = Index(
    'idx_reward_rule_mccs_cache_mcc',
    'CREATE INDEX idx_reward_rule_mccs_cache_mcc ON reward_rule_mccs_cache (mcc_code)',
  );
  late final Index idxMerchantMccCandidatesCacheName = Index(
    'idx_merchant_mcc_candidates_cache_name',
    'CREATE INDEX idx_merchant_mcc_candidates_cache_name ON merchant_mcc_candidates_cache (merchant_name_normalized)',
  );
  late final Index idxMerchantMccCandidatesCacheMcc = Index(
    'idx_merchant_mcc_candidates_cache_mcc',
    'CREATE INDEX idx_merchant_mcc_candidates_cache_mcc ON merchant_mcc_candidates_cache (mcc_code)',
  );
  late final Index idxMerchantBranchesCacheName = Index(
    'idx_merchant_branches_cache_name',
    'CREATE INDEX idx_merchant_branches_cache_name ON merchant_branches_cache (name_normalized)',
  );
  late final Index idxLocalUserCardsProfileActive = Index(
    'idx_local_user_cards_profile_active',
    'CREATE INDEX idx_local_user_cards_profile_active ON local_user_cards (profile_id, deleted_at_ms)',
  );
  late final Index uqLocalUserCardsDefault = Index(
    'uq_local_user_cards_default',
    'CREATE UNIQUE INDEX uq_local_user_cards_default ON local_user_cards (profile_id) WHERE is_default = 1 AND deleted_at_ms IS NULL',
  );
  late final Index idxLocalMerchantMccContributionsProfileMerchant = Index(
    'idx_local_merchant_mcc_contributions_profile_merchant',
    'CREATE INDEX idx_local_merchant_mcc_contributions_profile_merchant ON local_merchant_mcc_contributions (profile_id, merchant_server_id)',
  );
  late final Index idxSyncOutboxReady = Index(
    'idx_sync_outbox_ready',
    'CREATE INDEX idx_sync_outbox_ready ON sync_outbox (profile_id, next_attempt_at_ms, created_at_ms)',
  );
  late final Index idxLocalMerchantsProfileName = Index(
    'idx_local_merchants_profile_name',
    'CREATE INDEX idx_local_merchants_profile_name ON local_merchants (profile_id, name_normalized)',
  );
  late final Index uqLocalMerchantsServerId = Index(
    'uq_local_merchants_server_id',
    'CREATE UNIQUE INDEX uq_local_merchants_server_id ON local_merchants (profile_id, server_merchant_id) WHERE server_merchant_id IS NOT NULL AND deleted_at_ms IS NULL',
  );
  late final Index idxLocalTransactionsProfileDate = Index(
    'idx_local_transactions_profile_date',
    'CREATE INDEX idx_local_transactions_profile_date ON local_transactions (profile_id, transaction_at_ms)',
  );
  late final Index idxLocalTransactionsCardDate = Index(
    'idx_local_transactions_card_date',
    'CREATE INDEX idx_local_transactions_card_date ON local_transactions (user_card_id, transaction_at_ms)',
  );
  late final Index idxLocalTransactionsProfileSync = Index(
    'idx_local_transactions_profile_sync',
    'CREATE INDEX idx_local_transactions_profile_sync ON local_transactions (profile_id, sync_status)',
  );
  late final Index idxLocalCashbackProfileCard = Index(
    'idx_local_cashback_profile_card',
    'CREATE INDEX idx_local_cashback_profile_card ON local_cashback_calculations (profile_id, user_card_id, created_at_ms)',
  );
  late final Index idxSyncConflictsUnresolved = Index(
    'idx_sync_conflicts_unresolved',
    'CREATE INDEX idx_sync_conflicts_unresolved ON sync_conflicts (profile_id, resolved_at_ms, detected_at_ms)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localProfiles,
    appSettings,
    membershipsCache,
    banksCache,
    creditCardsCache,
    merchantCategoryCodesCache,
    rewardRulesCache,
    rewardRuleMccsCache,
    merchantMccCandidatesCache,
    merchantBranchesCache,
    localUserCards,
    localMerchantMccContributions,
    syncOutbox,
    syncState,
    localMerchants,
    localTransactions,
    localCashbackCalculations,
    syncConflicts,
    idxLocalProfilesSyncStatus,
    uqLocalProfilesAuthUser,
    uqLocalProfilesServerUser,
    uqLocalProfilesSingleGuest,
    uqAppSettingsInstallation,
    idxBanksCacheName,
    idxBanksCacheShortName,
    uqBanksCacheSwiftCode,
    idxCreditCardsCacheBankActive,
    idxCreditCardsCacheName,
    idxMccCacheCategoryActive,
    idxRewardRulesCacheCardActive,
    idxRewardRuleMccsCacheMcc,
    idxMerchantMccCandidatesCacheName,
    idxMerchantMccCandidatesCacheMcc,
    idxMerchantBranchesCacheName,
    idxLocalUserCardsProfileActive,
    uqLocalUserCardsDefault,
    idxLocalMerchantMccContributionsProfileMerchant,
    idxSyncOutboxReady,
    idxLocalMerchantsProfileName,
    uqLocalMerchantsServerId,
    idxLocalTransactionsProfileDate,
    idxLocalTransactionsCardDate,
    idxLocalTransactionsProfileSync,
    idxLocalCashbackProfileCard,
    idxSyncConflictsUnresolved,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('app_settings', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('local_user_cards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate(
          'local_merchant_mcc_contributions',
          kind: UpdateKind.delete,
        ),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_outbox', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('local_merchants', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('local_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('local_cashback_calculations', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('local_cashback_calculations', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'local_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sync_conflicts', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$LocalProfilesTableCreateCompanionBuilder =
    LocalProfilesCompanion Function({
      required String id,
      Value<String?> authUserId,
      Value<String?> serverUserId,
      required String accessMode,
      Value<String?> email,
      required String displayName,
      Value<int?> bornDateAtMs,
      Value<int?> setupCompletedAtMs,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });
typedef $$LocalProfilesTableUpdateCompanionBuilder =
    LocalProfilesCompanion Function({
      Value<String> id,
      Value<String?> authUserId,
      Value<String?> serverUserId,
      Value<String> accessMode,
      Value<String?> email,
      Value<String> displayName,
      Value<int?> bornDateAtMs,
      Value<int?> setupCompletedAtMs,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });

final class $$LocalProfilesTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalProfilesTable, LocalProfileRow> {
  $$LocalProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AppSettingsTable, List<AppSettingsRow>>
  _appSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appSettings,
    aliasName: 'local_profiles__id__app_settings__active_profile_id',
  );

  $$AppSettingsTableProcessedTableManager get appSettingsRefs {
    final manager = $$AppSettingsTableTableManager($_db, $_db.appSettings)
        .filter(
          (f) => f.activeProfileId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_appSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalUserCardsTable, List<LocalUserCardRow>>
  _localUserCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localUserCards,
    aliasName: 'local_profiles__id__local_user_cards__profile_id',
  );

  $$LocalUserCardsTableProcessedTableManager get localUserCardsRefs {
    final manager = $$LocalUserCardsTableTableManager(
      $_db,
      $_db.localUserCards,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localUserCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalMerchantMccContributionsTable,
    List<LocalMerchantMccContributionRow>
  >
  _localMerchantMccContributionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localMerchantMccContributions,
        aliasName:
            'local_profiles__id__local_merchant_mcc_contributions__profile_id',
      );

  $$LocalMerchantMccContributionsTableProcessedTableManager
  get localMerchantMccContributionsRefs {
    final manager = $$LocalMerchantMccContributionsTableTableManager(
      $_db,
      $_db.localMerchantMccContributions,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localMerchantMccContributionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncOutboxTable, List<SyncOutboxRow>>
  _syncOutboxRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncOutbox,
    aliasName: 'local_profiles__id__sync_outbox__profile_id',
  );

  $$SyncOutboxTableProcessedTableManager get syncOutboxRefs {
    final manager = $$SyncOutboxTableTableManager(
      $_db,
      $_db.syncOutbox,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncOutboxRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalMerchantsTable, List<LocalMerchantRow>>
  _localMerchantsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localMerchants,
    aliasName: 'local_profiles__id__local_merchants__profile_id',
  );

  $$LocalMerchantsTableProcessedTableManager get localMerchantsRefs {
    final manager = $$LocalMerchantsTableTableManager(
      $_db,
      $_db.localMerchants,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localMerchantsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalTransactionsTable, List<LocalTransactionRow>>
  _localTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localTransactions,
        aliasName: 'local_profiles__id__local_transactions__profile_id',
      );

  $$LocalTransactionsTableProcessedTableManager get localTransactionsRefs {
    final manager = $$LocalTransactionsTableTableManager(
      $_db,
      $_db.localTransactions,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalCashbackCalculationsTable,
    List<LocalCashbackCalculationRow>
  >
  _localCashbackCalculationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCashbackCalculations,
        aliasName:
            'local_profiles__id__local_cashback_calculations__profile_id',
      );

  $$LocalCashbackCalculationsTableProcessedTableManager
  get localCashbackCalculationsRefs {
    final manager = $$LocalCashbackCalculationsTableTableManager(
      $_db,
      $_db.localCashbackCalculations,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCashbackCalculationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncConflictsTable, List<SyncConflictRow>>
  _syncConflictsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncConflicts,
    aliasName: 'local_profiles__id__sync_conflicts__profile_id',
  );

  $$SyncConflictsTableProcessedTableManager get syncConflictsRefs {
    final manager = $$SyncConflictsTableTableManager(
      $_db,
      $_db.syncConflicts,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncConflictsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProfilesTable> {
  $$LocalProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authUserId => $composableBuilder(
    column: $table.authUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverUserId => $composableBuilder(
    column: $table.serverUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accessMode => $composableBuilder(
    column: $table.accessMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bornDateAtMs => $composableBuilder(
    column: $table.bornDateAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setupCompletedAtMs => $composableBuilder(
    column: $table.setupCompletedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> appSettingsRefs(
    Expression<bool> Function($$AppSettingsTableFilterComposer f) f,
  ) {
    final $$AppSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.activeProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableFilterComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localUserCardsRefs(
    Expression<bool> Function($$LocalUserCardsTableFilterComposer f) f,
  ) {
    final $$LocalUserCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableFilterComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localMerchantMccContributionsRefs(
    Expression<bool> Function(
      $$LocalMerchantMccContributionsTableFilterComposer f,
    )
    f,
  ) {
    final $$LocalMerchantMccContributionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localMerchantMccContributions,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalMerchantMccContributionsTableFilterComposer(
                $db: $db,
                $table: $db.localMerchantMccContributions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> syncOutboxRefs(
    Expression<bool> Function($$SyncOutboxTableFilterComposer f) f,
  ) {
    final $$SyncOutboxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncOutbox,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncOutboxTableFilterComposer(
            $db: $db,
            $table: $db.syncOutbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localMerchantsRefs(
    Expression<bool> Function($$LocalMerchantsTableFilterComposer f) f,
  ) {
    final $$LocalMerchantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localMerchants,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalMerchantsTableFilterComposer(
            $db: $db,
            $table: $db.localMerchants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localTransactionsRefs(
    Expression<bool> Function($$LocalTransactionsTableFilterComposer f) f,
  ) {
    final $$LocalTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localTransactions,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.localTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localCashbackCalculationsRefs(
    Expression<bool> Function($$LocalCashbackCalculationsTableFilterComposer f)
    f,
  ) {
    final $$LocalCashbackCalculationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashbackCalculations,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashbackCalculationsTableFilterComposer(
                $db: $db,
                $table: $db.localCashbackCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> syncConflictsRefs(
    Expression<bool> Function($$SyncConflictsTableFilterComposer f) f,
  ) {
    final $$SyncConflictsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncConflicts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncConflictsTableFilterComposer(
            $db: $db,
            $table: $db.syncConflicts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProfilesTable> {
  $$LocalProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authUserId => $composableBuilder(
    column: $table.authUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverUserId => $composableBuilder(
    column: $table.serverUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accessMode => $composableBuilder(
    column: $table.accessMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bornDateAtMs => $composableBuilder(
    column: $table.bornDateAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setupCompletedAtMs => $composableBuilder(
    column: $table.setupCompletedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProfilesTable> {
  $$LocalProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get authUserId => $composableBuilder(
    column: $table.authUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverUserId => $composableBuilder(
    column: $table.serverUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accessMode => $composableBuilder(
    column: $table.accessMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bornDateAtMs => $composableBuilder(
    column: $table.bornDateAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setupCompletedAtMs => $composableBuilder(
    column: $table.setupCompletedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => column,
  );

  Expression<T> appSettingsRefs<T extends Object>(
    Expression<T> Function($$AppSettingsTableAnnotationComposer a) f,
  ) {
    final $$AppSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.activeProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localUserCardsRefs<T extends Object>(
    Expression<T> Function($$LocalUserCardsTableAnnotationComposer a) f,
  ) {
    final $$LocalUserCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localMerchantMccContributionsRefs<T extends Object>(
    Expression<T> Function(
      $$LocalMerchantMccContributionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$LocalMerchantMccContributionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localMerchantMccContributions,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalMerchantMccContributionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localMerchantMccContributions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> syncOutboxRefs<T extends Object>(
    Expression<T> Function($$SyncOutboxTableAnnotationComposer a) f,
  ) {
    final $$SyncOutboxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncOutbox,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncOutboxTableAnnotationComposer(
            $db: $db,
            $table: $db.syncOutbox,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localMerchantsRefs<T extends Object>(
    Expression<T> Function($$LocalMerchantsTableAnnotationComposer a) f,
  ) {
    final $$LocalMerchantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localMerchants,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalMerchantsTableAnnotationComposer(
            $db: $db,
            $table: $db.localMerchants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localTransactionsRefs<T extends Object>(
    Expression<T> Function($$LocalTransactionsTableAnnotationComposer a) f,
  ) {
    final $$LocalTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localTransactions,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localCashbackCalculationsRefs<T extends Object>(
    Expression<T> Function($$LocalCashbackCalculationsTableAnnotationComposer a)
    f,
  ) {
    final $$LocalCashbackCalculationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashbackCalculations,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashbackCalculationsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashbackCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> syncConflictsRefs<T extends Object>(
    Expression<T> Function($$SyncConflictsTableAnnotationComposer a) f,
  ) {
    final $$SyncConflictsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncConflicts,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncConflictsTableAnnotationComposer(
            $db: $db,
            $table: $db.syncConflicts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalProfilesTable,
          LocalProfileRow,
          $$LocalProfilesTableFilterComposer,
          $$LocalProfilesTableOrderingComposer,
          $$LocalProfilesTableAnnotationComposer,
          $$LocalProfilesTableCreateCompanionBuilder,
          $$LocalProfilesTableUpdateCompanionBuilder,
          (LocalProfileRow, $$LocalProfilesTableReferences),
          LocalProfileRow,
          PrefetchHooks Function({
            bool appSettingsRefs,
            bool localUserCardsRefs,
            bool localMerchantMccContributionsRefs,
            bool syncOutboxRefs,
            bool localMerchantsRefs,
            bool localTransactionsRefs,
            bool localCashbackCalculationsRefs,
            bool syncConflictsRefs,
          })
        > {
  $$LocalProfilesTableTableManager(_$AppDatabase db, $LocalProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> authUserId = const Value.absent(),
                Value<String?> serverUserId = const Value.absent(),
                Value<String> accessMode = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int?> bornDateAtMs = const Value.absent(),
                Value<int?> setupCompletedAtMs = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalProfilesCompanion(
                id: id,
                authUserId: authUserId,
                serverUserId: serverUserId,
                accessMode: accessMode,
                email: email,
                displayName: displayName,
                bornDateAtMs: bornDateAtMs,
                setupCompletedAtMs: setupCompletedAtMs,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> authUserId = const Value.absent(),
                Value<String?> serverUserId = const Value.absent(),
                required String accessMode,
                Value<String?> email = const Value.absent(),
                required String displayName,
                Value<int?> bornDateAtMs = const Value.absent(),
                Value<int?> setupCompletedAtMs = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalProfilesCompanion.insert(
                id: id,
                authUserId: authUserId,
                serverUserId: serverUserId,
                accessMode: accessMode,
                email: email,
                displayName: displayName,
                bornDateAtMs: bornDateAtMs,
                setupCompletedAtMs: setupCompletedAtMs,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                appSettingsRefs = false,
                localUserCardsRefs = false,
                localMerchantMccContributionsRefs = false,
                syncOutboxRefs = false,
                localMerchantsRefs = false,
                localTransactionsRefs = false,
                localCashbackCalculationsRefs = false,
                syncConflictsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (appSettingsRefs) db.appSettings,
                    if (localUserCardsRefs) db.localUserCards,
                    if (localMerchantMccContributionsRefs)
                      db.localMerchantMccContributions,
                    if (syncOutboxRefs) db.syncOutbox,
                    if (localMerchantsRefs) db.localMerchants,
                    if (localTransactionsRefs) db.localTransactions,
                    if (localCashbackCalculationsRefs)
                      db.localCashbackCalculations,
                    if (syncConflictsRefs) db.syncConflicts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (appSettingsRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          AppSettingsRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._appSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).appSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.activeProfileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localUserCardsRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          LocalUserCardRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._localUserCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).localUserCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localMerchantMccContributionsRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          LocalMerchantMccContributionRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._localMerchantMccContributionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).localMerchantMccContributionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncOutboxRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          SyncOutboxRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._syncOutboxRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncOutboxRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localMerchantsRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          LocalMerchantRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._localMerchantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).localMerchantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localTransactionsRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          LocalTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._localTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).localTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCashbackCalculationsRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          LocalCashbackCalculationRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._localCashbackCalculationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).localCashbackCalculationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncConflictsRefs)
                        await $_getPrefetchedData<
                          LocalProfileRow,
                          $LocalProfilesTable,
                          SyncConflictRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProfilesTableReferences
                              ._syncConflictsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncConflictsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalProfilesTable,
      LocalProfileRow,
      $$LocalProfilesTableFilterComposer,
      $$LocalProfilesTableOrderingComposer,
      $$LocalProfilesTableAnnotationComposer,
      $$LocalProfilesTableCreateCompanionBuilder,
      $$LocalProfilesTableUpdateCompanionBuilder,
      (LocalProfileRow, $$LocalProfilesTableReferences),
      LocalProfileRow,
      PrefetchHooks Function({
        bool appSettingsRefs,
        bool localUserCardsRefs,
        bool localMerchantMccContributionsRefs,
        bool syncOutboxRefs,
        bool localMerchantsRefs,
        bool localTransactionsRefs,
        bool localCashbackCalculationsRefs,
        bool syncConflictsRefs,
      })
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      required String installationId,
      Value<String?> activeProfileId,
      required int createdAtMs,
      required int updatedAtMs,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> installationId,
      Value<String?> activeProfileId,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
    });

final class $$AppSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingsRow> {
  $$AppSettingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalProfilesTable _activeProfileIdTable(_$AppDatabase db) => db
      .localProfiles
      .createAlias('app_settings__active_profile_id__local_profiles__id');

  $$LocalProfilesTableProcessedTableManager? get activeProfileId {
    final $_column = $_itemColumn<String>('active_profile_id');
    if ($_column == null) return null;
    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activeProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get activeProfileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeProfileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get activeProfileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeProfileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get installationId => $composableBuilder(
    column: $table.installationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get activeProfileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeProfileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSettingsRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (AppSettingsRow, $$AppSettingsTableReferences),
          AppSettingsRow,
          PrefetchHooks Function({bool activeProfileId})
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> installationId = const Value.absent(),
                Value<String?> activeProfileId = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                installationId: installationId,
                activeProfileId: activeProfileId,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String installationId,
                Value<String?> activeProfileId = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
              }) => AppSettingsCompanion.insert(
                id: id,
                installationId: installationId,
                activeProfileId: activeProfileId,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({activeProfileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (activeProfileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activeProfileId,
                                referencedTable: $$AppSettingsTableReferences
                                    ._activeProfileIdTable(db),
                                referencedColumn: $$AppSettingsTableReferences
                                    ._activeProfileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSettingsRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (AppSettingsRow, $$AppSettingsTableReferences),
      AppSettingsRow,
      PrefetchHooks Function({bool activeProfileId})
    >;
typedef $$MembershipsCacheTableCreateCompanionBuilder =
    MembershipsCacheCompanion Function({
      required String id,
      required String name,
      Value<int?> maxCards,
      Value<int?> maxReceiptScansPerMonth,
      Value<int?> maxCashbackCalculationsPerMonth,
      Value<int?> serverUpdatedAtMs,
      required int datasetVersion,
      Value<int> rowid,
    });
typedef $$MembershipsCacheTableUpdateCompanionBuilder =
    MembershipsCacheCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int?> maxCards,
      Value<int?> maxReceiptScansPerMonth,
      Value<int?> maxCashbackCalculationsPerMonth,
      Value<int?> serverUpdatedAtMs,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$MembershipsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $MembershipsCacheTable> {
  $$MembershipsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxCards => $composableBuilder(
    column: $table.maxCards,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxReceiptScansPerMonth => $composableBuilder(
    column: $table.maxReceiptScansPerMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxCashbackCalculationsPerMonth => $composableBuilder(
    column: $table.maxCashbackCalculationsPerMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembershipsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $MembershipsCacheTable> {
  $$MembershipsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxCards => $composableBuilder(
    column: $table.maxCards,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxReceiptScansPerMonth => $composableBuilder(
    column: $table.maxReceiptScansPerMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxCashbackCalculationsPerMonth =>
      $composableBuilder(
        column: $table.maxCashbackCalculationsPerMonth,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembershipsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembershipsCacheTable> {
  $$MembershipsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get maxCards =>
      $composableBuilder(column: $table.maxCards, builder: (column) => column);

  GeneratedColumn<int> get maxReceiptScansPerMonth => $composableBuilder(
    column: $table.maxReceiptScansPerMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxCashbackCalculationsPerMonth =>
      $composableBuilder(
        column: $table.maxCashbackCalculationsPerMonth,
        builder: (column) => column,
      );

  GeneratedColumn<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$MembershipsCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembershipsCacheTable,
          MembershipCacheRow,
          $$MembershipsCacheTableFilterComposer,
          $$MembershipsCacheTableOrderingComposer,
          $$MembershipsCacheTableAnnotationComposer,
          $$MembershipsCacheTableCreateCompanionBuilder,
          $$MembershipsCacheTableUpdateCompanionBuilder,
          (
            MembershipCacheRow,
            BaseReferences<
              _$AppDatabase,
              $MembershipsCacheTable,
              MembershipCacheRow
            >,
          ),
          MembershipCacheRow,
          PrefetchHooks Function()
        > {
  $$MembershipsCacheTableTableManager(
    _$AppDatabase db,
    $MembershipsCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembershipsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembershipsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembershipsCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> maxCards = const Value.absent(),
                Value<int?> maxReceiptScansPerMonth = const Value.absent(),
                Value<int?> maxCashbackCalculationsPerMonth =
                    const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipsCacheCompanion(
                id: id,
                name: name,
                maxCards: maxCards,
                maxReceiptScansPerMonth: maxReceiptScansPerMonth,
                maxCashbackCalculationsPerMonth:
                    maxCashbackCalculationsPerMonth,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int?> maxCards = const Value.absent(),
                Value<int?> maxReceiptScansPerMonth = const Value.absent(),
                Value<int?> maxCashbackCalculationsPerMonth =
                    const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                required int datasetVersion,
                Value<int> rowid = const Value.absent(),
              }) => MembershipsCacheCompanion.insert(
                id: id,
                name: name,
                maxCards: maxCards,
                maxReceiptScansPerMonth: maxReceiptScansPerMonth,
                maxCashbackCalculationsPerMonth:
                    maxCashbackCalculationsPerMonth,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembershipsCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembershipsCacheTable,
      MembershipCacheRow,
      $$MembershipsCacheTableFilterComposer,
      $$MembershipsCacheTableOrderingComposer,
      $$MembershipsCacheTableAnnotationComposer,
      $$MembershipsCacheTableCreateCompanionBuilder,
      $$MembershipsCacheTableUpdateCompanionBuilder,
      (
        MembershipCacheRow,
        BaseReferences<
          _$AppDatabase,
          $MembershipsCacheTable,
          MembershipCacheRow
        >,
      ),
      MembershipCacheRow,
      PrefetchHooks Function()
    >;
typedef $$BanksCacheTableCreateCompanionBuilder =
    BanksCacheCompanion Function({
      required String id,
      Value<String?> swiftCode,
      required String name,
      Value<String?> shortName,
      Value<int?> serverUpdatedAtMs,
      required int datasetVersion,
      Value<int> rowid,
    });
typedef $$BanksCacheTableUpdateCompanionBuilder =
    BanksCacheCompanion Function({
      Value<String> id,
      Value<String?> swiftCode,
      Value<String> name,
      Value<String?> shortName,
      Value<int?> serverUpdatedAtMs,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$BanksCacheTableFilterComposer
    extends Composer<_$AppDatabase, $BanksCacheTable> {
  $$BanksCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get swiftCode => $composableBuilder(
    column: $table.swiftCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BanksCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $BanksCacheTable> {
  $$BanksCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get swiftCode => $composableBuilder(
    column: $table.swiftCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BanksCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $BanksCacheTable> {
  $$BanksCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get swiftCode =>
      $composableBuilder(column: $table.swiftCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shortName =>
      $composableBuilder(column: $table.shortName, builder: (column) => column);

  GeneratedColumn<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$BanksCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BanksCacheTable,
          BankCacheRow,
          $$BanksCacheTableFilterComposer,
          $$BanksCacheTableOrderingComposer,
          $$BanksCacheTableAnnotationComposer,
          $$BanksCacheTableCreateCompanionBuilder,
          $$BanksCacheTableUpdateCompanionBuilder,
          (
            BankCacheRow,
            BaseReferences<_$AppDatabase, $BanksCacheTable, BankCacheRow>,
          ),
          BankCacheRow,
          PrefetchHooks Function()
        > {
  $$BanksCacheTableTableManager(_$AppDatabase db, $BanksCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BanksCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BanksCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BanksCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> swiftCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> shortName = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BanksCacheCompanion(
                id: id,
                swiftCode: swiftCode,
                name: name,
                shortName: shortName,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> swiftCode = const Value.absent(),
                required String name,
                Value<String?> shortName = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                required int datasetVersion,
                Value<int> rowid = const Value.absent(),
              }) => BanksCacheCompanion.insert(
                id: id,
                swiftCode: swiftCode,
                name: name,
                shortName: shortName,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BanksCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BanksCacheTable,
      BankCacheRow,
      $$BanksCacheTableFilterComposer,
      $$BanksCacheTableOrderingComposer,
      $$BanksCacheTableAnnotationComposer,
      $$BanksCacheTableCreateCompanionBuilder,
      $$BanksCacheTableUpdateCompanionBuilder,
      (
        BankCacheRow,
        BaseReferences<_$AppDatabase, $BanksCacheTable, BankCacheRow>,
      ),
      BankCacheRow,
      PrefetchHooks Function()
    >;
typedef $$CreditCardsCacheTableCreateCompanionBuilder =
    CreditCardsCacheCompanion Function({
      required String id,
      required String bankId,
      required String name,
      Value<String?> network,
      Value<String> cardType,
      Value<String?> annualFeeDecimal,
      Value<String?> sourceUrl,
      Value<int?> lastVerifiedAtMs,
      Value<bool> isActive,
      Value<int?> serverUpdatedAtMs,
      required int datasetVersion,
      Value<int> rowid,
    });
typedef $$CreditCardsCacheTableUpdateCompanionBuilder =
    CreditCardsCacheCompanion Function({
      Value<String> id,
      Value<String> bankId,
      Value<String> name,
      Value<String?> network,
      Value<String> cardType,
      Value<String?> annualFeeDecimal,
      Value<String?> sourceUrl,
      Value<int?> lastVerifiedAtMs,
      Value<bool> isActive,
      Value<int?> serverUpdatedAtMs,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$CreditCardsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardsCacheTable> {
  $$CreditCardsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankId => $composableBuilder(
    column: $table.bankId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get network => $composableBuilder(
    column: $table.network,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardType => $composableBuilder(
    column: $table.cardType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get annualFeeDecimal => $composableBuilder(
    column: $table.annualFeeDecimal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastVerifiedAtMs => $composableBuilder(
    column: $table.lastVerifiedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CreditCardsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardsCacheTable> {
  $$CreditCardsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankId => $composableBuilder(
    column: $table.bankId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get network => $composableBuilder(
    column: $table.network,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardType => $composableBuilder(
    column: $table.cardType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get annualFeeDecimal => $composableBuilder(
    column: $table.annualFeeDecimal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastVerifiedAtMs => $composableBuilder(
    column: $table.lastVerifiedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CreditCardsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardsCacheTable> {
  $$CreditCardsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bankId =>
      $composableBuilder(column: $table.bankId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get network =>
      $composableBuilder(column: $table.network, builder: (column) => column);

  GeneratedColumn<String> get cardType =>
      $composableBuilder(column: $table.cardType, builder: (column) => column);

  GeneratedColumn<String> get annualFeeDecimal => $composableBuilder(
    column: $table.annualFeeDecimal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<int> get lastVerifiedAtMs => $composableBuilder(
    column: $table.lastVerifiedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$CreditCardsCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardsCacheTable,
          CreditCardCacheRow,
          $$CreditCardsCacheTableFilterComposer,
          $$CreditCardsCacheTableOrderingComposer,
          $$CreditCardsCacheTableAnnotationComposer,
          $$CreditCardsCacheTableCreateCompanionBuilder,
          $$CreditCardsCacheTableUpdateCompanionBuilder,
          (
            CreditCardCacheRow,
            BaseReferences<
              _$AppDatabase,
              $CreditCardsCacheTable,
              CreditCardCacheRow
            >,
          ),
          CreditCardCacheRow,
          PrefetchHooks Function()
        > {
  $$CreditCardsCacheTableTableManager(
    _$AppDatabase db,
    $CreditCardsCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditCardsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditCardsCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bankId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> network = const Value.absent(),
                Value<String> cardType = const Value.absent(),
                Value<String?> annualFeeDecimal = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<int?> lastVerifiedAtMs = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditCardsCacheCompanion(
                id: id,
                bankId: bankId,
                name: name,
                network: network,
                cardType: cardType,
                annualFeeDecimal: annualFeeDecimal,
                sourceUrl: sourceUrl,
                lastVerifiedAtMs: lastVerifiedAtMs,
                isActive: isActive,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bankId,
                required String name,
                Value<String?> network = const Value.absent(),
                Value<String> cardType = const Value.absent(),
                Value<String?> annualFeeDecimal = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<int?> lastVerifiedAtMs = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                required int datasetVersion,
                Value<int> rowid = const Value.absent(),
              }) => CreditCardsCacheCompanion.insert(
                id: id,
                bankId: bankId,
                name: name,
                network: network,
                cardType: cardType,
                annualFeeDecimal: annualFeeDecimal,
                sourceUrl: sourceUrl,
                lastVerifiedAtMs: lastVerifiedAtMs,
                isActive: isActive,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CreditCardsCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardsCacheTable,
      CreditCardCacheRow,
      $$CreditCardsCacheTableFilterComposer,
      $$CreditCardsCacheTableOrderingComposer,
      $$CreditCardsCacheTableAnnotationComposer,
      $$CreditCardsCacheTableCreateCompanionBuilder,
      $$CreditCardsCacheTableUpdateCompanionBuilder,
      (
        CreditCardCacheRow,
        BaseReferences<
          _$AppDatabase,
          $CreditCardsCacheTable,
          CreditCardCacheRow
        >,
      ),
      CreditCardCacheRow,
      PrefetchHooks Function()
    >;
typedef $$MerchantCategoryCodesCacheTableCreateCompanionBuilder =
    MerchantCategoryCodesCacheCompanion Function({
      required String code,
      required String description,
      Value<String?> category,
      Value<String?> validPayment,
      Value<bool> isActive,
      Value<int?> serverUpdatedAtMs,
      required int datasetVersion,
      Value<int> rowid,
    });
typedef $$MerchantCategoryCodesCacheTableUpdateCompanionBuilder =
    MerchantCategoryCodesCacheCompanion Function({
      Value<String> code,
      Value<String> description,
      Value<String?> category,
      Value<String?> validPayment,
      Value<bool> isActive,
      Value<int?> serverUpdatedAtMs,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$MerchantCategoryCodesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $MerchantCategoryCodesCacheTable> {
  $$MerchantCategoryCodesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validPayment => $composableBuilder(
    column: $table.validPayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MerchantCategoryCodesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $MerchantCategoryCodesCacheTable> {
  $$MerchantCategoryCodesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validPayment => $composableBuilder(
    column: $table.validPayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MerchantCategoryCodesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $MerchantCategoryCodesCacheTable> {
  $$MerchantCategoryCodesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get validPayment => $composableBuilder(
    column: $table.validPayment,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$MerchantCategoryCodesCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MerchantCategoryCodesCacheTable,
          MerchantCategoryCodeCacheRow,
          $$MerchantCategoryCodesCacheTableFilterComposer,
          $$MerchantCategoryCodesCacheTableOrderingComposer,
          $$MerchantCategoryCodesCacheTableAnnotationComposer,
          $$MerchantCategoryCodesCacheTableCreateCompanionBuilder,
          $$MerchantCategoryCodesCacheTableUpdateCompanionBuilder,
          (
            MerchantCategoryCodeCacheRow,
            BaseReferences<
              _$AppDatabase,
              $MerchantCategoryCodesCacheTable,
              MerchantCategoryCodeCacheRow
            >,
          ),
          MerchantCategoryCodeCacheRow,
          PrefetchHooks Function()
        > {
  $$MerchantCategoryCodesCacheTableTableManager(
    _$AppDatabase db,
    $MerchantCategoryCodesCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MerchantCategoryCodesCacheTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MerchantCategoryCodesCacheTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MerchantCategoryCodesCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> validPayment = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantCategoryCodesCacheCompanion(
                code: code,
                description: description,
                category: category,
                validPayment: validPayment,
                isActive: isActive,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String description,
                Value<String?> category = const Value.absent(),
                Value<String?> validPayment = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                required int datasetVersion,
                Value<int> rowid = const Value.absent(),
              }) => MerchantCategoryCodesCacheCompanion.insert(
                code: code,
                description: description,
                category: category,
                validPayment: validPayment,
                isActive: isActive,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MerchantCategoryCodesCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MerchantCategoryCodesCacheTable,
      MerchantCategoryCodeCacheRow,
      $$MerchantCategoryCodesCacheTableFilterComposer,
      $$MerchantCategoryCodesCacheTableOrderingComposer,
      $$MerchantCategoryCodesCacheTableAnnotationComposer,
      $$MerchantCategoryCodesCacheTableCreateCompanionBuilder,
      $$MerchantCategoryCodesCacheTableUpdateCompanionBuilder,
      (
        MerchantCategoryCodeCacheRow,
        BaseReferences<
          _$AppDatabase,
          $MerchantCategoryCodesCacheTable,
          MerchantCategoryCodeCacheRow
        >,
      ),
      MerchantCategoryCodeCacheRow,
      PrefetchHooks Function()
    >;
typedef $$RewardRulesCacheTableCreateCompanionBuilder =
    RewardRulesCacheCompanion Function({
      required String id,
      required String creditCardId,
      required String name,
      required String rewardType,
      Value<String?> cashbackRateDecimal,
      Value<String?> pointsRateDecimal,
      Value<String?> monthlyCapAmountDecimal,
      Value<String?> minimumTransactionDecimal,
      Value<String?> minimumMonthlySpendDecimal,
      Value<String> eligibleChannel,
      Value<String?> conditionsText,
      Value<String?> effectiveFrom,
      Value<String?> effectiveTo,
      Value<String?> sourceUrl,
      Value<int?> confidencePpm,
      Value<int?> lastVerifiedAtMs,
      Value<bool> isActive,
      Value<int?> serverUpdatedAtMs,
      required int datasetVersion,
      Value<int> rowid,
    });
typedef $$RewardRulesCacheTableUpdateCompanionBuilder =
    RewardRulesCacheCompanion Function({
      Value<String> id,
      Value<String> creditCardId,
      Value<String> name,
      Value<String> rewardType,
      Value<String?> cashbackRateDecimal,
      Value<String?> pointsRateDecimal,
      Value<String?> monthlyCapAmountDecimal,
      Value<String?> minimumTransactionDecimal,
      Value<String?> minimumMonthlySpendDecimal,
      Value<String> eligibleChannel,
      Value<String?> conditionsText,
      Value<String?> effectiveFrom,
      Value<String?> effectiveTo,
      Value<String?> sourceUrl,
      Value<int?> confidencePpm,
      Value<int?> lastVerifiedAtMs,
      Value<bool> isActive,
      Value<int?> serverUpdatedAtMs,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$RewardRulesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $RewardRulesCacheTable> {
  $$RewardRulesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditCardId => $composableBuilder(
    column: $table.creditCardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rewardType => $composableBuilder(
    column: $table.rewardType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cashbackRateDecimal => $composableBuilder(
    column: $table.cashbackRateDecimal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pointsRateDecimal => $composableBuilder(
    column: $table.pointsRateDecimal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get monthlyCapAmountDecimal => $composableBuilder(
    column: $table.monthlyCapAmountDecimal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get minimumTransactionDecimal => $composableBuilder(
    column: $table.minimumTransactionDecimal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get minimumMonthlySpendDecimal => $composableBuilder(
    column: $table.minimumMonthlySpendDecimal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eligibleChannel => $composableBuilder(
    column: $table.eligibleChannel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionsText => $composableBuilder(
    column: $table.conditionsText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveTo => $composableBuilder(
    column: $table.effectiveTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastVerifiedAtMs => $composableBuilder(
    column: $table.lastVerifiedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RewardRulesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardRulesCacheTable> {
  $$RewardRulesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditCardId => $composableBuilder(
    column: $table.creditCardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rewardType => $composableBuilder(
    column: $table.rewardType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cashbackRateDecimal => $composableBuilder(
    column: $table.cashbackRateDecimal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pointsRateDecimal => $composableBuilder(
    column: $table.pointsRateDecimal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get monthlyCapAmountDecimal => $composableBuilder(
    column: $table.monthlyCapAmountDecimal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get minimumTransactionDecimal => $composableBuilder(
    column: $table.minimumTransactionDecimal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get minimumMonthlySpendDecimal => $composableBuilder(
    column: $table.minimumMonthlySpendDecimal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eligibleChannel => $composableBuilder(
    column: $table.eligibleChannel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionsText => $composableBuilder(
    column: $table.conditionsText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveTo => $composableBuilder(
    column: $table.effectiveTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastVerifiedAtMs => $composableBuilder(
    column: $table.lastVerifiedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RewardRulesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardRulesCacheTable> {
  $$RewardRulesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get creditCardId => $composableBuilder(
    column: $table.creditCardId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get rewardType => $composableBuilder(
    column: $table.rewardType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cashbackRateDecimal => $composableBuilder(
    column: $table.cashbackRateDecimal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pointsRateDecimal => $composableBuilder(
    column: $table.pointsRateDecimal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get monthlyCapAmountDecimal => $composableBuilder(
    column: $table.monthlyCapAmountDecimal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get minimumTransactionDecimal => $composableBuilder(
    column: $table.minimumTransactionDecimal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get minimumMonthlySpendDecimal => $composableBuilder(
    column: $table.minimumMonthlySpendDecimal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eligibleChannel => $composableBuilder(
    column: $table.eligibleChannel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conditionsText => $composableBuilder(
    column: $table.conditionsText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get effectiveTo => $composableBuilder(
    column: $table.effectiveTo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastVerifiedAtMs => $composableBuilder(
    column: $table.lastVerifiedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get serverUpdatedAtMs => $composableBuilder(
    column: $table.serverUpdatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$RewardRulesCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardRulesCacheTable,
          RewardRuleCacheRow,
          $$RewardRulesCacheTableFilterComposer,
          $$RewardRulesCacheTableOrderingComposer,
          $$RewardRulesCacheTableAnnotationComposer,
          $$RewardRulesCacheTableCreateCompanionBuilder,
          $$RewardRulesCacheTableUpdateCompanionBuilder,
          (
            RewardRuleCacheRow,
            BaseReferences<
              _$AppDatabase,
              $RewardRulesCacheTable,
              RewardRuleCacheRow
            >,
          ),
          RewardRuleCacheRow,
          PrefetchHooks Function()
        > {
  $$RewardRulesCacheTableTableManager(
    _$AppDatabase db,
    $RewardRulesCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardRulesCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardRulesCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardRulesCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> creditCardId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> rewardType = const Value.absent(),
                Value<String?> cashbackRateDecimal = const Value.absent(),
                Value<String?> pointsRateDecimal = const Value.absent(),
                Value<String?> monthlyCapAmountDecimal = const Value.absent(),
                Value<String?> minimumTransactionDecimal = const Value.absent(),
                Value<String?> minimumMonthlySpendDecimal =
                    const Value.absent(),
                Value<String> eligibleChannel = const Value.absent(),
                Value<String?> conditionsText = const Value.absent(),
                Value<String?> effectiveFrom = const Value.absent(),
                Value<String?> effectiveTo = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<int?> confidencePpm = const Value.absent(),
                Value<int?> lastVerifiedAtMs = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardRulesCacheCompanion(
                id: id,
                creditCardId: creditCardId,
                name: name,
                rewardType: rewardType,
                cashbackRateDecimal: cashbackRateDecimal,
                pointsRateDecimal: pointsRateDecimal,
                monthlyCapAmountDecimal: monthlyCapAmountDecimal,
                minimumTransactionDecimal: minimumTransactionDecimal,
                minimumMonthlySpendDecimal: minimumMonthlySpendDecimal,
                eligibleChannel: eligibleChannel,
                conditionsText: conditionsText,
                effectiveFrom: effectiveFrom,
                effectiveTo: effectiveTo,
                sourceUrl: sourceUrl,
                confidencePpm: confidencePpm,
                lastVerifiedAtMs: lastVerifiedAtMs,
                isActive: isActive,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String creditCardId,
                required String name,
                required String rewardType,
                Value<String?> cashbackRateDecimal = const Value.absent(),
                Value<String?> pointsRateDecimal = const Value.absent(),
                Value<String?> monthlyCapAmountDecimal = const Value.absent(),
                Value<String?> minimumTransactionDecimal = const Value.absent(),
                Value<String?> minimumMonthlySpendDecimal =
                    const Value.absent(),
                Value<String> eligibleChannel = const Value.absent(),
                Value<String?> conditionsText = const Value.absent(),
                Value<String?> effectiveFrom = const Value.absent(),
                Value<String?> effectiveTo = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<int?> confidencePpm = const Value.absent(),
                Value<int?> lastVerifiedAtMs = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> serverUpdatedAtMs = const Value.absent(),
                required int datasetVersion,
                Value<int> rowid = const Value.absent(),
              }) => RewardRulesCacheCompanion.insert(
                id: id,
                creditCardId: creditCardId,
                name: name,
                rewardType: rewardType,
                cashbackRateDecimal: cashbackRateDecimal,
                pointsRateDecimal: pointsRateDecimal,
                monthlyCapAmountDecimal: monthlyCapAmountDecimal,
                minimumTransactionDecimal: minimumTransactionDecimal,
                minimumMonthlySpendDecimal: minimumMonthlySpendDecimal,
                eligibleChannel: eligibleChannel,
                conditionsText: conditionsText,
                effectiveFrom: effectiveFrom,
                effectiveTo: effectiveTo,
                sourceUrl: sourceUrl,
                confidencePpm: confidencePpm,
                lastVerifiedAtMs: lastVerifiedAtMs,
                isActive: isActive,
                serverUpdatedAtMs: serverUpdatedAtMs,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RewardRulesCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardRulesCacheTable,
      RewardRuleCacheRow,
      $$RewardRulesCacheTableFilterComposer,
      $$RewardRulesCacheTableOrderingComposer,
      $$RewardRulesCacheTableAnnotationComposer,
      $$RewardRulesCacheTableCreateCompanionBuilder,
      $$RewardRulesCacheTableUpdateCompanionBuilder,
      (
        RewardRuleCacheRow,
        BaseReferences<
          _$AppDatabase,
          $RewardRulesCacheTable,
          RewardRuleCacheRow
        >,
      ),
      RewardRuleCacheRow,
      PrefetchHooks Function()
    >;
typedef $$RewardRuleMccsCacheTableCreateCompanionBuilder =
    RewardRuleMccsCacheCompanion Function({
      required String id,
      required String rewardRuleId,
      required String mccCode,
      required String matchType,
      required int datasetVersion,
      Value<int> rowid,
    });
typedef $$RewardRuleMccsCacheTableUpdateCompanionBuilder =
    RewardRuleMccsCacheCompanion Function({
      Value<String> id,
      Value<String> rewardRuleId,
      Value<String> mccCode,
      Value<String> matchType,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$RewardRuleMccsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $RewardRuleMccsCacheTable> {
  $$RewardRuleMccsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rewardRuleId => $composableBuilder(
    column: $table.rewardRuleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchType => $composableBuilder(
    column: $table.matchType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RewardRuleMccsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardRuleMccsCacheTable> {
  $$RewardRuleMccsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rewardRuleId => $composableBuilder(
    column: $table.rewardRuleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchType => $composableBuilder(
    column: $table.matchType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RewardRuleMccsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardRuleMccsCacheTable> {
  $$RewardRuleMccsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rewardRuleId => $composableBuilder(
    column: $table.rewardRuleId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mccCode =>
      $composableBuilder(column: $table.mccCode, builder: (column) => column);

  GeneratedColumn<String> get matchType =>
      $composableBuilder(column: $table.matchType, builder: (column) => column);

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$RewardRuleMccsCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardRuleMccsCacheTable,
          RewardRuleMccCacheRow,
          $$RewardRuleMccsCacheTableFilterComposer,
          $$RewardRuleMccsCacheTableOrderingComposer,
          $$RewardRuleMccsCacheTableAnnotationComposer,
          $$RewardRuleMccsCacheTableCreateCompanionBuilder,
          $$RewardRuleMccsCacheTableUpdateCompanionBuilder,
          (
            RewardRuleMccCacheRow,
            BaseReferences<
              _$AppDatabase,
              $RewardRuleMccsCacheTable,
              RewardRuleMccCacheRow
            >,
          ),
          RewardRuleMccCacheRow,
          PrefetchHooks Function()
        > {
  $$RewardRuleMccsCacheTableTableManager(
    _$AppDatabase db,
    $RewardRuleMccsCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardRuleMccsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardRuleMccsCacheTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RewardRuleMccsCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> rewardRuleId = const Value.absent(),
                Value<String> mccCode = const Value.absent(),
                Value<String> matchType = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardRuleMccsCacheCompanion(
                id: id,
                rewardRuleId: rewardRuleId,
                mccCode: mccCode,
                matchType: matchType,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String rewardRuleId,
                required String mccCode,
                required String matchType,
                required int datasetVersion,
                Value<int> rowid = const Value.absent(),
              }) => RewardRuleMccsCacheCompanion.insert(
                id: id,
                rewardRuleId: rewardRuleId,
                mccCode: mccCode,
                matchType: matchType,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RewardRuleMccsCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardRuleMccsCacheTable,
      RewardRuleMccCacheRow,
      $$RewardRuleMccsCacheTableFilterComposer,
      $$RewardRuleMccsCacheTableOrderingComposer,
      $$RewardRuleMccsCacheTableAnnotationComposer,
      $$RewardRuleMccsCacheTableCreateCompanionBuilder,
      $$RewardRuleMccsCacheTableUpdateCompanionBuilder,
      (
        RewardRuleMccCacheRow,
        BaseReferences<
          _$AppDatabase,
          $RewardRuleMccsCacheTable,
          RewardRuleMccCacheRow
        >,
      ),
      RewardRuleMccCacheRow,
      PrefetchHooks Function()
    >;
typedef $$MerchantMccCandidatesCacheTableCreateCompanionBuilder =
    MerchantMccCandidatesCacheCompanion Function({
      required String id,
      required String merchantServerId,
      required String merchantName,
      required String merchantNameNormalized,
      Value<String?> locationText,
      required String mccCode,
      Value<String?> mccDescription,
      Value<String> paymentType,
      required String source,
      Value<int?> confidencePpm,
      required String status,
      Value<int> datasetVersion,
      Value<int> rowid,
    });
typedef $$MerchantMccCandidatesCacheTableUpdateCompanionBuilder =
    MerchantMccCandidatesCacheCompanion Function({
      Value<String> id,
      Value<String> merchantServerId,
      Value<String> merchantName,
      Value<String> merchantNameNormalized,
      Value<String?> locationText,
      Value<String> mccCode,
      Value<String?> mccDescription,
      Value<String> paymentType,
      Value<String> source,
      Value<int?> confidencePpm,
      Value<String> status,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$MerchantMccCandidatesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $MerchantMccCandidatesCacheTable> {
  $$MerchantMccCandidatesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantServerId => $composableBuilder(
    column: $table.merchantServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantNameNormalized => $composableBuilder(
    column: $table.merchantNameNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mccDescription => $composableBuilder(
    column: $table.mccDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MerchantMccCandidatesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $MerchantMccCandidatesCacheTable> {
  $$MerchantMccCandidatesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantServerId => $composableBuilder(
    column: $table.merchantServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantNameNormalized => $composableBuilder(
    column: $table.merchantNameNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mccDescription => $composableBuilder(
    column: $table.mccDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MerchantMccCandidatesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $MerchantMccCandidatesCacheTable> {
  $$MerchantMccCandidatesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get merchantServerId => $composableBuilder(
    column: $table.merchantServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantNameNormalized => $composableBuilder(
    column: $table.merchantNameNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mccCode =>
      $composableBuilder(column: $table.mccCode, builder: (column) => column);

  GeneratedColumn<String> get mccDescription => $composableBuilder(
    column: $table.mccDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$MerchantMccCandidatesCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MerchantMccCandidatesCacheTable,
          MerchantMccCandidateCacheRow,
          $$MerchantMccCandidatesCacheTableFilterComposer,
          $$MerchantMccCandidatesCacheTableOrderingComposer,
          $$MerchantMccCandidatesCacheTableAnnotationComposer,
          $$MerchantMccCandidatesCacheTableCreateCompanionBuilder,
          $$MerchantMccCandidatesCacheTableUpdateCompanionBuilder,
          (
            MerchantMccCandidateCacheRow,
            BaseReferences<
              _$AppDatabase,
              $MerchantMccCandidatesCacheTable,
              MerchantMccCandidateCacheRow
            >,
          ),
          MerchantMccCandidateCacheRow,
          PrefetchHooks Function()
        > {
  $$MerchantMccCandidatesCacheTableTableManager(
    _$AppDatabase db,
    $MerchantMccCandidatesCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MerchantMccCandidatesCacheTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MerchantMccCandidatesCacheTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MerchantMccCandidatesCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> merchantServerId = const Value.absent(),
                Value<String> merchantName = const Value.absent(),
                Value<String> merchantNameNormalized = const Value.absent(),
                Value<String?> locationText = const Value.absent(),
                Value<String> mccCode = const Value.absent(),
                Value<String?> mccDescription = const Value.absent(),
                Value<String> paymentType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int?> confidencePpm = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantMccCandidatesCacheCompanion(
                id: id,
                merchantServerId: merchantServerId,
                merchantName: merchantName,
                merchantNameNormalized: merchantNameNormalized,
                locationText: locationText,
                mccCode: mccCode,
                mccDescription: mccDescription,
                paymentType: paymentType,
                source: source,
                confidencePpm: confidencePpm,
                status: status,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String merchantServerId,
                required String merchantName,
                required String merchantNameNormalized,
                Value<String?> locationText = const Value.absent(),
                required String mccCode,
                Value<String?> mccDescription = const Value.absent(),
                Value<String> paymentType = const Value.absent(),
                required String source,
                Value<int?> confidencePpm = const Value.absent(),
                required String status,
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantMccCandidatesCacheCompanion.insert(
                id: id,
                merchantServerId: merchantServerId,
                merchantName: merchantName,
                merchantNameNormalized: merchantNameNormalized,
                locationText: locationText,
                mccCode: mccCode,
                mccDescription: mccDescription,
                paymentType: paymentType,
                source: source,
                confidencePpm: confidencePpm,
                status: status,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MerchantMccCandidatesCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MerchantMccCandidatesCacheTable,
      MerchantMccCandidateCacheRow,
      $$MerchantMccCandidatesCacheTableFilterComposer,
      $$MerchantMccCandidatesCacheTableOrderingComposer,
      $$MerchantMccCandidatesCacheTableAnnotationComposer,
      $$MerchantMccCandidatesCacheTableCreateCompanionBuilder,
      $$MerchantMccCandidatesCacheTableUpdateCompanionBuilder,
      (
        MerchantMccCandidateCacheRow,
        BaseReferences<
          _$AppDatabase,
          $MerchantMccCandidatesCacheTable,
          MerchantMccCandidateCacheRow
        >,
      ),
      MerchantMccCandidateCacheRow,
      PrefetchHooks Function()
    >;
typedef $$MerchantBranchesCacheTableCreateCompanionBuilder =
    MerchantBranchesCacheCompanion Function({
      required String id,
      required String name,
      required String nameNormalized,
      Value<String?> locationText,
      Value<int> datasetVersion,
      Value<int> rowid,
    });
typedef $$MerchantBranchesCacheTableUpdateCompanionBuilder =
    MerchantBranchesCacheCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> nameNormalized,
      Value<String?> locationText,
      Value<int> datasetVersion,
      Value<int> rowid,
    });

class $$MerchantBranchesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $MerchantBranchesCacheTable> {
  $$MerchantBranchesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MerchantBranchesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $MerchantBranchesCacheTable> {
  $$MerchantBranchesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MerchantBranchesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $MerchantBranchesCacheTable> {
  $$MerchantBranchesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );
}

class $$MerchantBranchesCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MerchantBranchesCacheTable,
          MerchantBranchCacheRow,
          $$MerchantBranchesCacheTableFilterComposer,
          $$MerchantBranchesCacheTableOrderingComposer,
          $$MerchantBranchesCacheTableAnnotationComposer,
          $$MerchantBranchesCacheTableCreateCompanionBuilder,
          $$MerchantBranchesCacheTableUpdateCompanionBuilder,
          (
            MerchantBranchCacheRow,
            BaseReferences<
              _$AppDatabase,
              $MerchantBranchesCacheTable,
              MerchantBranchCacheRow
            >,
          ),
          MerchantBranchCacheRow,
          PrefetchHooks Function()
        > {
  $$MerchantBranchesCacheTableTableManager(
    _$AppDatabase db,
    $MerchantBranchesCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MerchantBranchesCacheTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MerchantBranchesCacheTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MerchantBranchesCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameNormalized = const Value.absent(),
                Value<String?> locationText = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantBranchesCacheCompanion(
                id: id,
                name: name,
                nameNormalized: nameNormalized,
                locationText: locationText,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String nameNormalized,
                Value<String?> locationText = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantBranchesCacheCompanion.insert(
                id: id,
                name: name,
                nameNormalized: nameNormalized,
                locationText: locationText,
                datasetVersion: datasetVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MerchantBranchesCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MerchantBranchesCacheTable,
      MerchantBranchCacheRow,
      $$MerchantBranchesCacheTableFilterComposer,
      $$MerchantBranchesCacheTableOrderingComposer,
      $$MerchantBranchesCacheTableAnnotationComposer,
      $$MerchantBranchesCacheTableCreateCompanionBuilder,
      $$MerchantBranchesCacheTableUpdateCompanionBuilder,
      (
        MerchantBranchCacheRow,
        BaseReferences<
          _$AppDatabase,
          $MerchantBranchesCacheTable,
          MerchantBranchCacheRow
        >,
      ),
      MerchantBranchCacheRow,
      PrefetchHooks Function()
    >;
typedef $$LocalUserCardsTableCreateCompanionBuilder =
    LocalUserCardsCompanion Function({
      required String id,
      required String profileId,
      Value<String?> creditCardId,
      Value<String?> bankId,
      required String bankNameSnapshot,
      required String nickname,
      required int billingCycleDay,
      Value<int> creditLimitMinor,
      Value<bool> isDefault,
      Value<bool> hasAnnualFee,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });
typedef $$LocalUserCardsTableUpdateCompanionBuilder =
    LocalUserCardsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String?> creditCardId,
      Value<String?> bankId,
      Value<String> bankNameSnapshot,
      Value<String> nickname,
      Value<int> billingCycleDay,
      Value<int> creditLimitMinor,
      Value<bool> isDefault,
      Value<bool> hasAnnualFee,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });

final class $$LocalUserCardsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalUserCardsTable, LocalUserCardRow> {
  $$LocalUserCardsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProfilesTable _profileIdTable(_$AppDatabase db) => db
      .localProfiles
      .createAlias('local_user_cards__profile_id__local_profiles__id');

  $$LocalProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalTransactionsTable, List<LocalTransactionRow>>
  _localTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localTransactions,
        aliasName: 'local_user_cards__id__local_transactions__user_card_id',
      );

  $$LocalTransactionsTableProcessedTableManager get localTransactionsRefs {
    final manager = $$LocalTransactionsTableTableManager(
      $_db,
      $_db.localTransactions,
    ).filter((f) => f.userCardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalCashbackCalculationsTable,
    List<LocalCashbackCalculationRow>
  >
  _localCashbackCalculationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCashbackCalculations,
        aliasName:
            'local_user_cards__id__local_cashback_calculations__user_card_id',
      );

  $$LocalCashbackCalculationsTableProcessedTableManager
  get localCashbackCalculationsRefs {
    final manager = $$LocalCashbackCalculationsTableTableManager(
      $_db,
      $_db.localCashbackCalculations,
    ).filter((f) => f.userCardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCashbackCalculationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalUserCardsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUserCardsTable> {
  $$LocalUserCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditCardId => $composableBuilder(
    column: $table.creditCardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankId => $composableBuilder(
    column: $table.bankId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankNameSnapshot => $composableBuilder(
    column: $table.bankNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billingCycleDay => $composableBuilder(
    column: $table.billingCycleDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get creditLimitMinor => $composableBuilder(
    column: $table.creditLimitMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasAnnualFee => $composableBuilder(
    column: $table.hasAnnualFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get profileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localTransactionsRefs(
    Expression<bool> Function($$LocalTransactionsTableFilterComposer f) f,
  ) {
    final $$LocalTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localTransactions,
      getReferencedColumn: (t) => t.userCardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.localTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localCashbackCalculationsRefs(
    Expression<bool> Function($$LocalCashbackCalculationsTableFilterComposer f)
    f,
  ) {
    final $$LocalCashbackCalculationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashbackCalculations,
          getReferencedColumn: (t) => t.userCardId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashbackCalculationsTableFilterComposer(
                $db: $db,
                $table: $db.localCashbackCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalUserCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUserCardsTable> {
  $$LocalUserCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditCardId => $composableBuilder(
    column: $table.creditCardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankId => $composableBuilder(
    column: $table.bankId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankNameSnapshot => $composableBuilder(
    column: $table.bankNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billingCycleDay => $composableBuilder(
    column: $table.billingCycleDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get creditLimitMinor => $composableBuilder(
    column: $table.creditLimitMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasAnnualFee => $composableBuilder(
    column: $table.hasAnnualFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get profileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalUserCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUserCardsTable> {
  $$LocalUserCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get creditCardId => $composableBuilder(
    column: $table.creditCardId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankId =>
      $composableBuilder(column: $table.bankId, builder: (column) => column);

  GeneratedColumn<String> get bankNameSnapshot => $composableBuilder(
    column: $table.bankNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<int> get billingCycleDay => $composableBuilder(
    column: $table.billingCycleDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get creditLimitMinor => $composableBuilder(
    column: $table.creditLimitMinor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get hasAnnualFee => $composableBuilder(
    column: $table.hasAnnualFee,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get profileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localTransactionsRefs<T extends Object>(
    Expression<T> Function($$LocalTransactionsTableAnnotationComposer a) f,
  ) {
    final $$LocalTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localTransactions,
          getReferencedColumn: (t) => t.userCardId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localCashbackCalculationsRefs<T extends Object>(
    Expression<T> Function($$LocalCashbackCalculationsTableAnnotationComposer a)
    f,
  ) {
    final $$LocalCashbackCalculationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashbackCalculations,
          getReferencedColumn: (t) => t.userCardId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashbackCalculationsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashbackCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalUserCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalUserCardsTable,
          LocalUserCardRow,
          $$LocalUserCardsTableFilterComposer,
          $$LocalUserCardsTableOrderingComposer,
          $$LocalUserCardsTableAnnotationComposer,
          $$LocalUserCardsTableCreateCompanionBuilder,
          $$LocalUserCardsTableUpdateCompanionBuilder,
          (LocalUserCardRow, $$LocalUserCardsTableReferences),
          LocalUserCardRow,
          PrefetchHooks Function({
            bool profileId,
            bool localTransactionsRefs,
            bool localCashbackCalculationsRefs,
          })
        > {
  $$LocalUserCardsTableTableManager(
    _$AppDatabase db,
    $LocalUserCardsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUserCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUserCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUserCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String?> creditCardId = const Value.absent(),
                Value<String?> bankId = const Value.absent(),
                Value<String> bankNameSnapshot = const Value.absent(),
                Value<String> nickname = const Value.absent(),
                Value<int> billingCycleDay = const Value.absent(),
                Value<int> creditLimitMinor = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> hasAnnualFee = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUserCardsCompanion(
                id: id,
                profileId: profileId,
                creditCardId: creditCardId,
                bankId: bankId,
                bankNameSnapshot: bankNameSnapshot,
                nickname: nickname,
                billingCycleDay: billingCycleDay,
                creditLimitMinor: creditLimitMinor,
                isDefault: isDefault,
                hasAnnualFee: hasAnnualFee,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                Value<String?> creditCardId = const Value.absent(),
                Value<String?> bankId = const Value.absent(),
                required String bankNameSnapshot,
                required String nickname,
                required int billingCycleDay,
                Value<int> creditLimitMinor = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> hasAnnualFee = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUserCardsCompanion.insert(
                id: id,
                profileId: profileId,
                creditCardId: creditCardId,
                bankId: bankId,
                bankNameSnapshot: bankNameSnapshot,
                nickname: nickname,
                billingCycleDay: billingCycleDay,
                creditLimitMinor: creditLimitMinor,
                isDefault: isDefault,
                hasAnnualFee: hasAnnualFee,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalUserCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                localTransactionsRefs = false,
                localCashbackCalculationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localTransactionsRefs) db.localTransactions,
                    if (localCashbackCalculationsRefs)
                      db.localCashbackCalculations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $$LocalUserCardsTableReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $$LocalUserCardsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localTransactionsRefs)
                        await $_getPrefetchedData<
                          LocalUserCardRow,
                          $LocalUserCardsTable,
                          LocalTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalUserCardsTableReferences
                              ._localTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalUserCardsTableReferences(
                                db,
                                table,
                                p0,
                              ).localTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userCardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCashbackCalculationsRefs)
                        await $_getPrefetchedData<
                          LocalUserCardRow,
                          $LocalUserCardsTable,
                          LocalCashbackCalculationRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalUserCardsTableReferences
                              ._localCashbackCalculationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalUserCardsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCashbackCalculationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userCardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalUserCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalUserCardsTable,
      LocalUserCardRow,
      $$LocalUserCardsTableFilterComposer,
      $$LocalUserCardsTableOrderingComposer,
      $$LocalUserCardsTableAnnotationComposer,
      $$LocalUserCardsTableCreateCompanionBuilder,
      $$LocalUserCardsTableUpdateCompanionBuilder,
      (LocalUserCardRow, $$LocalUserCardsTableReferences),
      LocalUserCardRow,
      PrefetchHooks Function({
        bool profileId,
        bool localTransactionsRefs,
        bool localCashbackCalculationsRefs,
      })
    >;
typedef $$LocalMerchantMccContributionsTableCreateCompanionBuilder =
    LocalMerchantMccContributionsCompanion Function({
      required String id,
      required String profileId,
      required String merchantServerId,
      required String merchantNameSnapshot,
      Value<String?> locationText,
      required String mccCode,
      Value<String?> mccDescriptionSnapshot,
      required String paymentType,
      Value<String?> note,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$LocalMerchantMccContributionsTableUpdateCompanionBuilder =
    LocalMerchantMccContributionsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> merchantServerId,
      Value<String> merchantNameSnapshot,
      Value<String?> locationText,
      Value<String> mccCode,
      Value<String?> mccDescriptionSnapshot,
      Value<String> paymentType,
      Value<String?> note,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

final class $$LocalMerchantMccContributionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalMerchantMccContributionsTable,
          LocalMerchantMccContributionRow
        > {
  $$LocalMerchantMccContributionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.localProfiles.createAlias(
        'local_merchant_mcc_contributions__profile_id__local_profiles__id',
      );

  $$LocalProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalMerchantMccContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalMerchantMccContributionsTable> {
  $$LocalMerchantMccContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantServerId => $composableBuilder(
    column: $table.merchantServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantNameSnapshot => $composableBuilder(
    column: $table.merchantNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mccDescriptionSnapshot => $composableBuilder(
    column: $table.mccDescriptionSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get profileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalMerchantMccContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalMerchantMccContributionsTable> {
  $$LocalMerchantMccContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantServerId => $composableBuilder(
    column: $table.merchantServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantNameSnapshot => $composableBuilder(
    column: $table.merchantNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mccDescriptionSnapshot => $composableBuilder(
    column: $table.mccDescriptionSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get profileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalMerchantMccContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalMerchantMccContributionsTable> {
  $$LocalMerchantMccContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get merchantServerId => $composableBuilder(
    column: $table.merchantServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantNameSnapshot => $composableBuilder(
    column: $table.merchantNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mccCode =>
      $composableBuilder(column: $table.mccCode, builder: (column) => column);

  GeneratedColumn<String> get mccDescriptionSnapshot => $composableBuilder(
    column: $table.mccDescriptionSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentType => $composableBuilder(
    column: $table.paymentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get profileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalMerchantMccContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalMerchantMccContributionsTable,
          LocalMerchantMccContributionRow,
          $$LocalMerchantMccContributionsTableFilterComposer,
          $$LocalMerchantMccContributionsTableOrderingComposer,
          $$LocalMerchantMccContributionsTableAnnotationComposer,
          $$LocalMerchantMccContributionsTableCreateCompanionBuilder,
          $$LocalMerchantMccContributionsTableUpdateCompanionBuilder,
          (
            LocalMerchantMccContributionRow,
            $$LocalMerchantMccContributionsTableReferences,
          ),
          LocalMerchantMccContributionRow,
          PrefetchHooks Function({bool profileId})
        > {
  $$LocalMerchantMccContributionsTableTableManager(
    _$AppDatabase db,
    $LocalMerchantMccContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMerchantMccContributionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalMerchantMccContributionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalMerchantMccContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> merchantServerId = const Value.absent(),
                Value<String> merchantNameSnapshot = const Value.absent(),
                Value<String?> locationText = const Value.absent(),
                Value<String> mccCode = const Value.absent(),
                Value<String?> mccDescriptionSnapshot = const Value.absent(),
                Value<String> paymentType = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalMerchantMccContributionsCompanion(
                id: id,
                profileId: profileId,
                merchantServerId: merchantServerId,
                merchantNameSnapshot: merchantNameSnapshot,
                locationText: locationText,
                mccCode: mccCode,
                mccDescriptionSnapshot: mccDescriptionSnapshot,
                paymentType: paymentType,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String merchantServerId,
                required String merchantNameSnapshot,
                Value<String?> locationText = const Value.absent(),
                required String mccCode,
                Value<String?> mccDescriptionSnapshot = const Value.absent(),
                required String paymentType,
                Value<String?> note = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => LocalMerchantMccContributionsCompanion.insert(
                id: id,
                profileId: profileId,
                merchantServerId: merchantServerId,
                merchantNameSnapshot: merchantNameSnapshot,
                locationText: locationText,
                mccCode: mccCode,
                mccDescriptionSnapshot: mccDescriptionSnapshot,
                paymentType: paymentType,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalMerchantMccContributionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable:
                                    $$LocalMerchantMccContributionsTableReferences
                                        ._profileIdTable(db),
                                referencedColumn:
                                    $$LocalMerchantMccContributionsTableReferences
                                        ._profileIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalMerchantMccContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalMerchantMccContributionsTable,
      LocalMerchantMccContributionRow,
      $$LocalMerchantMccContributionsTableFilterComposer,
      $$LocalMerchantMccContributionsTableOrderingComposer,
      $$LocalMerchantMccContributionsTableAnnotationComposer,
      $$LocalMerchantMccContributionsTableCreateCompanionBuilder,
      $$LocalMerchantMccContributionsTableUpdateCompanionBuilder,
      (
        LocalMerchantMccContributionRow,
        $$LocalMerchantMccContributionsTableReferences,
      ),
      LocalMerchantMccContributionRow,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder =
    SyncOutboxCompanion Function({
      required String id,
      required String profileId,
      required String entityType,
      required String entityId,
      required String operation,
      required String payloadJson,
      Value<int> payloadVersion,
      Value<int?> baseServerVersion,
      required String idempotencyKey,
      Value<int> attemptCount,
      required int nextAttemptAtMs,
      Value<String?> lastErrorCode,
      required int createdAtMs,
      Value<int> rowid,
    });
typedef $$SyncOutboxTableUpdateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String> payloadJson,
      Value<int> payloadVersion,
      Value<int?> baseServerVersion,
      Value<String> idempotencyKey,
      Value<int> attemptCount,
      Value<int> nextAttemptAtMs,
      Value<String?> lastErrorCode,
      Value<int> createdAtMs,
      Value<int> rowid,
    });

final class $$SyncOutboxTableReferences
    extends BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxRow> {
  $$SyncOutboxTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalProfilesTable _profileIdTable(_$AppDatabase db) => db
      .localProfiles
      .createAlias('sync_outbox__profile_id__local_profiles__id');

  $$LocalProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseServerVersion => $composableBuilder(
    column: $table.baseServerVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextAttemptAtMs => $composableBuilder(
    column: $table.nextAttemptAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get profileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseServerVersion => $composableBuilder(
    column: $table.baseServerVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextAttemptAtMs => $composableBuilder(
    column: $table.nextAttemptAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get profileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baseServerVersion => $composableBuilder(
    column: $table.baseServerVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextAttemptAtMs => $composableBuilder(
    column: $table.nextAttemptAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get profileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxTable,
          SyncOutboxRow,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (SyncOutboxRow, $$SyncOutboxTableReferences),
          SyncOutboxRow,
          PrefetchHooks Function({bool profileId})
        > {
  $$SyncOutboxTableTableManager(_$AppDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> payloadVersion = const Value.absent(),
                Value<int?> baseServerVersion = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<int> nextAttemptAtMs = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion(
                id: id,
                profileId: profileId,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                payloadVersion: payloadVersion,
                baseServerVersion: baseServerVersion,
                idempotencyKey: idempotencyKey,
                attemptCount: attemptCount,
                nextAttemptAtMs: nextAttemptAtMs,
                lastErrorCode: lastErrorCode,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String entityType,
                required String entityId,
                required String operation,
                required String payloadJson,
                Value<int> payloadVersion = const Value.absent(),
                Value<int?> baseServerVersion = const Value.absent(),
                required String idempotencyKey,
                Value<int> attemptCount = const Value.absent(),
                required int nextAttemptAtMs,
                Value<String?> lastErrorCode = const Value.absent(),
                required int createdAtMs,
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                id: id,
                profileId: profileId,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                payloadVersion: payloadVersion,
                baseServerVersion: baseServerVersion,
                idempotencyKey: idempotencyKey,
                attemptCount: attemptCount,
                nextAttemptAtMs: nextAttemptAtMs,
                lastErrorCode: lastErrorCode,
                createdAtMs: createdAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncOutboxTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$SyncOutboxTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$SyncOutboxTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxTable,
      SyncOutboxRow,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (SyncOutboxRow, $$SyncOutboxTableReferences),
      SyncOutboxRow,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$SyncStateTableCreateCompanionBuilder =
    SyncStateCompanion Function({
      required String scope,
      Value<String?> cursor,
      Value<int?> datasetVersion,
      Value<String?> etag,
      Value<int?> lastAttemptAtMs,
      Value<int?> lastSuccessAtMs,
      Value<int?> nextCheckAtMs,
      Value<String?> lastErrorCode,
      Value<int> rowid,
    });
typedef $$SyncStateTableUpdateCompanionBuilder =
    SyncStateCompanion Function({
      Value<String> scope,
      Value<String?> cursor,
      Value<int?> datasetVersion,
      Value<String?> etag,
      Value<int?> lastAttemptAtMs,
      Value<int?> lastSuccessAtMs,
      Value<int?> nextCheckAtMs,
      Value<String?> lastErrorCode,
      Value<int> rowid,
    });

class $$SyncStateTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cursor => $composableBuilder(
    column: $table.cursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastAttemptAtMs => $composableBuilder(
    column: $table.lastAttemptAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSuccessAtMs => $composableBuilder(
    column: $table.lastSuccessAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextCheckAtMs => $composableBuilder(
    column: $table.nextCheckAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStateTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cursor => $composableBuilder(
    column: $table.cursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etag => $composableBuilder(
    column: $table.etag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastAttemptAtMs => $composableBuilder(
    column: $table.lastAttemptAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSuccessAtMs => $composableBuilder(
    column: $table.lastSuccessAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextCheckAtMs => $composableBuilder(
    column: $table.nextCheckAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTable> {
  $$SyncStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get cursor =>
      $composableBuilder(column: $table.cursor, builder: (column) => column);

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get etag =>
      $composableBuilder(column: $table.etag, builder: (column) => column);

  GeneratedColumn<int> get lastAttemptAtMs => $composableBuilder(
    column: $table.lastAttemptAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSuccessAtMs => $composableBuilder(
    column: $table.lastSuccessAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextCheckAtMs => $composableBuilder(
    column: $table.nextCheckAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
    column: $table.lastErrorCode,
    builder: (column) => column,
  );
}

class $$SyncStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStateTable,
          SyncStateRow,
          $$SyncStateTableFilterComposer,
          $$SyncStateTableOrderingComposer,
          $$SyncStateTableAnnotationComposer,
          $$SyncStateTableCreateCompanionBuilder,
          $$SyncStateTableUpdateCompanionBuilder,
          (
            SyncStateRow,
            BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateRow>,
          ),
          SyncStateRow,
          PrefetchHooks Function()
        > {
  $$SyncStateTableTableManager(_$AppDatabase db, $SyncStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> scope = const Value.absent(),
                Value<String?> cursor = const Value.absent(),
                Value<int?> datasetVersion = const Value.absent(),
                Value<String?> etag = const Value.absent(),
                Value<int?> lastAttemptAtMs = const Value.absent(),
                Value<int?> lastSuccessAtMs = const Value.absent(),
                Value<int?> nextCheckAtMs = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion(
                scope: scope,
                cursor: cursor,
                datasetVersion: datasetVersion,
                etag: etag,
                lastAttemptAtMs: lastAttemptAtMs,
                lastSuccessAtMs: lastSuccessAtMs,
                nextCheckAtMs: nextCheckAtMs,
                lastErrorCode: lastErrorCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String scope,
                Value<String?> cursor = const Value.absent(),
                Value<int?> datasetVersion = const Value.absent(),
                Value<String?> etag = const Value.absent(),
                Value<int?> lastAttemptAtMs = const Value.absent(),
                Value<int?> lastSuccessAtMs = const Value.absent(),
                Value<int?> nextCheckAtMs = const Value.absent(),
                Value<String?> lastErrorCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateCompanion.insert(
                scope: scope,
                cursor: cursor,
                datasetVersion: datasetVersion,
                etag: etag,
                lastAttemptAtMs: lastAttemptAtMs,
                lastSuccessAtMs: lastSuccessAtMs,
                nextCheckAtMs: nextCheckAtMs,
                lastErrorCode: lastErrorCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStateTable,
      SyncStateRow,
      $$SyncStateTableFilterComposer,
      $$SyncStateTableOrderingComposer,
      $$SyncStateTableAnnotationComposer,
      $$SyncStateTableCreateCompanionBuilder,
      $$SyncStateTableUpdateCompanionBuilder,
      (
        SyncStateRow,
        BaseReferences<_$AppDatabase, $SyncStateTable, SyncStateRow>,
      ),
      SyncStateRow,
      PrefetchHooks Function()
    >;
typedef $$LocalMerchantsTableCreateCompanionBuilder =
    LocalMerchantsCompanion Function({
      required String id,
      required String profileId,
      Value<String?> serverMerchantId,
      required String nameRaw,
      required String nameNormalized,
      Value<String?> locationText,
      Value<String> countryCode,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });
typedef $$LocalMerchantsTableUpdateCompanionBuilder =
    LocalMerchantsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String?> serverMerchantId,
      Value<String> nameRaw,
      Value<String> nameNormalized,
      Value<String?> locationText,
      Value<String> countryCode,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });

final class $$LocalMerchantsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalMerchantsTable, LocalMerchantRow> {
  $$LocalMerchantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProfilesTable _profileIdTable(_$AppDatabase db) => db
      .localProfiles
      .createAlias('local_merchants__profile_id__local_profiles__id');

  $$LocalProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalTransactionsTable, List<LocalTransactionRow>>
  _localTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localTransactions,
        aliasName: 'local_merchants__id__local_transactions__merchant_id',
      );

  $$LocalTransactionsTableProcessedTableManager get localTransactionsRefs {
    final manager = $$LocalTransactionsTableTableManager(
      $_db,
      $_db.localTransactions,
    ).filter((f) => f.merchantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalMerchantsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalMerchantsTable> {
  $$LocalMerchantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverMerchantId => $composableBuilder(
    column: $table.serverMerchantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameRaw => $composableBuilder(
    column: $table.nameRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get profileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localTransactionsRefs(
    Expression<bool> Function($$LocalTransactionsTableFilterComposer f) f,
  ) {
    final $$LocalTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localTransactions,
      getReferencedColumn: (t) => t.merchantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.localTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalMerchantsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalMerchantsTable> {
  $$LocalMerchantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverMerchantId => $composableBuilder(
    column: $table.serverMerchantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameRaw => $composableBuilder(
    column: $table.nameRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get profileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalMerchantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalMerchantsTable> {
  $$LocalMerchantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverMerchantId => $composableBuilder(
    column: $table.serverMerchantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameRaw =>
      $composableBuilder(column: $table.nameRaw, builder: (column) => column);

  GeneratedColumn<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get profileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localTransactionsRefs<T extends Object>(
    Expression<T> Function($$LocalTransactionsTableAnnotationComposer a) f,
  ) {
    final $$LocalTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localTransactions,
          getReferencedColumn: (t) => t.merchantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalMerchantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalMerchantsTable,
          LocalMerchantRow,
          $$LocalMerchantsTableFilterComposer,
          $$LocalMerchantsTableOrderingComposer,
          $$LocalMerchantsTableAnnotationComposer,
          $$LocalMerchantsTableCreateCompanionBuilder,
          $$LocalMerchantsTableUpdateCompanionBuilder,
          (LocalMerchantRow, $$LocalMerchantsTableReferences),
          LocalMerchantRow,
          PrefetchHooks Function({bool profileId, bool localTransactionsRefs})
        > {
  $$LocalMerchantsTableTableManager(
    _$AppDatabase db,
    $LocalMerchantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMerchantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalMerchantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalMerchantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String?> serverMerchantId = const Value.absent(),
                Value<String> nameRaw = const Value.absent(),
                Value<String> nameNormalized = const Value.absent(),
                Value<String?> locationText = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalMerchantsCompanion(
                id: id,
                profileId: profileId,
                serverMerchantId: serverMerchantId,
                nameRaw: nameRaw,
                nameNormalized: nameNormalized,
                locationText: locationText,
                countryCode: countryCode,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                Value<String?> serverMerchantId = const Value.absent(),
                required String nameRaw,
                required String nameNormalized,
                Value<String?> locationText = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalMerchantsCompanion.insert(
                id: id,
                profileId: profileId,
                serverMerchantId: serverMerchantId,
                nameRaw: nameRaw,
                nameNormalized: nameNormalized,
                locationText: locationText,
                countryCode: countryCode,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalMerchantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({profileId = false, localTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localTransactionsRefs) db.localTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $$LocalMerchantsTableReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $$LocalMerchantsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localTransactionsRefs)
                        await $_getPrefetchedData<
                          LocalMerchantRow,
                          $LocalMerchantsTable,
                          LocalTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalMerchantsTableReferences
                              ._localTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalMerchantsTableReferences(
                                db,
                                table,
                                p0,
                              ).localTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.merchantId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalMerchantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalMerchantsTable,
      LocalMerchantRow,
      $$LocalMerchantsTableFilterComposer,
      $$LocalMerchantsTableOrderingComposer,
      $$LocalMerchantsTableAnnotationComposer,
      $$LocalMerchantsTableCreateCompanionBuilder,
      $$LocalMerchantsTableUpdateCompanionBuilder,
      (LocalMerchantRow, $$LocalMerchantsTableReferences),
      LocalMerchantRow,
      PrefetchHooks Function({bool profileId, bool localTransactionsRefs})
    >;
typedef $$LocalTransactionsTableCreateCompanionBuilder =
    LocalTransactionsCompanion Function({
      required String id,
      required String profileId,
      required String userCardId,
      Value<String?> merchantId,
      required int transactionAtMs,
      required int amountMinor,
      Value<String> currency,
      Value<String?> mccCode,
      Value<String?> mccSource,
      Value<String?> category,
      Value<int?> cashbackEstimatedMinor,
      Value<int?> cashbackConfidencePpm,
      Value<String> source,
      Value<String?> note,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });
typedef $$LocalTransactionsTableUpdateCompanionBuilder =
    LocalTransactionsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> userCardId,
      Value<String?> merchantId,
      Value<int> transactionAtMs,
      Value<int> amountMinor,
      Value<String> currency,
      Value<String?> mccCode,
      Value<String?> mccSource,
      Value<String?> category,
      Value<int?> cashbackEstimatedMinor,
      Value<int?> cashbackConfidencePpm,
      Value<String> source,
      Value<String?> note,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int?> deletedAtMs,
      Value<String> syncStatus,
      Value<int?> serverVersion,
      Value<int?> lastSyncedAtMs,
      Value<int> rowid,
    });

final class $$LocalTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalTransactionsTable,
          LocalTransactionRow
        > {
  $$LocalTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProfilesTable _profileIdTable(_$AppDatabase db) => db
      .localProfiles
      .createAlias('local_transactions__profile_id__local_profiles__id');

  $$LocalProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalUserCardsTable _userCardIdTable(_$AppDatabase db) => db
      .localUserCards
      .createAlias('local_transactions__user_card_id__local_user_cards__id');

  $$LocalUserCardsTableProcessedTableManager get userCardId {
    final $_column = $_itemColumn<String>('user_card_id')!;

    final manager = $$LocalUserCardsTableTableManager(
      $_db,
      $_db.localUserCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userCardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalMerchantsTable _merchantIdTable(_$AppDatabase db) => db
      .localMerchants
      .createAlias('local_transactions__merchant_id__local_merchants__id');

  $$LocalMerchantsTableProcessedTableManager? get merchantId {
    final $_column = $_itemColumn<String>('merchant_id');
    if ($_column == null) return null;
    final manager = $$LocalMerchantsTableTableManager(
      $_db,
      $_db.localMerchants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_merchantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LocalCashbackCalculationsTable,
    List<LocalCashbackCalculationRow>
  >
  _localCashbackCalculationsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.localCashbackCalculations,
    aliasName:
        'local_transactions__id__local_cashback_calculations__transaction_id',
  );

  $$LocalCashbackCalculationsTableProcessedTableManager
  get localCashbackCalculationsRefs {
    final manager = $$LocalCashbackCalculationsTableTableManager(
      $_db,
      $_db.localCashbackCalculations,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCashbackCalculationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionAtMs => $composableBuilder(
    column: $table.transactionAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mccSource => $composableBuilder(
    column: $table.mccSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashbackEstimatedMinor => $composableBuilder(
    column: $table.cashbackEstimatedMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cashbackConfidencePpm => $composableBuilder(
    column: $table.cashbackConfidencePpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get profileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUserCardsTableFilterComposer get userCardId {
    final $$LocalUserCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableFilterComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalMerchantsTableFilterComposer get merchantId {
    final $$LocalMerchantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.localMerchants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalMerchantsTableFilterComposer(
            $db: $db,
            $table: $db.localMerchants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localCashbackCalculationsRefs(
    Expression<bool> Function($$LocalCashbackCalculationsTableFilterComposer f)
    f,
  ) {
    final $$LocalCashbackCalculationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashbackCalculations,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashbackCalculationsTableFilterComposer(
                $db: $db,
                $table: $db.localCashbackCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionAtMs => $composableBuilder(
    column: $table.transactionAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mccCode => $composableBuilder(
    column: $table.mccCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mccSource => $composableBuilder(
    column: $table.mccSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashbackEstimatedMinor => $composableBuilder(
    column: $table.cashbackEstimatedMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cashbackConfidencePpm => $composableBuilder(
    column: $table.cashbackConfidencePpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get profileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUserCardsTableOrderingComposer get userCardId {
    final $$LocalUserCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableOrderingComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalMerchantsTableOrderingComposer get merchantId {
    final $$LocalMerchantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.localMerchants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalMerchantsTableOrderingComposer(
            $db: $db,
            $table: $db.localMerchants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get transactionAtMs => $composableBuilder(
    column: $table.transactionAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get mccCode =>
      $composableBuilder(column: $table.mccCode, builder: (column) => column);

  GeneratedColumn<String> get mccSource =>
      $composableBuilder(column: $table.mccSource, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get cashbackEstimatedMinor => $composableBuilder(
    column: $table.cashbackEstimatedMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cashbackConfidencePpm => $composableBuilder(
    column: $table.cashbackConfidencePpm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get profileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUserCardsTableAnnotationComposer get userCardId {
    final $$LocalUserCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalMerchantsTableAnnotationComposer get merchantId {
    final $$LocalMerchantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.localMerchants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalMerchantsTableAnnotationComposer(
            $db: $db,
            $table: $db.localMerchants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localCashbackCalculationsRefs<T extends Object>(
    Expression<T> Function($$LocalCashbackCalculationsTableAnnotationComposer a)
    f,
  ) {
    final $$LocalCashbackCalculationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashbackCalculations,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashbackCalculationsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashbackCalculations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalTransactionsTable,
          LocalTransactionRow,
          $$LocalTransactionsTableFilterComposer,
          $$LocalTransactionsTableOrderingComposer,
          $$LocalTransactionsTableAnnotationComposer,
          $$LocalTransactionsTableCreateCompanionBuilder,
          $$LocalTransactionsTableUpdateCompanionBuilder,
          (LocalTransactionRow, $$LocalTransactionsTableReferences),
          LocalTransactionRow,
          PrefetchHooks Function({
            bool profileId,
            bool userCardId,
            bool merchantId,
            bool localCashbackCalculationsRefs,
          })
        > {
  $$LocalTransactionsTableTableManager(
    _$AppDatabase db,
    $LocalTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> userCardId = const Value.absent(),
                Value<String?> merchantId = const Value.absent(),
                Value<int> transactionAtMs = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> mccCode = const Value.absent(),
                Value<String?> mccSource = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<int?> cashbackEstimatedMinor = const Value.absent(),
                Value<int?> cashbackConfidencePpm = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTransactionsCompanion(
                id: id,
                profileId: profileId,
                userCardId: userCardId,
                merchantId: merchantId,
                transactionAtMs: transactionAtMs,
                amountMinor: amountMinor,
                currency: currency,
                mccCode: mccCode,
                mccSource: mccSource,
                category: category,
                cashbackEstimatedMinor: cashbackEstimatedMinor,
                cashbackConfidencePpm: cashbackConfidencePpm,
                source: source,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String userCardId,
                Value<String?> merchantId = const Value.absent(),
                required int transactionAtMs,
                required int amountMinor,
                Value<String> currency = const Value.absent(),
                Value<String?> mccCode = const Value.absent(),
                Value<String?> mccSource = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<int?> cashbackEstimatedMinor = const Value.absent(),
                Value<int?> cashbackConfidencePpm = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int?> deletedAtMs = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int?> serverVersion = const Value.absent(),
                Value<int?> lastSyncedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTransactionsCompanion.insert(
                id: id,
                profileId: profileId,
                userCardId: userCardId,
                merchantId: merchantId,
                transactionAtMs: transactionAtMs,
                amountMinor: amountMinor,
                currency: currency,
                mccCode: mccCode,
                mccSource: mccSource,
                category: category,
                cashbackEstimatedMinor: cashbackEstimatedMinor,
                cashbackConfidencePpm: cashbackConfidencePpm,
                source: source,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                syncStatus: syncStatus,
                serverVersion: serverVersion,
                lastSyncedAtMs: lastSyncedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                userCardId = false,
                merchantId = false,
                localCashbackCalculationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localCashbackCalculationsRefs)
                      db.localCashbackCalculations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $$LocalTransactionsTableReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $$LocalTransactionsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (userCardId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userCardId,
                                    referencedTable:
                                        $$LocalTransactionsTableReferences
                                            ._userCardIdTable(db),
                                    referencedColumn:
                                        $$LocalTransactionsTableReferences
                                            ._userCardIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (merchantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.merchantId,
                                    referencedTable:
                                        $$LocalTransactionsTableReferences
                                            ._merchantIdTable(db),
                                    referencedColumn:
                                        $$LocalTransactionsTableReferences
                                            ._merchantIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localCashbackCalculationsRefs)
                        await $_getPrefetchedData<
                          LocalTransactionRow,
                          $LocalTransactionsTable,
                          LocalCashbackCalculationRow
                        >(
                          currentTable: table,
                          referencedTable: $$LocalTransactionsTableReferences
                              ._localCashbackCalculationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalTransactionsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCashbackCalculationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalTransactionsTable,
      LocalTransactionRow,
      $$LocalTransactionsTableFilterComposer,
      $$LocalTransactionsTableOrderingComposer,
      $$LocalTransactionsTableAnnotationComposer,
      $$LocalTransactionsTableCreateCompanionBuilder,
      $$LocalTransactionsTableUpdateCompanionBuilder,
      (LocalTransactionRow, $$LocalTransactionsTableReferences),
      LocalTransactionRow,
      PrefetchHooks Function({
        bool profileId,
        bool userCardId,
        bool merchantId,
        bool localCashbackCalculationsRefs,
      })
    >;
typedef $$LocalCashbackCalculationsTableCreateCompanionBuilder =
    LocalCashbackCalculationsCompanion Function({
      required String id,
      required String profileId,
      required String transactionId,
      required String userCardId,
      Value<String?> rewardRuleId,
      Value<int?> estimatedCashbackMinor,
      Value<int?> appliedRatePpm,
      Value<int?> confidencePpm,
      Value<String?> explanation,
      Value<String> status,
      Value<String> calculationSource,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$LocalCashbackCalculationsTableUpdateCompanionBuilder =
    LocalCashbackCalculationsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> transactionId,
      Value<String> userCardId,
      Value<String?> rewardRuleId,
      Value<int?> estimatedCashbackMinor,
      Value<int?> appliedRatePpm,
      Value<int?> confidencePpm,
      Value<String?> explanation,
      Value<String> status,
      Value<String> calculationSource,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

final class $$LocalCashbackCalculationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalCashbackCalculationsTable,
          LocalCashbackCalculationRow
        > {
  $$LocalCashbackCalculationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.localProfiles.createAlias(
        'local_cashback_calculations__profile_id__local_profiles__id',
      );

  $$LocalProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalTransactionsTable _transactionIdTable(_$AppDatabase db) =>
      db.localTransactions.createAlias(
        'local_cashback_calculations__transaction_id__local_transactions__id',
      );

  $$LocalTransactionsTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<String>('transaction_id')!;

    final manager = $$LocalTransactionsTableTableManager(
      $_db,
      $_db.localTransactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalUserCardsTable _userCardIdTable(_$AppDatabase db) =>
      db.localUserCards.createAlias(
        'local_cashback_calculations__user_card_id__local_user_cards__id',
      );

  $$LocalUserCardsTableProcessedTableManager get userCardId {
    final $_column = $_itemColumn<String>('user_card_id')!;

    final manager = $$LocalUserCardsTableTableManager(
      $_db,
      $_db.localUserCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userCardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalCashbackCalculationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCashbackCalculationsTable> {
  $$LocalCashbackCalculationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rewardRuleId => $composableBuilder(
    column: $table.rewardRuleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedCashbackMinor => $composableBuilder(
    column: $table.estimatedCashbackMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get appliedRatePpm => $composableBuilder(
    column: $table.appliedRatePpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calculationSource => $composableBuilder(
    column: $table.calculationSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get profileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalTransactionsTableFilterComposer get transactionId {
    final $$LocalTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.localTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.localTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUserCardsTableFilterComposer get userCardId {
    final $$LocalUserCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableFilterComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashbackCalculationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCashbackCalculationsTable> {
  $$LocalCashbackCalculationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rewardRuleId => $composableBuilder(
    column: $table.rewardRuleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedCashbackMinor => $composableBuilder(
    column: $table.estimatedCashbackMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get appliedRatePpm => $composableBuilder(
    column: $table.appliedRatePpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calculationSource => $composableBuilder(
    column: $table.calculationSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get profileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalTransactionsTableOrderingComposer get transactionId {
    final $$LocalTransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.localTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalTransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.localTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUserCardsTableOrderingComposer get userCardId {
    final $$LocalUserCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableOrderingComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashbackCalculationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCashbackCalculationsTable> {
  $$LocalCashbackCalculationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rewardRuleId => $composableBuilder(
    column: $table.rewardRuleId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedCashbackMinor => $composableBuilder(
    column: $table.estimatedCashbackMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get appliedRatePpm => $composableBuilder(
    column: $table.appliedRatePpm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confidencePpm => $composableBuilder(
    column: $table.confidencePpm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get calculationSource => $composableBuilder(
    column: $table.calculationSource,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get profileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalTransactionsTableAnnotationComposer get transactionId {
    final $$LocalTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.transactionId,
          referencedTable: $db.localTransactions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$LocalUserCardsTableAnnotationComposer get userCardId {
    final $$LocalUserCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.localUserCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUserCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.localUserCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashbackCalculationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCashbackCalculationsTable,
          LocalCashbackCalculationRow,
          $$LocalCashbackCalculationsTableFilterComposer,
          $$LocalCashbackCalculationsTableOrderingComposer,
          $$LocalCashbackCalculationsTableAnnotationComposer,
          $$LocalCashbackCalculationsTableCreateCompanionBuilder,
          $$LocalCashbackCalculationsTableUpdateCompanionBuilder,
          (
            LocalCashbackCalculationRow,
            $$LocalCashbackCalculationsTableReferences,
          ),
          LocalCashbackCalculationRow,
          PrefetchHooks Function({
            bool profileId,
            bool transactionId,
            bool userCardId,
          })
        > {
  $$LocalCashbackCalculationsTableTableManager(
    _$AppDatabase db,
    $LocalCashbackCalculationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashbackCalculationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalCashbackCalculationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalCashbackCalculationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> transactionId = const Value.absent(),
                Value<String> userCardId = const Value.absent(),
                Value<String?> rewardRuleId = const Value.absent(),
                Value<int?> estimatedCashbackMinor = const Value.absent(),
                Value<int?> appliedRatePpm = const Value.absent(),
                Value<int?> confidencePpm = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> calculationSource = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashbackCalculationsCompanion(
                id: id,
                profileId: profileId,
                transactionId: transactionId,
                userCardId: userCardId,
                rewardRuleId: rewardRuleId,
                estimatedCashbackMinor: estimatedCashbackMinor,
                appliedRatePpm: appliedRatePpm,
                confidencePpm: confidencePpm,
                explanation: explanation,
                status: status,
                calculationSource: calculationSource,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String transactionId,
                required String userCardId,
                Value<String?> rewardRuleId = const Value.absent(),
                Value<int?> estimatedCashbackMinor = const Value.absent(),
                Value<int?> appliedRatePpm = const Value.absent(),
                Value<int?> confidencePpm = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> calculationSource = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => LocalCashbackCalculationsCompanion.insert(
                id: id,
                profileId: profileId,
                transactionId: transactionId,
                userCardId: userCardId,
                rewardRuleId: rewardRuleId,
                estimatedCashbackMinor: estimatedCashbackMinor,
                appliedRatePpm: appliedRatePpm,
                confidencePpm: confidencePpm,
                explanation: explanation,
                status: status,
                calculationSource: calculationSource,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCashbackCalculationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({profileId = false, transactionId = false, userCardId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $$LocalCashbackCalculationsTableReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $$LocalCashbackCalculationsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (transactionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.transactionId,
                                    referencedTable:
                                        $$LocalCashbackCalculationsTableReferences
                                            ._transactionIdTable(db),
                                    referencedColumn:
                                        $$LocalCashbackCalculationsTableReferences
                                            ._transactionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (userCardId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userCardId,
                                    referencedTable:
                                        $$LocalCashbackCalculationsTableReferences
                                            ._userCardIdTable(db),
                                    referencedColumn:
                                        $$LocalCashbackCalculationsTableReferences
                                            ._userCardIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$LocalCashbackCalculationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCashbackCalculationsTable,
      LocalCashbackCalculationRow,
      $$LocalCashbackCalculationsTableFilterComposer,
      $$LocalCashbackCalculationsTableOrderingComposer,
      $$LocalCashbackCalculationsTableAnnotationComposer,
      $$LocalCashbackCalculationsTableCreateCompanionBuilder,
      $$LocalCashbackCalculationsTableUpdateCompanionBuilder,
      (LocalCashbackCalculationRow, $$LocalCashbackCalculationsTableReferences),
      LocalCashbackCalculationRow,
      PrefetchHooks Function({
        bool profileId,
        bool transactionId,
        bool userCardId,
      })
    >;
typedef $$SyncConflictsTableCreateCompanionBuilder =
    SyncConflictsCompanion Function({
      required String id,
      required String profileId,
      required String mutationId,
      required String entityType,
      required String entityId,
      required String localPayloadJson,
      required String serverPayloadJson,
      required int serverVersion,
      required int detectedAtMs,
      Value<int?> resolvedAtMs,
      Value<String?> resolution,
      Value<int> rowid,
    });
typedef $$SyncConflictsTableUpdateCompanionBuilder =
    SyncConflictsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> mutationId,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> localPayloadJson,
      Value<String> serverPayloadJson,
      Value<int> serverVersion,
      Value<int> detectedAtMs,
      Value<int?> resolvedAtMs,
      Value<String?> resolution,
      Value<int> rowid,
    });

final class $$SyncConflictsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SyncConflictsTable, SyncConflictRow> {
  $$SyncConflictsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProfilesTable _profileIdTable(_$AppDatabase db) => db
      .localProfiles
      .createAlias('sync_conflicts__profile_id__local_profiles__id');

  $$LocalProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$LocalProfilesTableTableManager(
      $_db,
      $_db.localProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncConflictsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncConflictsTable> {
  $$SyncConflictsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mutationId => $composableBuilder(
    column: $table.mutationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPayloadJson => $composableBuilder(
    column: $table.localPayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverPayloadJson => $composableBuilder(
    column: $table.serverPayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get detectedAtMs => $composableBuilder(
    column: $table.detectedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resolvedAtMs => $composableBuilder(
    column: $table.resolvedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolution => $composableBuilder(
    column: $table.resolution,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProfilesTableFilterComposer get profileId {
    final $$LocalProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableFilterComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncConflictsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncConflictsTable> {
  $$SyncConflictsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mutationId => $composableBuilder(
    column: $table.mutationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPayloadJson => $composableBuilder(
    column: $table.localPayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverPayloadJson => $composableBuilder(
    column: $table.serverPayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get detectedAtMs => $composableBuilder(
    column: $table.detectedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resolvedAtMs => $composableBuilder(
    column: $table.resolvedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolution => $composableBuilder(
    column: $table.resolution,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProfilesTableOrderingComposer get profileId {
    final $$LocalProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncConflictsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncConflictsTable> {
  $$SyncConflictsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mutationId => $composableBuilder(
    column: $table.mutationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get localPayloadJson => $composableBuilder(
    column: $table.localPayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverPayloadJson => $composableBuilder(
    column: $table.serverPayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverVersion => $composableBuilder(
    column: $table.serverVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get detectedAtMs => $composableBuilder(
    column: $table.detectedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get resolvedAtMs => $composableBuilder(
    column: $table.resolvedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resolution => $composableBuilder(
    column: $table.resolution,
    builder: (column) => column,
  );

  $$LocalProfilesTableAnnotationComposer get profileId {
    final $$LocalProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.localProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.localProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncConflictsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncConflictsTable,
          SyncConflictRow,
          $$SyncConflictsTableFilterComposer,
          $$SyncConflictsTableOrderingComposer,
          $$SyncConflictsTableAnnotationComposer,
          $$SyncConflictsTableCreateCompanionBuilder,
          $$SyncConflictsTableUpdateCompanionBuilder,
          (SyncConflictRow, $$SyncConflictsTableReferences),
          SyncConflictRow,
          PrefetchHooks Function({bool profileId})
        > {
  $$SyncConflictsTableTableManager(_$AppDatabase db, $SyncConflictsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncConflictsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncConflictsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncConflictsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> mutationId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> localPayloadJson = const Value.absent(),
                Value<String> serverPayloadJson = const Value.absent(),
                Value<int> serverVersion = const Value.absent(),
                Value<int> detectedAtMs = const Value.absent(),
                Value<int?> resolvedAtMs = const Value.absent(),
                Value<String?> resolution = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncConflictsCompanion(
                id: id,
                profileId: profileId,
                mutationId: mutationId,
                entityType: entityType,
                entityId: entityId,
                localPayloadJson: localPayloadJson,
                serverPayloadJson: serverPayloadJson,
                serverVersion: serverVersion,
                detectedAtMs: detectedAtMs,
                resolvedAtMs: resolvedAtMs,
                resolution: resolution,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String mutationId,
                required String entityType,
                required String entityId,
                required String localPayloadJson,
                required String serverPayloadJson,
                required int serverVersion,
                required int detectedAtMs,
                Value<int?> resolvedAtMs = const Value.absent(),
                Value<String?> resolution = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncConflictsCompanion.insert(
                id: id,
                profileId: profileId,
                mutationId: mutationId,
                entityType: entityType,
                entityId: entityId,
                localPayloadJson: localPayloadJson,
                serverPayloadJson: serverPayloadJson,
                serverVersion: serverVersion,
                detectedAtMs: detectedAtMs,
                resolvedAtMs: resolvedAtMs,
                resolution: resolution,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SyncConflictsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$SyncConflictsTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$SyncConflictsTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncConflictsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncConflictsTable,
      SyncConflictRow,
      $$SyncConflictsTableFilterComposer,
      $$SyncConflictsTableOrderingComposer,
      $$SyncConflictsTableAnnotationComposer,
      $$SyncConflictsTableCreateCompanionBuilder,
      $$SyncConflictsTableUpdateCompanionBuilder,
      (SyncConflictRow, $$SyncConflictsTableReferences),
      SyncConflictRow,
      PrefetchHooks Function({bool profileId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalProfilesTableTableManager get localProfiles =>
      $$LocalProfilesTableTableManager(_db, _db.localProfiles);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$MembershipsCacheTableTableManager get membershipsCache =>
      $$MembershipsCacheTableTableManager(_db, _db.membershipsCache);
  $$BanksCacheTableTableManager get banksCache =>
      $$BanksCacheTableTableManager(_db, _db.banksCache);
  $$CreditCardsCacheTableTableManager get creditCardsCache =>
      $$CreditCardsCacheTableTableManager(_db, _db.creditCardsCache);
  $$MerchantCategoryCodesCacheTableTableManager
  get merchantCategoryCodesCache =>
      $$MerchantCategoryCodesCacheTableTableManager(
        _db,
        _db.merchantCategoryCodesCache,
      );
  $$RewardRulesCacheTableTableManager get rewardRulesCache =>
      $$RewardRulesCacheTableTableManager(_db, _db.rewardRulesCache);
  $$RewardRuleMccsCacheTableTableManager get rewardRuleMccsCache =>
      $$RewardRuleMccsCacheTableTableManager(_db, _db.rewardRuleMccsCache);
  $$MerchantMccCandidatesCacheTableTableManager
  get merchantMccCandidatesCache =>
      $$MerchantMccCandidatesCacheTableTableManager(
        _db,
        _db.merchantMccCandidatesCache,
      );
  $$MerchantBranchesCacheTableTableManager get merchantBranchesCache =>
      $$MerchantBranchesCacheTableTableManager(_db, _db.merchantBranchesCache);
  $$LocalUserCardsTableTableManager get localUserCards =>
      $$LocalUserCardsTableTableManager(_db, _db.localUserCards);
  $$LocalMerchantMccContributionsTableTableManager
  get localMerchantMccContributions =>
      $$LocalMerchantMccContributionsTableTableManager(
        _db,
        _db.localMerchantMccContributions,
      );
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$SyncStateTableTableManager get syncState =>
      $$SyncStateTableTableManager(_db, _db.syncState);
  $$LocalMerchantsTableTableManager get localMerchants =>
      $$LocalMerchantsTableTableManager(_db, _db.localMerchants);
  $$LocalTransactionsTableTableManager get localTransactions =>
      $$LocalTransactionsTableTableManager(_db, _db.localTransactions);
  $$LocalCashbackCalculationsTableTableManager get localCashbackCalculations =>
      $$LocalCashbackCalculationsTableTableManager(
        _db,
        _db.localCashbackCalculations,
      );
  $$SyncConflictsTableTableManager get syncConflicts =>
      $$SyncConflictsTableTableManager(_db, _db.syncConflicts);
}
