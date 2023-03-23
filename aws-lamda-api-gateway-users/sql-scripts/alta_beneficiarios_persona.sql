CREATE OR REPLACE FUNCTION alta_beneficiarios_persona(p_parametros jsonb)
RETURNS JSONB AS $$
DECLARE
  v_id_persona INTEGER := (p_parametros ->> 'id_persona')::INTEGER;
BEGIN
  INSERT INTO beneficiario(id_persona, nombre, apaterno, amaterno, id_parentesco, id_sexo, fechanacimiento, usuario_creacion)
  VALUES (v_id_persona, p_parametros ->> 'nombre', p_parametros ->> 'apaterno', p_parametros ->> 'amaterno', (p_parametros ->> 'id_parentesco')::INTEGER, (p_parametros ->> 'id_sexo')::INTEGER, (p_parametros ->> 'fechanacimiento')::DATE, (p_parametros ->> 'usuario_creacion')::INTEGER);
  
  IF FOUND THEN
    RETURN jsonb_build_object('status', '200', 'message', 'Inserción exitosa');
  ELSE
    RETURN jsonb_build_object('status', '400', 'message', 'No se pudo insertar el beneficiario');
  END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
        RETURN jsonb_build_object('status', '500', 'message', 'Ocurrió un error en la función', 'error', SQLERRM);
END;
$$ LANGUAGE plpgsql;
