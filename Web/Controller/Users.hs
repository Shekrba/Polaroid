module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.Index
import Web.View.Users.New
import Web.View.Users.Edit
import Web.View.Users.Show
import Web.View.Users.Search

instance Controller UsersController where
    action UsersAction = do 
        let searchQuery = param @Text "searchQuery"
        
        users :: [User] <- sqlQuery "SELECT * FROM Users u WHERE LOWER(u.email) LIKE '%' || LOWER(?) || '%' OR LOWER(u.first_name) LIKE '%' || LOWER(?) || '%' OR LOWER(u.last_name) LIKE '%' || LOWER(?) || '%'" (searchQuery,searchQuery,searchQuery)
        render SearchView { users }

    action SearchAction = do
        if hasParam "searchQuery"
        then do
            let searchQuery = param @Text "searchQuery"
            redirectToPath ("/Users?searchQuery=" <> searchQuery)
        else redirectTo WelcomeAction

    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action ShowUserAction { userId } = do
        user <- fetch userId

        posts <- query @Post
            |> orderByDesc #createdAt
            |> filterWhere (#userId, userId)
            |> fetch
        
        follow <- case currentUserOrNothing of
            Just currentUser -> do
                query @Follow
                    |> filterWhere (#userId, userId)
                    |> filterWhere(#followerId, currentUserId)
                    |> fetchOneOrNothing
            Nothing -> do
                return (Nothing)
                    

        render ShowView { .. }

    action EditUserAction { userId } = do
        user <- fetch userId
        render EditView { .. }

    action UpdateUserAction { userId } = do
        user <- fetch userId

        let profilePictureOptions = ImageUploadOptions
                { convertTo = "jpg"
                , imageMagickOptions = "-resize '1024x1024^' -gravity north -extent 1024x1024 -quality 85% -strip"
                }

        user
            |> fill @["email", "passwordHash", "firstName", "lastName", "pictureUrl"]
            |> uploadImageWithOptions profilePictureOptions #pictureUrl
            >>= ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    hashed <- hashPassword (get #passwordHash user)
                    user <- user
                        |> set #passwordHash hashed 
                        |> updateRecord
                    setSuccessMessage "Your changes have been saved."
                    let userId = get #id user
                    redirectTo ShowUserAction { userId }

    action CreateUserAction = do
        let user = newRecord @User

        let profilePictureOptions = ImageUploadOptions
                { convertTo = "jpg"
                , imageMagickOptions = "-resize '1024x1024^' -gravity north -extent 1024x1024 -quality 85% -strip"
                }
        user
            |> fill @["email", "passwordHash", "firstName", "lastName", "pictureUrl"]
            |> validateField #email isEmail
            |> validateField #passwordHash nonEmpty
            |> validateField #firstName nonEmpty
            |> validateField #lastName nonEmpty
            |> ifValid \case
                Left user -> render NewView { .. }
                Right user -> do
                    hashed <- hashPassword (get #passwordHash user)
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                        >>= uploadImageWithOptions profilePictureOptions #pictureUrl
                        >>= updateRecord
                    setSuccessMessage "You have registered successfully"
                    redirectTo WelcomeAction

    action DeleteUserAction { userId } = do
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "User deleted"
        redirectTo WelcomeAction

buildUser user = user
    |> fill @["email","passwordHash","failedLoginAttempts","firstName","lastName"]
