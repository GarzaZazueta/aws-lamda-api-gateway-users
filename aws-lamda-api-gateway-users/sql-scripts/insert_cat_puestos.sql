CREATE OR REPLACE FUNCTION insert_cat_puestos( spec jsonb)
     RETURNS void
LANGUAGE plpgsql
AS $BODY$
begin
  insert into cat_puestos (descripcion, usuario_creacion)
  select j.spec->>'descripcion', 
  		(j.spec->>'usuario_creacion')::int
  from jsonb_array_elements(spec) as j(spec);
end;
$BODY$;