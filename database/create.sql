DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS refresh_token;
DROP TABLE IF EXISTS profile;
DROP TABLE IF EXISTS child_parent;
DROP TABLE IF EXISTS note_todo;
DROP TABLE IF EXISTS note_checklist;
DROP TABLE IF EXISTS note;
DROP TABLE IF EXISTS type;
DROP TABLE IF EXISTS access_token;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS oauth_provider;
CREATE TABLE IF NOT EXISTS oauth_provider (
	id INTEGER,
	name VARCHAR(100) NOT NULL UNIQUE,
	client_id VARCHAR(255) NOT NULL,
	client_secret VARCHAR(255) NOT NULL,
	auth_url TEXT NOT NULL,
	token_url TEXT NOT NULL,
	scopes TEXT,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS user (
	id INTEGER,
	email VARCHAR(255) NOT NULL UNIQUE,
	username VARCHAR(255),
	password_hash VARCHAR(255),
	oauth_provider VARCHAR(50),
	oauth_provider_user_id VARCHAR(255),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS access_token (
	id INTEGER,
	user_id INTEGER,
	access_token TEXT NOT NULL,
	refresh_token TEXT,
	expires_at TIMESTAMP,
	scope TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	revoked_at TIMESTAMP,
	FOREIGN KEY(user_id) REFERENCES user(id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS type (
	id INTEGER,
	name VARCHAR(50) NOT NULL UNIQUE,
	description TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	deleted_at TIMESTAMP,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS note (
	id INTEGER,
	user_id INTEGER,
	type_id INTEGER DEFAULT 'note',
	title INTEGER DEFAULT '',
	details TEXT DEFAULT '',
	style INTEGER DEFAULT '',
	keywords INTEGER DEFAULT '',
	created_at INTEGER DEFAULT current_timestamp,
	updated_at INTEGER DEFAULT current_timestamp,
	deleated_at INTEGER,
	FOREIGN KEY(user_id) REFERENCES user(id) ON DELETE CASCADE,
	FOREIGN KEY(type_id) REFERENCES type(id),
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS note_todo (
	id INTEGER,
	note_id INTEGER NOT NULL,
	priority INTEGER DEFAULT 5,
	deadline TIMESTAMP,
	reminder TIMESTAMP,
	completion_status INTEGER DEFAULT 0,
	completed_at TIMESTAMP,
	recurrence TEXT,
	created_at INTEGER DEFAULT current_timestamp,
	updated_at INTEGER DEFAULT current_timestamp,
	deleated_at INTEGER,
	FOREIGN KEY(note_id) REFERENCES note(id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS note_checklist (
	id INTEGER,
	note_id INTEGER NOT NULL,
	checked INTEGER DEFAULT 0,
	checked_at TIMESTAMP,
	created_at INTEGER DEFAULT current_timestamp,
	updated_at INTEGER DEFAULT current_timestamp,
	deleated_at INTEGER,
	FOREIGN KEY(note_id) REFERENCES note(id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS child_parent (
	id INTEGER,
	child_id INTEGER NOT NULL,
	parent_id INTEGER NOT NULL,
	created_at INTEGER DEFAULT current_timestamp,
	updated_at INTEGER DEFAULT current_timestamp,
	deleated_at INTEGER,
	FOREIGN KEY(child_id) REFERENCES note(id) ON DELETE CASCADE,
	FOREIGN KEY(parent_id) REFERENCES note(id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS profile (
	id INTEGER,
	user_id INTEGER REFERENCES user(id) ON DELETE CASCADE,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	bio TEXT,
	date_of_birth TIMESTAMP,
	gender INTEGER DEFAULT 0,
	address VARCHAR(255),
	phone_number VARCHAR(50),
	social_links TEXT,
	image_url TEXT,
	root_id INTEGER,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	deleted_at TIMESTAMP,
	FOREIGN KEY(user_id) REFERENCES user(id) ON DELETE CASCADE,
	FOREIGN KEY(root_id) REFERENCES note(id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS refresh_token (
	id INTEGER,
	user_id INTEGER,
	refresh_token TEXT NOT NULL,
	expires_at TIMESTAMP,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(user_id) REFERENCES user(id) ON DELETE CASCADE,
	PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS comment (
	id INTEGER,
	note_id INTEGER NOT NULL,
	user_id INTEGER,
	comment TEXT,
	visible INTEGER DEFAULT 1,
	moderated INTEGER DEFAULT 0,
	created_at INTEGER DEFAULT current_timestamp,
	updated_at INTEGER DEFAULT current_timestamp,
	deleated_at INTEGER,
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(note_id) REFERENCES note(id) on delete cascade,
	PRIMARY KEY(id)
);
-- STOP;
-- DUMMY DATA FOR oauth_provider
INSERT INTO oauth_provider (
		id,
		name,
		client_id,
		client_secret,
		auth_url,
		token_url,
		scopes
	)
VALUES (
		1,
		'Google',
		'your_google_client_id',
		'your_google_client_secret',
		'https://accounts.google.com/o/oauth2/auth',
		'https://oauth2.googleapis.com/token',
		'email profile'
	),
	(
		2,
		'Facebook',
		'your_facebook_client_id',
		'your_facebook_client_secret',
		'https://www.facebook.com/v10.0/dialog/oauth',
		'https://graph.facebook.com/v10.0/oauth/access_token',
		'email public_profile'
	),
	(
		3,
		'Twitter',
		'your_twitter_client_id',
		'your_twitter_client_secret',
		'https://api.twitter.com/oauth/authenticate',
		'https://api.twitter.com/oauth/access_token',
		'read write'
	);
-- DUMMY DATA FOR user
INSERT INTO user (
		id,
		email,
		username,
		password_hash,
		oauth_provider,
		oauth_provider_user_id
	)
VALUES (
		1,
		'dummy@example.com',
		'dummy',
		'dummy',
		'dummy',
		'dummy'
	),
	(
		2,
		'redummy@example.com',
		'redummy',
		'redummy',
		'redummy',
		'redummy'
	);
-- DUMMY DATA FOR access_token
INSERT INTO access_token (
		id,
		user_id,
		access_token,
		refresh_token,
		expires_at,
		scope
	)
VALUES (
		1,
		1,
		'your_access_token',
		'your_refresh_token',
		CURRENT_TIMESTAMP + 60 * 60 * 24 * 365,
		'email profile'
	),
	(
		2,
		2,
		'your_access_token',
		'your_refresh_token',
		CURRENT_TIMESTAMP + 60 * 60 * 24 * 365,
		'email public_profile'
	);
-- DUMMY DATA FOR type
INSERT INTO type (id, name, description)
VALUES (
		1,
		'root',
		'This is the root type of note. It is attributed to a user at creation.'
	),
	(
		2,
		'note',
		'This is a note type. It is used for general notes with just a title and dedails texts.'
	),
	(
		3,
		'todo',
		'This is a todo type. It is used for notes with a list of todos.'
	),
	(
		4,
		'checklist',
		'This is a checklist type. It is used for notes with a list of checklists.'
	);
-- DUMMY DATA FOR note
INSERT INTO note (
		id,
		user_id,
		type_id,
		title,
		details,
		style,
		keywords
	)
VALUES (
		1,
		1,
		1,
		'Dummy''s root',
		'This is the root of dummy.',
		'',
		'root base note'
	),
	(
		2,
		2,
		1,
		'Redummy''s root',
		'This is the root of redummy.',
		'',
		'root base note'
	),
	(
		3,
		2,
		2,
		'Dummy''s todo',
		'This is the todo of Dummy.',
		'',
		'todo'
	),
	(
		4,
		1,
		2,
		'Redummy''s todo',
		'This is a sub-todo of Dummy.',
		'',
		'todo'
	),
	(
		5,
		2,
		3,
		'Redummy''s checklist',
		'This is the checklist of Redummy.',
		'',
		'checklist'
	);
-- DUMMY DATA FOR note_todo
INSERT INTO note_todo (
		id,
		note_id,
		priority,
		deadline,
		reminder,
		completion_status,
		completed_at,
		recurrence
	)
VALUES (
		1,
		1,
		5,
		CURRENT_TIMESTAMP + 60 * 60 * 24,
		CURRENT_TIMESTAMP + 60 * 60 * 24,
		0,
		NULL,
		NULL
	),
	(
		2,
		2,
		3,
		CURRENT_TIMESTAMP + 60 * 60 * 24 * 7,
		CURRENT_TIMESTAMP + 60 * 60 * 24 * 7,
		0,
		NULL,
		NULL
	);
-- DUMMY DATA FOR note_checklist
INSERT INTO note_checklist (id, note_id, checked, checked_at)
VALUES (1, 1, 0, NULL),
	(2, 2, 0, NULL);
-- DUMMY DATA FOR child_parent
INSERT INTO child_parent (id, child_id, parent_id)
VALUES (1, 1, 2),
	(2, 2, 3),
	(3, 3, 1);
-- DUMMY DATA FOR profile
INSERT INTO profile (
		id,
		user_id,
		first_name,
		last_name,
		bio,
		date_of_birth,
		gender,
		address,
		phone_number,
		social_links,
		image_url,
		root_id
	)
VALUES (
		1,
		1,
		'Dummy',
		'User',
		'This is a dummy user.',
		'1990-01-01',
		0,
		'123 Dummy St.',
		'1234567890',
		'{"facebook": "dummy_fb", "twitter": "dummy_tw"}',
		'http://example.com/dummy.jpg',
		1
	),
	(
		2,
		2,
		'Redummy',
		'User',
		'This is a redummy user.',
		'1990-01-01',
		0,
		'123 Redummy St.',
		'0987654321',
		'{"facebook": "redummy_fb", "twitter": "redummy_tw"}',
		'http://example.com/redummy.jpg',
		2
	);
-- DUMMY DATA FOR refresh_token
-- DUMMY DATA FOR comment
