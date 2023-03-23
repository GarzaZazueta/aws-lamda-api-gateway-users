CREATE OR REPLACE FUNCTION crear_usuarios_persona(p_parametros jsonb)
RETURNS SETOF jsonb AS $$
DECLARE
  v_id_usuario INTEGER;
  v_username TEXT := p_parametros ->> 'username';
  v_userpass TEXT := p_parametros ->> 'userpass';
  v_id_puesto INTEGER := (p_parametros ->> 'id_puesto')::INTEGER;
  v_id_permiso INTEGER := (p_parametros ->> 'id_permiso')::INTEGER;
  v_id_estatus INTEGER := (p_parametros ->> 'id_estatus')::INTEGER;
  v_nombre TEXT := p_parametros ->> 'nombre';
  v_apaterno TEXT := p_parametros ->> 'apaterno';
  v_amaterno TEXT := p_parametros ->> 'amaterno';
  v_sueldo NUMERIC := (p_parametros ->> 'sueldo')::NUMERIC;
  v_id_sexo INTEGER := (p_parametros ->> 'id_sexo')::INTEGER;
  v_fecha_contrato DATE := (p_parametros ->> 'fecha_contrato')::DATE;
  v_imagen TEXT := p_parametros ->> 'imagen';
  v_persona_id INTEGER;
  v_usuario_creacion INTEGER := (p_parametros ->> 'usuario_creacion')::INTEGER;
BEGIN
  INSERT INTO persona (nombre, apaterno, amaterno, sueldo, id_sexo, fecha_contrato,usuario_creacion)
  VALUES (v_nombre, v_apaterno, v_amaterno, v_sueldo, v_id_sexo, v_fecha_contrato,v_usuario_creacion)
  RETURNING id_persona INTO v_persona_id;
  
  INSERT INTO usuarios (username, userpass, id_puesto, id_permiso, id_estatus, id_persona,usuario_creacion)
  VALUES (v_username, v_userpass, v_id_puesto, v_id_permiso, v_id_estatus, v_persona_id,v_usuario_creacion);
  
  INSERT INTO fotografia_persona (id_persona, imagen)
  VALUES (v_persona_id, v_imagen);
  
  RETURN QUERY SELECT jsonb_build_object('Status', '200', 'Message', 'Usuarios creados correctamente');
EXCEPTION 
    WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT jsonb_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$$ LANGUAGE plpgsql;