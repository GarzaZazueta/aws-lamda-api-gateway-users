CREATE OR REPLACE FUNCTION update_usuario(spec jsonb)
RETURNS table (j json)
LANGUAGE plpgsql
AS $BODY$
DECLARE
  keys TEXT[] := array_agg(key) FROM jsonb_object_keys(spec) AS key;
BEGIN
    UPDATE usuarios AS u
    SET 
      username = CASE WHEN 'username' = ANY(keys) THEN spec->>'username' ELSE u.username END, 
      userpass = CASE WHEN 'userpass' = ANY(keys) THEN spec->>'userpass' ELSE u.userpass END,
      id_puesto = CASE WHEN 'id_puesto' = ANY(keys) THEN (spec->>'id_puesto')::INT ELSE u.id_puesto END,
      id_permiso = CASE WHEN 'id_permiso' = ANY(keys) THEN (spec->>'id_permiso')::INT ELSE u.id_permiso END,
      id_estatus = CASE WHEN 'id_estatus' = ANY(keys) THEN (spec->>'id_estatus')::INT ELSE u.id_estatus END,
      usuario_creacion = CASE WHEN 'usuario_creacion' = ANY(keys) THEN (spec->>'usuario_creacion')::INT ELSE u.usuario_creacion END
    WHERE u.id_usuario = (spec->>'id_usuario')::INT;
    
    RETURN QUERY SELECT json_build_object('Status', '200');
    
    EXCEPTION 
      WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT json_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$BODY$;