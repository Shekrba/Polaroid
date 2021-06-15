module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome

instance Controller StaticController where
    action WelcomeAction = do
        posts :: [Post] <- case currentUserOrNothing of
            Just currentUser -> do
                sqlQuery "SELECT * FROM Posts p WHERE p.user_id IN (SELECT f.user_id FROM Follows f WHERE f.follower_id = ?) ORDER BY p.created_at DESC" (Only currentUserId)
            Nothing -> do
                return []

        trackTableRead "posts"
        
        users :: [User] <- case currentUserOrNothing of
            Just currentUser -> do
                sqlQuery "SELECT u.* FROM Posts p LEFT JOIN Users u ON p.user_id = u.id WHERE p.user_id IN (SELECT f.user_id FROM Follows f WHERE f.follower_id = ?) ORDER BY p.created_at DESC" (Only currentUserId)
            Nothing -> do
                return []

        postsUsers :: [(Post, User)] <- return(zip posts users)
        
        trackTableRead "users"

        render WelcomeView { postsUsers }
