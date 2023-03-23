
CREATE OR REPLACE FUNCTION get_info_exportar()
RETURNS SETOF jsonb AS $$
DECLARE

BEGIN
  RETURN QUERY
    SELECT jsonb_build_object(
      'id_usuario', u.id_usuario,
      'username', u.username,
      'userpass', u.userpass,
      'id_puesto', u.id_puesto,
      'id_permiso', u.id_permiso,
      'id_estatus', u.id_estatus,
      'id_persona', p.id_persona,
      'nombre', p.nombre,
      'apaterno', p.apaterno,
      'amaterno', p.amaterno,
      'sueldo', p.sueldo,
      'id_beneficiario', p.id_beneficiario,
      'id_sexo', p.id_sexo,
      'fecha_contrato', p.fecha_contrato
    )
    FROM usuarios u 
    INNER JOIN persona p ON p.id_persona = u.id_persona 
	INNER JOIN fotografia_persona f on f.id_persona = u.id_persona
    WHERE u.estado = 1;
	
	EXCEPTION 
    WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT jsonb_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$$ LANGUAGE plpgsql;