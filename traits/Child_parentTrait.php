<?php
namespace RestInPeace\Models\Traits;
trait Child_parentTrait {
    protected $hidden = ['created_at', 'updated_at'];
    protected $fillable = [];
    protected $casts = [];
    public $with = [];
    public $appends = [];
}