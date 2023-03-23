
CREATE OR REPLACE FUNCTION insert_beneficiario(spec jsonb)
RETURNS TABLE (j json)
LANGUAGE plpgsql
AS $BODY$
BEGIN
  INSERT INTO beneficiario (id_parentesco, nombre, apaterno, amaterno, fechanacimiento, id_sexo, usuario_creacion)
  VALUES ((spec->>'id_parentesco')::int, spec->>'nombre', spec->>'apaterno', spec->>'amaterno',(spec->>'fechanacimiento')::date, 
          (spec->>'id_sexo')::int,(spec->>'usuario_creacion')::int);
          
  RETURN QUERY SELECT json_build_object('Status', '200');
  
  EXCEPTION 
    WHEN OTHERS THEN
      RAISE INFO 'Error Name:%', SQLERRM;
      RAISE INFO 'Error State:%', SQLSTATE;
      RETURN QUERY SELECT json_build_object('Status', '400', 'Error Name', SQLERRM, 'Error State', SQLSTATE);
END;
$BODY$;