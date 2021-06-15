module Web.View.Layout (defaultLayout, Html) where

import IHP.ViewPrelude
import IHP.Environment
import qualified Text.Blaze.Html5            as H
import qualified Text.Blaze.Html5.Attributes as A
import Generated.Types
import IHP.Controller.RequestContext
import Web.Types
import Web.Routes
import Data.Maybe

defaultLayout :: Html -> Html
defaultLayout inner = H.docTypeHtml ! A.lang "en" $ [hsx|
<head>
    {metaTags}

    {stylesheets}
    {scripts}

    <title>Polaroid</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <a class="navbar-brand text-center" href={WelcomeAction}>
            <div class="geeks">
                <img src="images/polaroid-icon.png"/>
                <label>Polaroid</label>
            </div>
        </a>
        {userImage currentUserOrNothing}
    </nav>
    <div class="container mt-4">
        {renderFlashMessages}
        {inner}
    </div>
</body>
|]

stylesheets :: Html
stylesheets = [hsx|
        <link rel="stylesheet" href="/vendor/bootstrap.min.css"/>
        <link rel="stylesheet" href="/vendor/flatpickr.min.css"/>
        <link rel="stylesheet" href="/app.css"/>
    |]

scripts :: Html
scripts = [hsx|
        <script id="livereload-script" src="/livereload.js"></script>
        <script src="/vendor/jquery-3.2.1.slim.min.js"></script>
        <script src="/vendor/timeago.js"></script>
        <script src="/vendor/popper.min.js"></script>
        <script src="/vendor/bootstrap.min.js"></script>
        <script src="/vendor/flatpickr.js"></script>
        <script src="/vendor/morphdom-umd.min.js"></script>
        <script src="/vendor/turbolinks.js"></script>
        <script src="/vendor/turbolinksInstantClick.js"></script>
        <script src="/vendor/turbolinksMorphdom.js"></script>
        <script src="/helpers.js"></script>
        <script src="/ihp-auto-refresh.js"></script>
    |]

metaTags :: Html
metaTags = [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta property="og:title" content="App"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="TODO"/>
    <meta property="og:description" content="TODO"/>
    {autoRefreshMeta}
|]

userImage user
    | null user = [hsx|
        <form method="post" action={SearchAction} class="form-inline ml-auto">
            <input name="searchQuery" class="form-control mr-sm-2" type="search" placeholder="Search Users...">
            <input class="btn btn-outline-light" type="submit" value="Search"/>
        </form>
    |]
    | otherwise = [hsx|
        <a class="text text-light no-decoration ml-auto mr-5" href={NewPostAction}>
            <img class="small-profile-image ml-3" src="images/plus.png"/>
        </a>
        <form method="post" action={SearchAction} class="form-inline mr-auto">
            <input name="searchQuery" class="form-control mr-sm-2" type="search" placeholder="Search Users...">
            <input class="btn btn-outline-light" type="submit" value="Search"/>
        </form>
        
        <ul class="navbar-nav">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <img class="small-profile-image mr-2" src={fromJust (get #pictureUrl currentUser)}/>
                    {get #firstName currentUser <> " " <> get #lastName currentUser}
                </a>
                <div class="dropdown-menu bg-dark" aria-labelledby="navbarDropdownMenuLink">
                    <a class="dropdown-item bg-dark text-light" href={ShowUserAction (get #id currentUser)}>View Profile</a>
                    <a class="dropdown-item bg-dark text-light" href={EditUserAction (get #id currentUser)}>Edit Profile</a>
                    <a class="js-delete dropdown-item bg-dark text-light" href={DeleteUserAction (get #id currentUser)}>Delete Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item bg-dark js-delete js-delete-no-confirm text-light" href={DeleteSessionAction}>Logout</a>
                </div>
            </li>
        </ul>
        
    |]