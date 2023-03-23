create table usuarios(
	id_usuario serial primary key,
	username text NOT NULL,
	userpass text NOT NULL,
	id_puesto integer NOT NULL,
	id_permiso integer NOT NULL,
	id_estatus integer NOT NULL,
	usuario_creacion integer NOT NULL,
	usuario_modificacion integer DEFAULT NULL,
	fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	fecha_modificacion TIMESTAMP WITH TIME ZONE DEFAULT NULL, 
	estado integer NOT NULL DEFAULT 1
);