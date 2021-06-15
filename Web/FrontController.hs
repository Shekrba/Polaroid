module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Comments
import Web.Controller.Likes
import Web.Controller.Follows
import Web.Controller.Posts
import Web.Controller.Users
import Web.Controller.Users
import Web.Controller.Static
import IHP.LoginSupport.Middleware
import Web.Controller.Sessions

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        , parseRoute @SessionsController
        -- Generator Marker
        , parseRoute @CommentsController
        , parseRoute @LikesController
        , parseRoute @FollowsController
        , parseRoute @PostsController
        , parseRoute @UsersController
        , parseRoute @StaticController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User
