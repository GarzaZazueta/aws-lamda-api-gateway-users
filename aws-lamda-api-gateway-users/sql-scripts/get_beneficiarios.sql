CREATE OR REPLACE FUNCTION get_beneficiarios()
RETURNS SETOF jsonb AS $$
BEGIN
  RETURN QUERY
    SELECT jsonb_build_object(
      'id_beneficiario', id_beneficiario,
      'id_parentesco', id_parentesco,
      'nombre', nombre,
      'apaterno', apaterno,
      'amaterno', amaterno,
      'fechanacimiento', fechanacimiento,
      'id_sexo', id_sexo,
      'usuario_creacion', usuario_creacion,
      'usuario_modificacion', usuario_modificacion,
      'fecha_creacion', fecha_creacion,
      'fecha_modificacion', fecha_modificacion,
      'estado', estado
    )
    FROM beneficiario;
	
	EXCEPTION 
    WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT jsonb_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$$ LANGUAGE plpgsql;