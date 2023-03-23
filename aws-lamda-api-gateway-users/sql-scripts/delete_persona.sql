CREATE OR REPLACE FUNCTION delete_persona(spec jsonb)
RETURNS TABLE (j json)
LANGUAGE plpgsql
AS $BODY$
BEGIN
  UPDATE persona SET estado = 0 WHERE id_persona = (spec->>'id_persona')::int;
  RETURN QUERY SELECT json_build_object('Status', '200');
  
  EXCEPTION 
    WHEN OTHERS THEN
      RAISE INFO 'Error Name:%', SQLERRM;
      RAISE INFO 'Error State:%', SQLSTATE;
      RETURN QUERY SELECT json_build_object('Status', '400', 'Error Name', SQLERRM, 'Error State', SQLSTATE);
END;
$BODY$;
			