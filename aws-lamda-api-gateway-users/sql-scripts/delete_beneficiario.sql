CREATE OR REPLACE FUNCTION delete_beneficiario(spec jsonb)
RETURNS TABLE (j json)
LANGUAGE plpgsql
AS $BODY$
BEGIN
  UPDATE beneficiario SET estado = 0 WHERE id_beneficiario = (spec->>'id_beneficiario')::int;
  RETURN QUERY SELECT json_build_object('Status', '200');
  
  EXCEPTION 
    WHEN OTHERS THEN
      RAISE INFO 'Error Name:%', SQLERRM;
      RAISE INFO 'Error State:%', SQLSTATE;
      RETURN QUERY SELECT json_build_object('Status', '400', 'Error Name', SQLERRM, 'Error State', SQLSTATE);
END;
$BODY$;
			