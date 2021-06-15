module Web.Controller.Follows where

import Web.Controller.Prelude
import Web.View.Users.New

instance Controller FollowsController where
    action CreateFollowAction = do
        let follow = newRecord @Follow
        follow
            |> buildFollow
            |> ifValid \case
                Left follow -> do 
                    redirectTo WelcomeAction 
                Right follow -> do
                    follow <- follow 
                        |> createRecord
                    userId <- return(get #userId follow)
                    redirectTo ShowUserAction { userId }

    action DeleteFollowAction { followId } = do
        follow <- fetch followId
        userId <- return(get #userId follow)
        deleteRecord follow
        redirectTo ShowUserAction { userId }

buildFollow follow = follow
    |> fill @["followerId","userId"]
