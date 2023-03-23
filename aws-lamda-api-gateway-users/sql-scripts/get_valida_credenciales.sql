CREATE OR REPLACE FUNCTION get_valida_credenciales(
    IN in_data JSONB
) RETURNS JSONB AS $$
DECLARE 
    in_username TEXT;
    in_userpass TEXT;
    result JSONB;
BEGIN
    in_username := in_data ->> 'username';
    in_userpass := in_data ->> 'userpass';
    SELECT jsonb_build_object(
            'id_usuario', u.id_usuario,
            'username', u.username,
            'id_permiso', u.id_permiso
        )
        INTO result
        FROM usuarios u
        WHERE u.username = in_username
            AND u.userpass = in_userpass
            AND u.estado = 1;
    IF NOT FOUND THEN
        RETURN jsonb_build_object(
            'Status', '400',
            'Error', 'No se encontró un usuario con las credenciales proporcionadas'
        );
    END IF;
    RETURN result;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN jsonb_build_object(
                'Status', '400',
                'Error Name', SQLERRM,
                'Error State', SQLSTATE
            );
END;
$$ LANGUAGE plpgsql;