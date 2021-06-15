module Web.Controller.Follows where

import Web.Controller.Prelude
import Web.View.Follows.Index
import Web.View.Follows.New
import Web.View.Follows.Edit
import Web.View.Follows.Show

instance Controller FollowsController where
    action FollowsAction = do
        follows <- query @Follow |> fetch
        render IndexView { .. }

    action NewFollowAction = do
        let follow = newRecord
        render NewView { .. }

    action ShowFollowAction { followId } = do
        follow <- fetch followId
        render ShowView { .. }

    action EditFollowAction { followId } = do
        follow <- fetch followId
        render EditView { .. }

    action UpdateFollowAction { followId } = do
        follow <- fetch followId
        follow
            |> buildFollow
            |> ifValid \case
                Left follow -> render EditView { .. }
                Right follow -> do
                    follow <- follow |> updateRecord
                    setSuccessMessage "Follow updated"
                    redirectTo EditFollowAction { .. }

    action CreateFollowAction = do
        let follow = newRecord @Follow
        follow
            |> buildFollow
            |> ifValid \case
                Left follow -> do 
                    render NewView { .. } 
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
