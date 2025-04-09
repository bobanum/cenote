<?php
namespace RestInPeace\Models\Traits;
trait ProfileTrait {
    protected $hidden = ['created_at', 'updated_at'];
    protected $fillable = [];
    protected $casts = [];
    public $with = [];
    public $appends = [];
}