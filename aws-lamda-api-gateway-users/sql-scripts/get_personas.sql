CREATE OR REPLACE FUNCTION get_personas()
RETURNS SETOF jsonb AS $$
BEGIN
  RETURN QUERY
    SELECT jsonb_build_object(
      'id_persona', id_persona,
      'nombre', nombre,
      'apaterno', apaterno,
      'amaterno', amaterno,
      'sueldo', sueldo,
      'id_beneficiario', id_beneficiario,
      'id_sexo', id_sexo,
      'fecha_contrato', fecha_contrato,
      'usuario_creacion', usuario_creacion,
      'usuario_modificacion', usuario_modificacion,
      'fecha_creacion', fecha_creacion,
      'fecha_modificacion', fecha_modificacion,
      'estado', estado
    )
    FROM persona;
	
	EXCEPTION 
    WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT jsonb_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$$ LANGUAGE plpgsql;