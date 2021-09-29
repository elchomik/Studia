<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Article;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware'=>'auth:api'],function(){
    Route::get('/articles',[ArticleController::class,'index'])->name('articles');
    Route::get('/articles/{article}',[ArticleController::class,'show'])->name('singleArticle');
    Route::post('/articles',[ArticleController::class,'store'])->name('createArticle');
    Route::put('/articles/{article}',[ArticleController::class,'update'])->name('updateArticle');
    Route::delete('/articles/{article}',[ArticleController::class,'delete'])->name('deleteArticle');
});
Route::post('/register',[RegisterController::class,'register'])->name('register');
Route::post('/login',[LoginController::class,'login'])->name('login');
Route::post('/login',[LoginController::class,'logout'])->name('logout');
