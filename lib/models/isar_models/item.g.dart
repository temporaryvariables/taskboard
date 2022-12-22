// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetItemCollection on Isar {
  IsarCollection<Item> get items => this.collection();
}

const ItemSchema = CollectionSchema(
  name: r'Item',
  id: 7900997316587104717,
  properties: {
    r'boardColumns': PropertySchema(
      id: 0,
      name: r'boardColumns',
      type: IsarType.objectList,
      target: r'IsarColumn',
    ),
    r'boardColumnsAsStrings': PropertySchema(
      id: 1,
      name: r'boardColumnsAsStrings',
      type: IsarType.stringList,
    ),
    r'boardName': PropertySchema(
      id: 2,
      name: r'boardName',
      type: IsarType.string,
    ),
    r'column': PropertySchema(
      id: 3,
      name: r'column',
      type: IsarType.string,
    ),
    r'createdDate': PropertySchema(
      id: 4,
      name: r'createdDate',
      type: IsarType.dateTime,
    ),
    r'dueDate': PropertySchema(
      id: 5,
      name: r'dueDate',
      type: IsarType.dateTime,
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
    )
  },
  estimateSize: _itemEstimateSize,
  serialize: _itemSerialize,
  deserialize: _itemDeserialize,
  deserializeProp: _itemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'parentItem': LinkSchema(
      id: 1216117801803782283,
      name: r'parentItem',
      target: r'Item',
      single: true,
    ),
    r'boardItems': LinkSchema(
      id: 1129891052633164834,
      name: r'boardItems',
      target: r'Item',
      single: false,
    )
  },
  embeddedSchemas: {r'IsarColumn': IsarColumnSchema},
  getId: _itemGetId,
  getLinks: _itemGetLinks,
  attach: _itemAttach,
  version: '3.0.5',
);

int _itemEstimateSize(
  Item object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.boardColumns.length * 3;
  {
    final offsets = allOffsets[IsarColumn]!;
    for (var i = 0; i < object.boardColumns.length; i++) {
      final value = object.boardColumns[i];
      bytesCount += IsarColumnSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.boardColumnsAsStrings.length * 3;
  {
    for (var i = 0; i < object.boardColumnsAsStrings.length; i++) {
      final value = object.boardColumnsAsStrings[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.boardName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.column.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _itemSerialize(
  Item object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<IsarColumn>(
    offsets[0],
    allOffsets,
    IsarColumnSchema.serialize,
    object.boardColumns,
  );
  writer.writeStringList(offsets[1], object.boardColumnsAsStrings);
  writer.writeString(offsets[2], object.boardName);
  writer.writeString(offsets[3], object.column);
  writer.writeDateTime(offsets[4], object.createdDate);
  writer.writeDateTime(offsets[5], object.dueDate);
  writer.writeDateTime(offsets[6], object.lastUpdated);
  writer.writeLong(offsets[7], object.order);
  writer.writeDouble(offsets[8], object.priority);
  writer.writeString(offsets[9], object.text);
}

Item _itemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Item(
    reader.readString(offsets[9]),
    reader.readString(offsets[3]),
    reader.readLong(offsets[7]),
  );
  object.boardColumns = reader.readObjectList<IsarColumn>(
        offsets[0],
        IsarColumnSchema.deserialize,
        allOffsets,
        IsarColumn(),
      ) ??
      [];
  object.boardName = reader.readStringOrNull(offsets[2]);
  object.createdDate = reader.readDateTime(offsets[4]);
  object.dueDate = reader.readDateTimeOrNull(offsets[5]);
  object.id = id;
  object.lastUpdated = reader.readDateTime(offsets[6]);
  object.priority = reader.readDouble(offsets[8]);
  return object;
}

P _itemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<IsarColumn>(
            offset,
            IsarColumnSchema.deserialize,
            allOffsets,
            IsarColumn(),
          ) ??
          []) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _itemGetId(Item object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _itemGetLinks(Item object) {
  return [object.parentItem, object.boardItems];
}

void _itemAttach(IsarCollection<dynamic> col, Id id, Item object) {
  object.id = id;
  object.parentItem.attach(col, col.isar.collection<Item>(), r'parentItem', id);
  object.boardItems.attach(col, col.isar.collection<Item>(), r'boardItems', id);
}

extension ItemQueryWhereSort on QueryBuilder<Item, Item, QWhere> {
  QueryBuilder<Item, Item, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ItemQueryWhere on QueryBuilder<Item, Item, QWhereClause> {
  QueryBuilder<Item, Item, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Item, Item, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Item, Item, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Item, Item, QAfterWhereClause> idBetween(
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

extension ItemQueryFilter on QueryBuilder<Item, Item, QFilterCondition> {
  QueryBuilder<Item, Item, QAfterFilterCondition> boardColumnsLengthEqualTo(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> boardColumnsIsEmpty() {
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

  QueryBuilder<Item, Item, QAfterFilterCondition> boardColumnsIsNotEmpty() {
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

  QueryBuilder<Item, Item, QAfterFilterCondition> boardColumnsLengthLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> boardColumnsLengthGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> boardColumnsLengthBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
      boardColumnsAsStringsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardColumnsAsStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition>
      boardColumnsAsStringsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boardColumnsAsStrings',
        value: '',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition>
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

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boardName',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boardName',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boardName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boardName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boardName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boardName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardName',
        value: '',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boardName',
        value: '',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> columnEqualTo(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> columnGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> columnLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> columnBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> columnStartsWith(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> columnEndsWith(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> columnContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'column',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> columnMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'column',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> columnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'column',
        value: '',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> columnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'column',
        value: '',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> createdDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> createdDateGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> createdDateLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> createdDateBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> dueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> dueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> dueDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> dueDateGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> dueDateLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> dueDateBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> lastUpdatedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> lastUpdatedGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> lastUpdatedLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> lastUpdatedBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> orderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> orderGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> orderLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> orderBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> priorityEqualTo(
    double value, {
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

  QueryBuilder<Item, Item, QAfterFilterCondition> priorityGreaterThan(
    double value, {
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

  QueryBuilder<Item, Item, QAfterFilterCondition> priorityLessThan(
    double value, {
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

  QueryBuilder<Item, Item, QAfterFilterCondition> priorityBetween(
    double lower,
    double upper, {
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

  QueryBuilder<Item, Item, QAfterFilterCondition> textEqualTo(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> textGreaterThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> textLessThan(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> textBetween(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> textStartsWith(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> textEndsWith(
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

  QueryBuilder<Item, Item, QAfterFilterCondition> textContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> textMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension ItemQueryObject on QueryBuilder<Item, Item, QFilterCondition> {
  QueryBuilder<Item, Item, QAfterFilterCondition> boardColumnsElement(
      FilterQuery<IsarColumn> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'boardColumns');
    });
  }
}

extension ItemQueryLinks on QueryBuilder<Item, Item, QFilterCondition> {
  QueryBuilder<Item, Item, QAfterFilterCondition> parentItem(
      FilterQuery<Item> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'parentItem');
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> parentItemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parentItem', 0, true, 0, true);
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardItems(
      FilterQuery<Item> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'boardItems');
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardItemsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', length, true, length, true);
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardItemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', 0, true, 0, true);
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardItemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', 0, false, 999999, true);
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardItemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', 0, true, length, include);
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardItemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'boardItems', length, include, 999999, true);
    });
  }

  QueryBuilder<Item, Item, QAfterFilterCondition> boardItemsLengthBetween(
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

extension ItemQuerySortBy on QueryBuilder<Item, Item, QSortBy> {
  QueryBuilder<Item, Item, QAfterSortBy> sortByBoardName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardName', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByBoardNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardName', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByCreatedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension ItemQuerySortThenBy on QueryBuilder<Item, Item, QSortThenBy> {
  QueryBuilder<Item, Item, QAfterSortBy> thenByBoardName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardName', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByBoardNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardName', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'column', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByCreatedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdDate', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<Item, Item, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension ItemQueryWhereDistinct on QueryBuilder<Item, Item, QDistinct> {
  QueryBuilder<Item, Item, QDistinct> distinctByBoardColumnsAsStrings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardColumnsAsStrings');
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByBoardName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByColumn(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'column', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByCreatedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdDate');
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDate');
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<Item, Item, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension ItemQueryProperty on QueryBuilder<Item, Item, QQueryProperty> {
  QueryBuilder<Item, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Item, List<IsarColumn>, QQueryOperations>
      boardColumnsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardColumns');
    });
  }

  QueryBuilder<Item, List<String>, QQueryOperations>
      boardColumnsAsStringsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardColumnsAsStrings');
    });
  }

  QueryBuilder<Item, String?, QQueryOperations> boardNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardName');
    });
  }

  QueryBuilder<Item, String, QQueryOperations> columnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'column');
    });
  }

  QueryBuilder<Item, DateTime, QQueryOperations> createdDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdDate');
    });
  }

  QueryBuilder<Item, DateTime?, QQueryOperations> dueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDate');
    });
  }

  QueryBuilder<Item, DateTime, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<Item, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<Item, double, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<Item, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
