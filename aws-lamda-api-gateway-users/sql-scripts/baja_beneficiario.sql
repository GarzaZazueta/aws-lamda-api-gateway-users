CREATE OR REPLACE FUNCTION baja_beneficiario(p_parametros jsonb)
RETURNS JSONB AS $$
DECLARE
  v_id_beneficiario INTEGER := (p_parametros ->> 'id_beneficiario')::INTEGER;
BEGIN
  UPDATE beneficiario SET estado = 0 WHERE id_beneficiario = v_id_beneficiario;
  
  IF FOUND THEN
    RETURN jsonb_build_object('status', '200', 'message', 'Actualización exitosa');
  ELSE
    RETURN jsonb_build_object('status', '400', 'message', 'No se pudo actualizar el beneficiario');
  END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
        RETURN jsonb_build_object('status', '500', 'message', 'Ocurrió un error en la función', 'error', SQLERRM);
END;
$$ LANGUAGE plpgsql;
