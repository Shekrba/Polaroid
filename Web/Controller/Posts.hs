module Web.Controller.Posts where

import Web.Controller.Prelude
import Web.View.Posts.New
import Web.View.Posts.Edit
import Web.View.Posts.Show

instance Controller PostsController where
    action NewPostAction = do
        let post = newRecord
                |> set #userId currentUserId
        render NewView { .. }

    action ShowPostAction { postId } = do
        post <- fetch postId
        user <- fetch (get #userId post)
        like <- case currentUserOrNothing of
            Just currentUser -> do
                query @Like
                    |> filterWhere (#userId, currentUserId)
                    |> filterWhere(#postId, postId)
                    |> fetchOneOrNothing
            Nothing -> do
                return (Nothing)
        numOfLikes :: Int <- query @Like
            |> filterWhere (#postId, postId)
            |> fetchCount
        numOfComments :: Int <- query @Comment
            |> filterWhere (#postId, postId)
            |> fetchCount
        comments <- query @Comment
            |> filterWhere (#postId, postId)
            |> orderByDesc #createdAt
            |> fetch
            >>= collectionFetchRelated #userId

        render ShowView { .. }

    action EditPostAction { postId } = do
        post <- fetch postId
        render EditView { .. }

    action UpdatePostAction { postId } = do
        post <- fetch postId
        post
            |> buildPost
            |> ifValid \case
                Left post -> render EditView { .. }
                Right post -> do
                    post <- post |> updateRecord
                    setSuccessMessage "Post updated"
                    let postId = get #id post
                    redirectTo ShowPostAction { postId }

    action CreatePostAction = do
        let post = newRecord @Post

        let profilePictureOptions = ImageUploadOptions
                { convertTo = "jpg"
                , imageMagickOptions = "-resize '1024x1024^' -gravity north -extent 1024x1024 -quality 85% -strip"
                }

        post
            |> buildPost
            |> ifValid \case
                Left post -> render NewView { .. } 
                Right post -> do
                    post <- post 
                        |> createRecord
                        >>= uploadImageWithOptions profilePictureOptions #pictureUrl
                        >>= updateRecord
                    setSuccessMessage "Post created"
                    let userId = currentUserId
                    redirectTo WelcomeAction

    action DeletePostAction { postId } = do
        post <- fetch postId
        deleteRecord post
        setSuccessMessage "Post deleted"
        let userId = currentUserId
        redirectTo ShowUserAction {userId}

buildPost post = post
    |> fill @["description","userId","pictureUrl"]
