
CREATE OR REPLACE FUNCTION baja_usuario(p_parametros jsonb)
RETURNS JSONB AS $$
DECLARE
  v_id_usuario INTEGER := (p_parametros ->> 'id_usuario')::INTEGER;
BEGIN
  UPDATE usuarios SET estado = 0 WHERE id_usuario = v_id_usuario;
  
  IF FOUND THEN
    RETURN jsonb_build_object('status', '200', 'message', 'Usuario Eliminado con Exito');
  ELSE
    RETURN jsonb_build_object('status', '400', 'message', 'No se pudo actualizar el usuario');
  END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
        RETURN jsonb_build_object('status', '500', 'message', 'Ocurrió un error en la función', 'error', SQLERRM);
END;
$$ LANGUAGE plpgsql;
