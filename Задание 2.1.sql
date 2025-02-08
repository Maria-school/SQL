
Проект 2.1 DDL конструкции для создания и модернизации таблиц.


CREATE TABLE public.arena (
	id int4 NOT NULL,
	"name" varchar NOT NULL,
	"size" int4 NOT NULL DEFAULT 100,
	CONSTRAINT arena_pk PRIMARY KEY (id),
	CONSTRAINT arena_un UNIQUE (name)
);


CREATE TABLE public.team (
	id int4 NOT NULL,
	city varchar NOT NULL,
	"name" varchar NOT NULL,
	coach_name varchar NOT NULL,
	arena_id int4 NOT NULL,
	CONSTRAINT team_pk PRIMARY KEY (id),
	CONSTRAINT team_un UNIQUE (name),
	CONSTRAINT team_un1 UNIQUE (coach_name),
	CONSTRAINT team_arena_id_fk FOREIGN KEY (arena_id) REFERENCES public.arena(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE public.player (
	id int4 NOT NULL,
	name varchar NOT NULL,
	"position" varchar NOT NULL,
	height numeric NOT NULL,
	weight numeric NOT NULL,
	salary numeric NOT NULL,
	team_id int4 NOT NULL,
	CONSTRAINT constraint_name CHECK ((height > (0)::numeric)),
	CONSTRAINT constraint_name1 CHECK ((weight > (0)::numeric)),
	CONSTRAINT constraint_name2 CHECK ((salary > (0)::numeric)),
	CONSTRAINT player_pk PRIMARY KEY (id),
	CONSTRAINT player_un UNIQUE (name),
	CONSTRAINT player_team_id_fk FOREIGN KEY (team_id) REFERENCES public.team(id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE public.game (
	id int4 NOT NULL,
	owner_team_id int4 NOT NULL,
	guest_team_id int4 NOT NULL,
	game_date date NOT NULL,
	winner_team_id int4 NOT NULL,
	owner_score int4 NOT NULL DEFAULT 0,
	guest_score int4 NOT NULL DEFAULT 0,
	arena_id int4 NOT NULL,
	CONSTRAINT constraint_name CHECK ((owner_score >= 0)),
	CONSTRAINT constraint_name1 CHECK ((guest_score >= 0)),
	CONSTRAINT game_pk PRIMARY KEY (id),
	CONSTRAINT game_un UNIQUE (owner_team_id, guest_team_id),
	CONSTRAINT game_arena_fk FOREIGN KEY (arena_id) REFERENCES public.arena(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT game_team_fk FOREIGN KEY (owner_team_id) REFERENCES public.team(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT game_team_fk1 FOREIGN KEY (guest_team_id) REFERENCES public.team(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT game_team_fk2 FOREIGN KEY (winner_team_id) REFERENCES public.team(id) ON DELETE CASCADE ON UPDATE CASCADE
);