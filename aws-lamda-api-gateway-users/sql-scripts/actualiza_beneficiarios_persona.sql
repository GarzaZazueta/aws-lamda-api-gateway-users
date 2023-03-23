CREATE OR REPLACE FUNCTION actualiza_beneficiarios_persona(p_parametros jsonb)
RETURNS JSONB AS $$
DECLARE
  v_id_persona INTEGER := (p_parametros ->> 'id_persona')::INTEGER;
  v_id_beneficiario INTEGER := (p_parametros ->> 'id_beneficiario')::INTEGER;
BEGIN
  UPDATE beneficiario
  SET nombre = p_parametros ->> 'nombre',
      apaterno = p_parametros ->> 'apaterno',
      amaterno = p_parametros ->> 'amaterno',
      id_parentesco = (p_parametros ->> 'id_parentesco')::INTEGER,
      id_sexo = (p_parametros ->> 'id_sexo')::INTEGER,
      fechanacimiento = (p_parametros ->> 'fechanacimiento')::DATE,
      usuario_modificacion = (p_parametros ->> 'usuario_modificacion')::INTEGER
  WHERE id_persona = v_id_persona AND id_beneficiario = v_id_beneficiario;
  
  IF FOUND THEN
    RETURN jsonb_build_object('status', '200', 'message', 'Cambio exitoso');
  ELSE
    RETURN jsonb_build_object('status', '400', 'message', 'No se pudo actualizar el beneficiario');
  END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
END;
$$ LANGUAGE plpgsql;