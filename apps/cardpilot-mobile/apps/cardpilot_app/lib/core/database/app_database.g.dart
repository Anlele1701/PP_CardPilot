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
  late final $LocalUserCardsTable localUserCards = $LocalUserCardsTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $SyncStateTable syncState = $SyncStateTable(this);
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
  late final Index idxLocalUserCardsProfileActive = Index(
    'idx_local_user_cards_profile_active',
    'CREATE INDEX idx_local_user_cards_profile_active ON local_user_cards (profile_id, deleted_at_ms)',
  );
  late final Index uqLocalUserCardsDefault = Index(
    'uq_local_user_cards_default',
    'CREATE UNIQUE INDEX uq_local_user_cards_default ON local_user_cards (profile_id) WHERE is_default = 1 AND deleted_at_ms IS NULL',
  );
  late final Index idxSyncOutboxReady = Index(
    'idx_sync_outbox_ready',
    'CREATE INDEX idx_sync_outbox_ready ON sync_outbox (profile_id, next_attempt_at_ms, created_at_ms)',
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
    localUserCards,
    syncOutbox,
    syncState,
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
    idxLocalUserCardsProfileActive,
    uqLocalUserCardsDefault,
    idxSyncOutboxReady,
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
      result: [TableUpdate('sync_outbox', kind: UpdateKind.delete)],
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
            bool syncOutboxRefs,
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
                syncOutboxRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (appSettingsRefs) db.appSettings,
                    if (localUserCardsRefs) db.localUserCards,
                    if (syncOutboxRefs) db.syncOutbox,
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
        bool syncOutboxRefs,
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
typedef $$LocalUserCardsTableCreateCompanionBuilder =
    LocalUserCardsCompanion Function({
      required String id,
      required String profileId,
      Value<String?> creditCardId,
      Value<String?> bankId,
      required String bankNameSnapshot,
      required String nickname,
      required int billingCycleDay,
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
          PrefetchHooks Function({bool profileId})
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
                                referencedTable: $$LocalUserCardsTableReferences
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
                return [];
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
  $$LocalUserCardsTableTableManager get localUserCards =>
      $$LocalUserCardsTableTableManager(_db, _db.localUserCards);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$SyncStateTableTableManager get syncState =>
      $$SyncStateTableTableManager(_db, _db.syncState);
}
