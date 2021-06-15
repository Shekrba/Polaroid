module Web.View.Posts.Show where
import Web.View.Prelude
import Data.Maybe

data ShowView = ShowView { post :: Post, user :: User }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <div class="row ml-auto mr-auto">
            <div class="card bg-dark text-light mb-5 ml-auto mr-auto">
                <div class="card-head">
                    <div class="row mb-2 ml-2 mt-1">
                        <span class="small-text">{get #createdAt post |> timeAgo}</span>
                    </div>
                    <div class="row ml-1 mb-3">
                        <a href={ShowUserAction (get #id user)}>
                            <img class="small-profile-image ml-2 mr-2" src={fromJust (get #pictureUrl user)}/>
                            <label class="mt-1 text-light"><b>{get #firstName user <> " " <> get #lastName user}</b></label>
                        </a>
                        {renderActionButtons post currentUserOrNothing}
                    </div>
                    <div class="row ml-1 mr-1">
                        <img src={fromJust (get #pictureUrl post)} class="post-image-large center text-muted" alt="Image"/>
                    </div>
                </div>
                <div class="card-body">
                    <div class="description">{fromJust(get #description post)}</div>
                </div>
            </div>  
        </div>
    |]
        where
            renderActionButtons post user
                | not(null user) && (get #userId post) == (get #id currentUser) = [hsx|
                        <a href={EditPostAction (get #id post)} class="ml-auto mr-3"><img class="icon" src="/images/edit.png"/></a>
                        <a href={DeletePostAction (get #id post)} class="js-delete mr-4"><img class="icon" src="/images/delete.png"/></a>
                    |]
                | otherwise = [hsx||]

