create table beneficiario(
	id_beneficiario serial primary key,
	id_parentesco int NOT NULL,
	nombre varchar(50)NOT NULL,
	apaterno varchar(50)NOT NULL,
	amaterno varchar(50) NOT NULL,
	fechanacimiento date NOT NULL,
	id_sexo int NOT NULL,
	usuario_creacion integer NOT NULL,
	usuario_modificacion integer DEFAULT NULL,
	fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	fecha_modificacion TIMESTAMP WITH TIME ZONE DEFAULT NULL, 
	estado integer NOT NULL DEFAULT 1
);