CREATE OR REPLACE PROCEDURE sp_players_team_name(player_name VARCHAR(50), OUT team_name VARCHAR(45))
LANGUAGE plpgsql
AS $$
DECLARE
    v_first_name VARCHAR(25);
    v_last_name VARCHAR(25);
BEGIN
    SELECT split_part(player_name, ' ', 1), split_part(player_name, ' ', 2) INTO v_first_name, v_last_name;

    SELECT t.name
    INTO team_name
    FROM players AS p
    JOIN teams AS t ON p.team_id = t.id
    WHERE p.first_name = v_first_name AND p.last_name = v_last_name;

    IF team_name IS NULL THEN
        team_name := 'The player currently has no team';
    END IF;
END;
$$;