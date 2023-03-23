create table cat_parentesco(
	id_parentesco serial primary key,
	descripcion varchar(20)NOT NULL,
	usuario_creacion integer NOT NULL,
	usuario_modificacion integer DEFAULT NULL,
	fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	fecha_modificacion TIMESTAMP WITH TIME ZONE DEFAULT NULL, 
	estado integer NOT NULL DEFAULT 1
);
