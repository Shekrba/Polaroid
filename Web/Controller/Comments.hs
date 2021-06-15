module Web.Controller.Comments where

import Web.Controller.Prelude
import Web.View.Comments.Edit

instance Controller CommentsController where
    action EditCommentAction { commentId } = do
        comment <- fetch commentId
        render EditView { .. }

    action UpdateCommentAction { commentId } = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> render EditView { .. }
                Right comment -> do
                    comment <- comment |> updateRecord
                    setSuccessMessage "Comment updated"
                    postId <- return (get #postId comment)
                    redirectTo ShowPostAction { postId }

    action CreateCommentAction = do
        let comment = newRecord @Comment
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> redirectTo WelcomeAction
                Right comment -> do
                    comment <- comment |> createRecord
                    let postId = get #postId comment
                    redirectTo ShowPostAction { postId }

    action DeleteCommentAction { commentId } = do
        comment <- fetch commentId
        postId <- return(get #postId comment)
        deleteRecord comment
        setSuccessMessage "Comment deleted"
        redirectTo ShowPostAction {postId}

buildComment comment = comment
    |> fill @["userId","postId","text"]
