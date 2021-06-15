module Web.View.Posts.Show where
import Web.View.Prelude
import Data.Maybe

data ShowView = ShowView { post :: Post, user :: User, like :: Maybe Like, numOfLikes :: Int, numOfComments :: Int, comments :: [Include "userId" Comment] }

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
                    <div class="bg-secondary mr-1 ml-1">
                        <div class="row ml-auto mr-auto">
                            {renderLikeButton like (get #id post) currentUserOrNothing}
                            <div class="ml-auto mr-3 pt-2">
                                {numOfLikes} likes
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="description">{fromJust(get #description post)}</div>
                </div>
            </div>  
        </div>
        <div class="row ml-auto mr-auto mb-3">
            <div class="col-2">
            </div>
            <div class="col">
                <h4 class="pl-4">{numOfComments} Comments</h4>
            </div>
            <div class="col-2">
            </div>
        </div>
        {renderForm (get #id post) currentUserOrNothing}
        <div class="row ml-auto mr-auto mb-5">
            {forEach comments renderComments}
        </div>
        
    |]
        where
            renderComments comment = [hsx|
                    <div class="row ml-auto mr-auto mb-3">
                        <div class="card ml-auto mr-auto comments">
                            <div class="card-header">
                                <div class="row">
                                    <a class="text-dark" href={ShowUserAction (comment |> get #userId |> get #id)}>
                                        <img class="small-profile-image ml-2" src={fromJust(comment |> get #userId |> get #pictureUrl)}/>
                                        <label class="ml-2 mt-2"><b>{(comment |> get #userId |> get #firstName) <> " " <> " " <> (comment |> get #userId |> get #lastName)}</b></label>
                                    </a>
                                    <label class="small-text ml-auto mr-2">{get #createdAt comment |> timeAgo}</label>
                                    {renderCommentActionButtons currentUserOrNothing comment}
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="description">{get #text comment}</div>
                            </div>
                        </div>
                    </div>
                |]
            renderCommentActionButtons user comment
                | null user = [hsx||]
                | (get #id (fromJust user)) == (comment |> get #userId |> get #id) = [hsx|
                        <div>
                            <a href={EditCommentAction (get #id comment)}><img class="icon darkness ml-3" src="images/edit.png"/></a>
                            <a class="js-delete" href={DeleteCommentAction (get #id comment)}><img class="icon darkness ml-1" src="images/delete.png"/></a>
                        </div>
                    |]
                | otherwise = [hsx||]
            
            renderForm postId user
                | null user = [hsx||] 
                | otherwise = [hsx|
                        <form method="POST" action={CreateCommentAction}>
                            <div class="row ml-auto mr-auto mb-3 enter-comment">
                                <div class="col">
                                    <input name="userId" value={show (get #id (fromJust user))} type="hidden" class="form-control" />
                                    <input name="postId" value={show postId} type="hidden" class="form-control"/>
                                    <div class="form-group">
                                        <textarea placeholder="Leave a comment here..." name="text" class="form-control" required="required"></textarea>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <button type="submit" class="btn btn-primary small-button-text btn-block">Comment</button>
                                </div>
                            </div>
                        </form>
                    |]

            renderActionButtons post user
                | not(null user) && (get #userId post) == (get #id currentUser) = [hsx|
                        <a href={EditPostAction (get #id post)} class="ml-auto mr-3"><img class="icon" src="/images/edit.png"/></a>
                        <a href={DeletePostAction (get #id post)} class="js-delete mr-4"><img class="icon" src="/images/delete.png"/></a>
                    |]
                | otherwise = [hsx||]

            renderLikeButton like postId user
                | null user = [hsx||]
                | not(null user) && null like = [hsx|
                        <form method="POST" action={CreateLikeAction}>
                            <input name="userId" value={show (get #id (fromJust user))} type="hidden" class="form-control" />
                            <input name="postId" value={show postId} type="hidden" class="form-control"/>
                            <button type="submit" class="btn btn-link">
                                <img class="icon brightness" src="images/heart-icon-red.png"/>
                            </button>
                        </form>
                    |]
                | otherwise = [hsx|
                        <a href={DeleteLikeAction (get #id (fromJust like))} class="js-delete js-delete-no-confirm btn btn-link">
                            <img class="icon" src="images/heart-icon-red.png"/>
                        </a>
                    |]

