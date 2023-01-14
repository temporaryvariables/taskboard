// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetTBItemCollection on Isar {
  IsarCollection<TBItem> get tBItems => this.collection();
}

const TBItemSchema = CollectionSchema(
  name: r'TBItem',
  id: 7557374437325104148,
  properties: {
    r'boardColumns': PropertySchema(
      id: 0,
      name: r'boardColumns',
      type: IsarType.objectList,
      target: r'TBColumn',
    ),
    r'boardColumnsAsStrings': PropertySchema(
      id: 1,
      name: r'boardColumnsAsStrings',
      type: IsarType.stringList,
    ),
    r'column': PropertySchema(
      id: 2,
      name: r'column',
      type: IsarType.string,
    ),
    r'createdDate': PropertySchema(
      id: 3,
      name: r'createdDate',
      type: IsarType.dateTime,
    ),
    r'dueDate': PropertySchema(
      id: 4,
      name: r'dueDate',
      type: IsarType.dateTime,
    ),
    r'hashCode': PropertySchema(
      id: 5,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'lastUpdated': PropertySchema(
      id: 6,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'order': PropertySchema(
      id: 7,
      name: r'order',
      type: IsarType.long,
    ),
    r'priority': PropertySchema(
      id: 8,
      name: r'priority',
      type: IsarType.double,
    ),
    r'text': PropertySchema(
      id: 9,
      name: r'text',
      type: IsarType.string,
    ),
    r'viewType': PropertySchema(
      id: 10,
      name: r'viewType',
      type: IsarType.string,
    )
  },
  estimateSize: _tBItemEstimateSize,
  serialize: _tBItemSerialize,
  deserialize: _tBItemDeserialize,
  deserializeProp: _tBItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'parentItem': LinkSchema(
      id: -3386898756853812749,
      name: r'parentItem',
      target: r'TBItem',
      single: true,
    ),
    r'boardItems': LinkSchema(
      id: 7023054280575415698,
      name: r'boardItems',
      target: r'TBItem',
      single: false,
    )
  },
  embeddedSchemas: {r'TBColumn': TBColumnSchema},
  getId: _tBItemGetId,
  getLinks: _tBItemGetLinks,
  attach: _tBItemAttach,
  version: '3.0.5',
);

int _tBItemEstimateSize(
  TBItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.boardColumns.length * 3;
  {
    final offsets = allOffsets[TBColumn]!;
    for (var i = 0; i < object.boardColumns.length; i++) {
      final value = object.boardColumns[i];
      bytesCount += TBColumnSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.boardColumnsAsStrings.length * 3;
  {
    for (var i = 0; i < object.boardColumnsAsStrings.length; i++) {
      final value = object.boardColumnsAsStrings[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.column.length * 3;
  bytesCount += 3 + object.text.length * 3;
  bytesCount += 3 + object.viewType.length * 3;
  return bytesCount;
}

void _tBItemSerialize(
  TBItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TBColumn>(
    offsets[0],
    allOffsets,
    TBColumnSchema.serialize,
    object.boardColumns,
  );
  writer.writeStringList(offsets[1], object.boardColumnsAsStrings);
  writer.writeString(offsets[2], object.column);
  writer.writeDateTime(offsets[3], object.createdDate);
  writer.writeDateTime(offsets[4], object.dueDate);
  writer.writeLong(offsets[5], object.hashCode);
  writer.writeDateTime(offsets[6], object.lastUpdated);
  writer.writeLong(offsets[7], object.order);
  writer.writeDouble(offsets[8], object.priority);
  writer.writeString(offsets[9], object.text);
  writer.writeString(offsets[10], object.viewType);
}

TBItem _tBItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TBItem(
    reader.readString(offsets[9]),
    reader.readString(offsets[2]),
    reader.readLong(offsets[7]),
  );
  object.boardColumns = reader.readObjectList<TBColumn>(
        offsets[0],
        TBColumnSchema.deserialize,
        allOffsets,
        TBColumn(),
      ) ??
      [];
  object.createdDate = reader.readDateTime(offsets[3]);
  object.dueDate = reader.readDateTimeOrNull(offsets[4]);
  object.id = id;
  object.lastUpdated = reader.readDateTime(offsets[6]);
  object.priority = reader.readDoubleOrNull(offsets[8]);
  object.viewType = reader.readString(offsets[10]);
  return object;
}

P _tBItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TBColumn>(
            offset,
            TBColumnSchema.deserialize,
            allOffsets,
            TBColumn(),
          ) ??
          []) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tBItemGetId(TBItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tBItemGetLinks(TBItem object) {
  return [object.parentItem, object.boardItems];
}

void _tBItemAttach(IsarCollection<dynamic> col, Id id, TBItem object) {
  object.id = id;
  object.parentItem
      .attach(col, col.isar.collection<TBItem>(), r'parentItem', id);
  object.boardItems
      .attach(col, col.isar.collection<TBItem>(), r'boardItems', id);
}

extension TBItemQueryWhereSort on QueryBuilder<TBItem, TBItem, QWhere> {
  QueryBuilder<TBItem, TBItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TBItemQueryWhere on QueryBuilder<TBItem, TBItem, QWhereClause> {
  QueryBuilder<TBItem, TBItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TBItemQueryFilter on QueryBuilder<TBItem, TBItem, QFilterCondition> {
  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardColumnsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumns',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardColumnsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumns',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardColumnsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumns',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumns',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumns',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardColumnsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumns',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardColumnsAsStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardColumnsAsStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardColumnsAsStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardColumnsAsStrings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boardColumnsAsStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boardColumnsAsStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boardColumnsAsStrings',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boardColumnsAsStrings',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardColumnsAsStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boardColumnsAsStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumnsAsStrings',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumnsAsStrings',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumnsAsStrings',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumnsAsStrings',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumnsAsStrings',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardColumnsAsStringsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardColumnsAsStrings',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'column',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'column',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'column',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'column',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'column',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'column',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'column',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'column',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'column',
        value: '',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> columnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'column',
        value: '',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> createdDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> createdDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> createdDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> createdDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> dueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> dueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> dueDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> dueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> dueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> dueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> lastUpdatedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> orderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> orderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> orderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> orderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> priorityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> priorityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> priorityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> priorityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> priorityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> priorityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viewType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viewType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viewType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viewType',
        value: '',
      ));
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> viewTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viewType',
        value: '',
      ));
    });
  }
}

extension TBItemQueryObject on QueryBuilder<TBItem, TBItem, QFilterCondition> {
  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardColumnsElement(
      FilterQuery<TBColumn> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'boardColumns');
    });
  }
}

extension TBItemQueryLinks on QueryBuilder<TBItem, TBItem, QFilterCondition> {
  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> parentItem(
      FilterQuery<TBItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'parentItem');
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> parentItemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parentItem', 0, true, 0, true);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardItems(
      FilterQuery<TBItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'boardItems');
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardItemsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', length, true, length, true);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', 0, true, 0, true);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', 0, false, 999999, true);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardItemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', 0, true, length, include);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition>
      boardItemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', length, include, 999999, true);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterFilterCondition> boardItemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'boardItems', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TBItemQuerySortBy on QueryBuilder<TBItem, TBItem, QSortBy> {
  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByCreatedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByViewType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> sortByViewTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.desc);
    });
  }
}

extension TBItemQuerySortThenBy on QueryBuilder<TBItem, TBItem, QSortThenBy> {
  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByCreatedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByViewType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.asc);
    });
  }

  QueryBuilder<TBItem, TBItem, QAfterSortBy> thenByViewTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'viewType', Sort.desc);
    });
  }
}

extension TBItemQueryWhereDistinct on QueryBuilder<TBItem, TBItem, QDistinct> {
  QueryBuilder<TBItem, TBItem, QDistinct> distinctByBoardColumnsAsStrings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardColumnsAsStrings');
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByColumn(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'column', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdDate');
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDate');
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TBItem, TBItem, QDistinct> distinctByViewType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'viewType', caseSensitive: caseSensitive);
    });
  }
}

extension TBItemQueryProperty on QueryBuilder<TBItem, TBItem, QQueryProperty> {
  QueryBuilder<TBItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TBItem, List<TBColumn>, QQueryOperations>
      boardColumnsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardColumns');
    });
  }

  QueryBuilder<TBItem, List<String>, QQueryOperations>
      boardColumnsAsStringsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardColumnsAsStrings');
    });
  }

  QueryBuilder<TBItem, String, QQueryOperations> columnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'column');
    });
  }

  QueryBuilder<TBItem, DateTime, QQueryOperations> createdDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdDate');
    });
  }

  QueryBuilder<TBItem, DateTime?, QQueryOperations> dueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDate');
    });
  }

  QueryBuilder<TBItem, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<TBItem, DateTime, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<TBItem, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<TBItem, double?, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<TBItem, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<TBItem, String, QQueryOperations> viewTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'viewType');
    });
  }
}
