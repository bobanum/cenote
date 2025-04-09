<?php
return [
    'excluded_tables' => [
        'sqlite_sequence',
    ],
    'hidden_tables' => [],
    'hidden_columns' => [
        'users' => ['password', 'remember_token'],
    ],
    'hide_suffixed_views' => true,
    'primary_key_pattern' => '^id$',
    'foreign_key_pattern' => '^([a-0-9_]+)_id$',
];
