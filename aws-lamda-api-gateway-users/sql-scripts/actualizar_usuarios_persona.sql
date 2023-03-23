CREATE OR REPLACE FUNCTION actualizar_usuarios_persona(p_parametros jsonb)
RETURNS SETOF jsonb AS $$
DECLARE
  v_id_usuario INTEGER := (p_parametros ->> 'id_usuario')::INTEGER;
  v_username TEXT := p_parametros ->> 'username';
  v_userpass TEXT := p_parametros ->> 'userpass';
  v_id_puesto INTEGER := (p_parametros ->> 'id_puesto')::INTEGER;
  v_id_permiso INTEGER := (p_parametros ->> 'id_permiso')::INTEGER;
  v_id_estatus INTEGER := (p_parametros ->> 'id_estatus')::INTEGER;
  v_id_persona INTEGER := (p_parametros ->> 'id_persona')::INTEGER;
  v_nombre TEXT := p_parametros ->> 'nombre';
  v_apaterno TEXT := p_parametros ->> 'apaterno';
  v_amaterno TEXT := p_parametros ->> 'amaterno';
  v_sueldo NUMERIC := (p_parametros ->> 'sueldo')::NUMERIC;
  v_id_beneficiario INTEGER := (p_parametros ->> 'id_beneficiario')::INTEGER;
  v_id_sexo INTEGER := (p_parametros ->> 'id_sexo')::INTEGER;
  v_fecha_contrato DATE := (p_parametros ->> 'fecha_contrato')::DATE;
  v_imagen TEXT := p_parametros ->> 'imagen';
BEGIN
  UPDATE usuarios
  SET username = v_username,
      userpass = v_userpass,
      id_puesto = v_id_puesto,
      id_permiso = v_id_permiso,
      id_estatus = v_id_estatus
  WHERE id_usuario = v_id_usuario;
  
  UPDATE persona
  SET nombre = v_nombre,
      apaterno = v_apaterno,
      amaterno = v_amaterno,
      sueldo = v_sueldo,
      id_beneficiario = v_id_beneficiario,
      id_sexo = v_id_sexo,
      fecha_contrato = v_fecha_contrato
  WHERE id_persona = v_id_persona;
  
  UPDATE fotografia_persona
  SET imagen = v_imagen
  WHERE id_persona = v_id_persona;
  
  RETURN QUERY SELECT jsonb_build_object('Status', '200', 'Message', 'Usuarios actualizados correctamente');
EXCEPTION 
    WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT jsonb_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$$ LANGUAGE plpgsql;
