## v1.1.0
- Implement `saveAll` method for `Note` and `Label`.

## v1.0.0
- Upgraded to first stable release.

## v0.5.0
- Added updatedAtMillis field to `Label` class.
- Upgraded dependencies.

## v0.4.0
- Converted `Note` and `Label` classes to use `freezed`.
- Added 'millis' suffix to Moor columns that are for timestamps.

## v0.3.0
- Switched `DateTimeColumn` usages to `IntColumn` in SQLite adapter. 

## v0.2.2
- Changed skipping behaviour for queries using the SQLite adapter(it was referencing the primary key column before).

## v0.2.1
- Added lastId, limit to Label queries.
- Cleaned up moor related files.

## v0.2.0
- Added adapter for SQLite(with Moor).

## v0.1.0
- First pre-release.
