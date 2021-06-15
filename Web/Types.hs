module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import IHP.LoginSupport.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    | SearchAction
    deriving (Eq, Show, Data)

data PostsController
    = NewPostAction
    | ShowPostAction { postId :: !(Id Post) }
    | CreatePostAction
    | EditPostAction { postId :: !(Id Post) }
    | UpdatePostAction { postId :: !(Id Post) }
    | DeletePostAction { postId :: !(Id Post) }
    deriving (Eq, Show, Data)

data FollowsController
    = CreateFollowAction
    | DeleteFollowAction { followId :: !(Id Follow) }
    deriving (Eq, Show, Data)


data LikesController
    = CreateLikeAction
    | DeleteLikeAction { likeId :: !(Id Like) }
    deriving (Eq, Show, Data)

data CommentsController
    = CreateCommentAction
    | EditCommentAction { commentId :: !(Id Comment) }
    | UpdateCommentAction { commentId :: !(Id Comment) }
    | DeleteCommentAction { commentId :: !(Id Comment) }
    deriving (Eq, Show, Data)
