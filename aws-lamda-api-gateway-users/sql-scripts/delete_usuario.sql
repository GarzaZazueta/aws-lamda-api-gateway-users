CREATE OR REPLACE FUNCTION delete_usuario(spec jsonb)
RETURNS TABLE (j json)
LANGUAGE plpgsql
AS $BODY$
BEGIN
  UPDATE usuarios SET estado = 0 WHERE id_usuario = (spec->>'id_usuario')::int;
  RETURN QUERY SELECT json_build_object('Status', '200');
  
  EXCEPTION 
    WHEN OTHERS THEN
      RAISE INFO 'Error Name:%', SQLERRM;
      RAISE INFO 'Error State:%', SQLSTATE;
      RETURN QUERY SELECT json_build_object('Status', '400', 'Error Name', SQLERRM, 'Error State', SQLSTATE);
END;
$BODY$;