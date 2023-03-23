CREATE OR REPLACE FUNCTION insert_persona(spec jsonb)
RETURNS TABLE (j json)
LANGUAGE plpgsql
AS $BODY$
BEGIN
  INSERT INTO persona (nombre, apaterno, amaterno, sueldo, id_sexo, fecha_contrato, usuario_creacion)
  VALUES (spec->>'nombre', spec->>'apaterno', spec->>'amaterno', (spec->>'sueldo')::decimal, 
          (spec->>'id_sexo')::int, (spec->>'fecha_contrato')::date, (spec->>'usuario_creacion')::int);
          
  RETURN QUERY SELECT json_build_object('Status', '200');
  
  EXCEPTION 
    WHEN OTHERS THEN
      RAISE INFO 'Error Name:%', SQLERRM;
      RAISE INFO 'Error State:%', SQLSTATE;
      RETURN QUERY SELECT json_build_object('Status', '400', 'Error Name', SQLERRM, 'Error State', SQLSTATE);
END;
$BODY$;