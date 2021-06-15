module Web.View.Users.Show where
import Web.View.Prelude
import Data.Maybe

data ShowView = ShowView { user :: User, posts :: [Post] , follow :: Maybe Follow, numOfFollowers :: Int, numOfFollowings :: Int }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <div class="row">
            <div class="col">
            </div>
            <div class="col">
                <div class="row ml-auto mr-auto text-center mt-5">
                    <img class="large-profile-image center" src={fromJust (get #pictureUrl user)}/>
                    <h3 class="center">{get #firstName user <> " " <> get #lastName user}</h3>
                    <p class="text-secondary center">{get #email user}</p>
                    <table class="table table-striped table-dark"> 
                        <tr>
                            <th>Followers</th>
                            <th>Following</th>
                            {rederFollowButtons user follow}
                        </tr>
                        <tr>
                            <td>{numOfFollowers}</td>
                            <td>{numOfFollowings}</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="col">
            </div>
        </div>
        {renderNoPosts posts}
        <div class="row mt-5">
            {forEach posts renderPosts}
        </div>
    |]
        where
            renderPosts post = [hsx|
                <div class="col col-4">
                    <a href={ShowPostAction (get #id post)}>
                        <img class="post-image-small" src={fromJust (get #pictureUrl post)}/>
                    </a>
                </div>
            |]

            renderNoPosts posts
                | length posts == 0 = [hsx|
                        <div class="row mt-5 text-center ml-auto mr-auto">
                            <div class="col">
                            </div>
                            <div class="col">
                                <h1 class="mt-5">This user does not have posts...</h1>
                            </div>
                            <div class="col">
                            </div>
                        </div>
                    |]
                | otherwise = [hsx||]

            rederFollowButtons user follow
                | not(null currentUserOrNothing) && null follow && (get #id currentUser) /= (get #id user) = 
                    [hsx|
                        <th rowspan="2">
                            <form method="POST" action={CreateFollowAction}>
                                <div class="form-group">
                                    <input name="userId" value={show (get #id user)} type="hidden" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <input name="followerId" value={show (get #id currentUser)} type="hidden" class="form-control"/>
                                </div>
                                <button type="submit" class="btn btn-light">Follow</button>
                            </form>
                        </th>
                    |]
                | not(null currentUserOrNothing) && not(null follow) && (get #id currentUser) /= (get #id user) =
                    [hsx|
                        <th rowspan="2">
                            <a href={DeleteFollowAction (get #id (fromJust follow))} class="js-delete js-delete-no-confirm mt-3 btn btn-outline-light ml-auto mr-auto">Unfollow</a>
                        </th>
                    |]
                | otherwise = [hsx||]
