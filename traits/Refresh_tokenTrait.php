<?php
namespace RestInPeace\Models\Traits;
trait Refresh_tokenTrait {
    protected $hidden = ['created_at', 'updated_at'];
    protected $fillable = [];
    protected $casts = [];
    public $with = [];
    public $appends = [];
}