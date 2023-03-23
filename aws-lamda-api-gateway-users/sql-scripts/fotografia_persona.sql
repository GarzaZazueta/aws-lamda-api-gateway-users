create table fotografia_persona(
	id_fotografia serial primary key,
	id_persona integer NOT NULL,
	imagen text NOT NULL
);