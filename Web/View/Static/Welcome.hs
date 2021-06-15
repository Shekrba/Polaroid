module Web.View.Static.Welcome where
import Web.View.Prelude
import Data.Maybe

data WelcomeView = WelcomeView { postsUsers :: [(Post, User)] }                     

instance View WelcomeView where
    html WelcomeView { .. } = [hsx|
    {renderFeed currentUserOrNothing postsUsers}
|]

renderFeed user postsUsers
    | null user || length postsUsers == 0 = [hsx|
            <div class="bg-dark" style="padding-top: 2rem; padding-bottom: 2rem; color:hsla(196, 13%, 96%, 1); border-radius: 4px">
                <div style="max-width: 800px; margin-left: auto; margin-right: auto">
                    <h1 style="margin-bottom: 2rem; font-size: 2rem; font-weight: 300; border-bottom: 1px solid white; padding-bottom: 0.25rem; border-color: hsla(196, 13%, 60%, 1)">
                        POLAROID
                    </h1>

                    <h2 style="margin-top: 0; margin-bottom: 0rem; font-weight: 900; font-size: 3rem">
                        Welcome!
                    </h2>

                    <p style="margin-top: 1rem; font-size: 1.75rem; font-weight: 600; color:hsla(196, 13%, 80%, 1)">
                        In photography there is a reality so subtle that it becomes more real than reality.
                    </p>
                    {renderLoginButtons user}
                </div>
            </div>

            <div style="max-width: 800px; margin-left: auto; margin-right: auto; margin-top: 4rem" class="mb-5">
                <img class="center" src="https://i.pinimg.com/originals/a1/d5/83/a1d58365b611f67ac63de8e8527dd6b9.gif" alt="/ihp-welcome-icon">
            </div> 
        |]
    | otherwise = [hsx|
        <div class="row mb-5">
            <div class="col-3">
            </div>
            <div class="col">
                <h1 class="large-header">Your Feed</h1>
            </div>
            <div class="col-3">
            </div>
        </div>
        { forEach postsUsers renderPosts }
    |]


renderLoginButtons user
    | null user = [hsx|
            <div class="row ml-1">
                <a href={NewSessionAction} class="btn btn-secondary">
                    Login
                </a>
            </div>
            <div class="row mt-3 ml-1">
                <a href={NewUserAction} class="btn btn-success">
                    Create Account
                </a>
            </div>
        |]
    | otherwise = [hsx||]

renderPosts postUser = do 
    [hsx|
        <div class="row ml-auto mr-auto">
            <div class="col-3">
            </div>
            <div class="col">
                <div class="card bg-dark text-light mb-5 ml-auto mr-auto">
                    <div class="card-head">
                        <div class="row mb-2 ml-2 mt-1">
                            <span class="small-text">{get #createdAt (fst postUser) |> timeAgo}</span>
                        </div>
                        <div class="row ml-1 mb-3">
                        <a href={ShowUserAction (get #id (snd postUser))}>
                                <img class="small-profile-image ml-2 mr-2" src={fromJust (get #pictureUrl (snd postUser))}/>
                                <label class="mt-1 text-light"><b>{(get #firstName (snd postUser)) <> " " <> (get #lastName (snd postUser))}</b></label>
                            </a>
                        </div>
                        <div class="row ml-1 mr-1">
                            <a href={ShowPostAction (get #id (fst postUser))}>
                                <img class="post-image-feed" src={fromJust (get #pictureUrl (fst postUser))}/>
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="description">{fromJust(get #description (fst postUser))}</div>
                    </div>
                </div>  
            </div>
            <div class="col-3">
            </div>
        </div>
    |]
  