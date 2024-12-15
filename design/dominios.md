## Dominios de los Atributos

### Entidad: `passengers`

- `passengerid`: int, not null (*clave primaria*).
- `name`: varchar(100), not null.
- `age`: int, not null.
- `birthplanet`: varchar(100), not null (*referenciando `planets`*).
- `destinationplanet`: varchar(100), not null (*referenciando `planets`*).
- `birthsystem`: varchar(100), not null (*referenciando `planets`*).
- `destinationsystem`: varchar(100), not null (*referenciando `planets`*).
- `tutorid`: int (*referenciando `passengers`*).
- `cabinnumber`: int, not null (*referenciando `cabins`*).
- `side`: char(1), enum('p', 's'), not null (*referenciando `cabins`*).
- `letter`: char(1), not null (*referenciando `decks`*).
- `isvip`: boolean, not null.
- `iscryosleep`: boolean, not null.
- `ismissing`: boolean, not null.

### Entidad: `cabins`

- `cabinnumber`: int, not null (*clave primaria*).
- `side`: enum('p', 's'), not null (*clave primaria*).
- `letter`: char(1), not null (*clave primaria*) (*referenciando `decks`*).
- `robotid`: int (*referenciando `robots`*).

### Entidad: `decks`

- `letter`: char(1), not null (*clave primaria*).
- `class`: enum('first', 'second', 'third'), not null.
