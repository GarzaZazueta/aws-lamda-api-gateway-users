CREATE OR REPLACE FUNCTION insert_cat_parentesco( spec jsonb)
RETURNS table (j json)
LANGUAGE plpgsql
AS $BODY$

begin
	
  insert into cat_parentesco (descripcion, usuario_creacion)
  select j.spec->>'descripcion', 
  		(j.spec->>'usuario_creacion')::int
  from jsonb_array_elements(spec) as j(spec);
  RETURN QUERY select json_build_object('Status', '200');
  
  exception 
    when others then
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        RETURN QUERY select json_build_object('Status', '400','Error Name',SQLERRM,'Error State',SQLSTATE);
  
end;
$BODY$;							
			