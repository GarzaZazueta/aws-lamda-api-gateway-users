create table fotografia(
	id_fotografia serial primary key,
	id_usuario integer NOT NULL,
	fotografia_b64 text NOT NULL,
	usuario_creacion integer NOT NULL,
	usuario_modificacion integer DEFAULT NULL,
	fecha_creacion TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	fecha_modificacion TIMESTAMP WITH TIME ZONE DEFAULT NULL, 
	estado integer NOT NULL DEFAULT 1,
	CONSTRAINT fk_id_usuario
      FOREIGN KEY(id_usuario) 
	  REFERENCES usuarios(id_usuario)
	  ON DELETE SET NULL
);
