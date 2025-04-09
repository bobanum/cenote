<?php
namespace RestInPeace\Models\Traits;
trait Access_tokenTrait {
    protected $hidden = ['created_at', 'updated_at'];
    protected $fillable = [];
    protected $casts = [];
    public $with = [];
    public $appends = [];
}