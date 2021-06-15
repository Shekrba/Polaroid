module Web.Controller.Likes where

import Web.Controller.Prelude
import Web.View.Users.New

instance Controller LikesController where
    action CreateLikeAction = do
        let like = newRecord @Like
        like
            |> buildLike
            |> ifValid \case
                Left like -> redirectTo WelcomeAction
                Right like -> do
                    like <- like 
                        |> createRecord
                        
                    let postId = get #postId like 
                    redirectTo ShowPostAction { postId }

    action DeleteLikeAction { likeId } = do
        like <- fetch likeId
        postId <- return(get #postId like)
        deleteRecord like
        redirectTo ShowPostAction { postId }

buildLike like = like
    |> fill @["postId","userId"]
