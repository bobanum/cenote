<?php
namespace RestInPeace\Models\Traits;
trait Oauth_providerTrait {
    protected $hidden = ['created_at', 'updated_at'];
    protected $fillable = [];
    protected $casts = [];
    public $with = [];
    public $appends = [];
}