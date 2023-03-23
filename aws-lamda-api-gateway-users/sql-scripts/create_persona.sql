create table persona(
	id_persona serial primary key,
	nombre varchar(50)NOT NULL,
	apaterno varchar(50)NOT NULL,
	amaterno varchar(50) NOT NULL,
	sueldo decimal NOT NULL,
	id_beneficiario integer DEFAULT NULL,
	id_sexo int NOT NULL,
	fecha_contrato date NOT NULL,
	usuario_creacion integer NOT NULL,
	usuario_modificacion integer DEFAULT NULL,
	fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	fecha_modificacion TIMESTAMP WITH TIME ZONE DEFAULT NULL, 
	estado integer NOT NULL DEFAULT 1
);