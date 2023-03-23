CREATE OR REPLACE FUNCTION insert_usuario(spec jsonb)
RETURNS TABLE (j json)
LANGUAGE plpgsql
AS $BODY$
BEGIN
  INSERT INTO usuarios (username, userpass, id_puesto, id_permiso, id_estatus, usuario_creacion)
  VALUES (spec->>'username', spec->>'userpass', (spec->>'id_puesto')::int, (spec->>'id_permiso')::int, 
          (spec->>'id_estatus')::int, (spec->>'usuario_creacion')::int);
          
  RETURN QUERY SELECT json_build_object('Status', '200');
  
  EXCEPTION 
    WHEN OTHERS THEN
      RAISE INFO 'Error Name:%', SQLERRM;
      RAISE INFO 'Error State:%', SQLSTATE;
      RETURN QUERY SELECT json_build_object('Status', '400', 'Error Name', SQLERRM, 'Error State', SQLSTATE);
END;
$BODY$;