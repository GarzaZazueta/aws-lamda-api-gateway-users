CREATE OR REPLACE FUNCTION get_beneficiarios_persona(p_parametros jsonb)
RETURNS SETOF jsonb AS $$
DECLARE
  v_id_persona INTEGER := (p_parametros ->> 'id_persona')::INTEGER;
BEGIN
  RETURN QUERY
    SELECT jsonb_build_object(
      'id_beneficiario', b.id_beneficiario,
      'id_parentesco', b.id_parentesco,
      'nombre', b.nombre,
      'apaterno', b.apaterno,
      'amaterno', b.amaterno,
      'fechanacimiento', b.fechanacimiento,
      'id_sexo', b.id_sexo,
      'id_persona', b.id_persona
    )
    FROM beneficiario b
    WHERE b.estado = 1 AND b.id_persona = v_id_persona;
	
	EXCEPTION 
    WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT jsonb_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$$ LANGUAGE plpgsql;
