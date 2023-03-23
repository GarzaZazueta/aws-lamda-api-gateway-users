CREATE OR REPLACE FUNCTION get_usuarios()
RETURNS SETOF JSON AS $$
BEGIN
  RETURN QUERY
    SELECT json_build_object(
      'id_usuario', id_usuario,
      'username', username,
      'userpass', userpass,
      'id_puesto', id_puesto,
      'id_permiso', id_permiso,
	  'id_estatus', id_estatus,
	  'usuario_creacion', usuario_creacion,
	  'usuario_modificacion', usuario_modificacion,
	  'fecha_creacion', fecha_creacion,
	  'fecha_modificacion', fecha_modificacion,
	  'estado', estado
    )
    FROM usuarios;
	
	exception 
    when others then
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY select json_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$$ LANGUAGE plpgsql;