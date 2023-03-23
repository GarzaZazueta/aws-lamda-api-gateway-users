CREATE OR REPLACE FUNCTION update_persona(spec jsonb)
RETURNS table (j json)
LANGUAGE plpgsql
AS $BODY$
DECLARE
  keys TEXT[] := array_agg(key) FROM jsonb_object_keys(spec) AS key;
BEGIN
    UPDATE persona AS p
    SET 
      nombre = CASE WHEN 'nombre' = ANY(keys) THEN spec->>'nombre' ELSE p.nombre END, 
      apaterno = CASE WHEN 'apaterno' = ANY(keys) THEN spec->>'apaterno' ELSE p.apaterno END,
      amaterno = CASE WHEN 'amaterno' = ANY(keys) THEN spec->>'amaterno' ELSE p.amaterno END,
      sueldo = CASE WHEN 'sueldo' = ANY(keys) THEN (spec->>'sueldo')::DECIMAL ELSE p.sueldo END,
      id_beneficiario = CASE WHEN 'id_beneficiario' = ANY(keys) THEN (spec->>'id_beneficiario')::INT ELSE p.id_beneficiario END,
      id_sexo = CASE WHEN 'id_sexo' = ANY(keys) THEN (spec->>'id_sexo')::INT ELSE p.id_sexo END,
      fecha_contrato = CASE WHEN 'fecha_contrato' = ANY(keys) THEN (spec->>'fecha_contrato')::DATE ELSE p.fecha_contrato END,
      usuario_creacion = CASE WHEN 'usuario_creacion' = ANY(keys) THEN (spec->>'usuario_creacion')::INT ELSE p.usuario_creacion END,
      usuario_modificacion = CASE WHEN 'usuario_modificacion' = ANY(keys) THEN (spec->>'usuario_modificacion')::INT ELSE p.usuario_modificacion END,
      fecha_modificacion = CASE WHEN 'fecha_modificacion' = ANY(keys) THEN (spec->>'fecha_modificacion')::TIMESTAMP ELSE p.fecha_modificacion END,
      estado = CASE WHEN 'estado' = ANY(keys) THEN (spec->>'estado')::INT ELSE p.estado END
    WHERE p.id_persona = (spec->>'id_persona')::INT;
    
    RETURN QUERY SELECT json_build_object('Status', '200');
    
    EXCEPTION 
      WHEN OTHERS THEN
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY SELECT json_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
END;
$BODY$;